//
//  FeedViewController.m
//  Wellthier
//
//  Created by Craig Lee on 7/19/22.
//

#import "WorkoutFeedViewController.h"
#import "HealthKitSharedManager.h"
#import "Parse/Parse.h"
#import "Post.h"
#import "PostCell.h"

@interface WorkoutFeedViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end

@implementation WorkoutFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Home";
    [self.navigationController.navigationBar setTitleTextAttributes:
       @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [[HealthKitSharedManager sharedManager] requestAuthorization];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(beginRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    [self getTimeline];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)beginRefresh:(UIRefreshControl *)refreshControl {
    // Create NSURL and NSURLRequest
    [self getTimeline];
}

- (void)getTimeline{
        PFQuery *postQuery = [Post query];
        [postQuery orderByDescending:@"createdAt"];
        [postQuery includeKey:@"author"];
        postQuery.limit = 20;
        // fetch data asynchronously
        [postQuery findObjectsInBackgroundWithBlock:^(NSArray<Post *> * _Nullable posts, NSError * _Nullable error) {
            if (posts) {
                // do something with the data fetched
                self.arrayOfPosts = posts;
                [self.tableView reloadData];
                [self.refreshControl endRefreshing];
            }
            else {
            }
        }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayOfPosts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PostCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"PostCell"];
    Post *post = self.arrayOfPosts[indexPath.row];
    cell.detailPost = post;
    [cell setPostDetails:cell.detailPost];
    return cell;
}



@end
