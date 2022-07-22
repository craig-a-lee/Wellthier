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
#import "ProfileViewController.h"

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
    [self getTimeline];
}

- (void)getTimeline {
        PFQuery *postQuery = [Post query];
        [postQuery orderByDescending:@"createdAt"];
        [postQuery includeKey:@"author"];
        postQuery.limit = 20;
        [postQuery findObjectsInBackgroundWithBlock:^(NSArray<Post *> * _Nullable posts, NSError * _Nullable error) {
            if (posts) {
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"feedToProfileSegue"]) {
        NSIndexPath *indexPathOfSelectedPost = [self.tableView indexPathForCell:sender];
        Post *selectedPost = self.arrayOfPosts[indexPathOfSelectedPost.row];
        PFUser *userToPass = selectedPost.author;
        ProfileViewController *profileController = [segue destinationViewController];
        profileController.selectedUser = userToPass;
    }
}

@end
