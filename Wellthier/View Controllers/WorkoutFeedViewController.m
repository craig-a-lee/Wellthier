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
#import "PostDetailsViewController.h"

@interface WorkoutFeedViewController () <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (nonatomic, strong) Post *selectedPost;
@property (nonatomic, assign) BOOL isMoreDataLoading;
@property (nonatomic, assign) int numberOfPostsToSkip;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingMoreDataIndicator;

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
    [self.refreshControl setTintColor:[UIColor whiteColor]];
    [self.refreshControl addTarget:self action:@selector(beginRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    self.tableView.layoutMargins = UIEdgeInsetsZero;
    self.tableView.separatorInset = UIEdgeInsetsZero;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.arrayOfPosts = [NSArray new];
    self.numberOfPostsToSkip = 0;
    [self getTimeline];
}

- (void)beginRefresh:(UIRefreshControl *)refreshControl {
    [self getTimeline];
}

- (void)getTimeline {
    PFQuery *postQuery = [Post query];
    [postQuery orderByDescending:@"createdAt"];
    [postQuery includeKey:@"author"];
    [postQuery setSkip:self.numberOfPostsToSkip];
    postQuery.limit = 5;
    [postQuery findObjectsInBackgroundWithBlock:^(NSArray<Post *> * _Nullable posts, NSError * _Nullable error) {
        if (posts) {
            self.isMoreDataLoading = false;
            self.arrayOfPosts = [self.arrayOfPosts arrayByAddingObjectsFromArray:posts];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
            [self.loadingMoreDataIndicator stopAnimating];
            [self.refreshControl endRefreshing];
            self.numberOfPostsToSkip += 5;
        }
        else {
        }
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (!self.isMoreDataLoading) {
        int scrollViewContentHeight = self.tableView.contentSize.height;
        int scrollOffsetThreshold = scrollViewContentHeight - self.tableView.bounds.size.height;
        
        if(scrollView.contentOffset.y > scrollOffsetThreshold && self.tableView.isDragging) {
            self.isMoreDataLoading = true;
            [self.loadingMoreDataIndicator startAnimating];
            [self getTimeline];
        }
    }
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

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    Post *selectedPost = self.arrayOfPosts[[sender tag]];
    if (!selectedPost.image && [identifier isEqualToString:@"expandedPicSegue"]) {
        return NO;
    } else {
        return YES;
    }
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"feedToProfileSegue"]) {
        Post *selectedPost = self.arrayOfPosts[[sender tag]];
        PFUser *userToPass = selectedPost.author;
        ProfileViewController *profileController = [segue destinationViewController];
        profileController.selectedUser = userToPass;
    } else if ([segue.identifier isEqualToString:@"expandedPicSegue"]) {
        Post *selectedPost = self.arrayOfPosts[[sender tag]];
        PostDetailsViewController *detailsController = [segue destinationViewController];
        detailsController.pictureView.file = selectedPost[@"image"];
    }
}

@end
