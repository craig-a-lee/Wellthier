//
//  FeedViewController.m
//  Wellthier
//
//  Created by Craig Lee on 7/19/22.
//

#import <Parse/Parse.h>
#import "WorkoutFeedViewController.h"
#import "HealthKitSharedManager.h"
#import "Post.h"
#import "PostCell.h"
#import "ProfileViewController.h"

@interface WorkoutFeedViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (nonatomic, strong) Post *selectedPost;

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
    cell.toProfileHiddenButton.tag = indexPath.row;
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"feedToProfileSegue"]) {
        Post *selectedPost = self.arrayOfPosts[[sender tag]];
        PFUser *userToPass = selectedPost.author;
        NSLog(@"%@", selectedPost.author.username);
        ProfileViewController *profileController = [segue destinationViewController];
        profileController.selectedUser = userToPass;
    }
}

@end
