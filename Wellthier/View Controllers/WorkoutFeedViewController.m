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

@interface WorkoutFeedViewController () <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (nonatomic, strong) Post *selectedPost;
@property (nonatomic, assign) BOOL isMoreDataLoading;
@property (nonatomic, assign) int numberOfPostsToSkip;
@property (nonatomic, strong) UITapGestureRecognizer *tap;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *loadingMoreDataIndicator;
@property (nonatomic, weak) UIImageView *prevImageView;

@end

@implementation WorkoutFeedViewController

BOOL isFullScreen;

CGRect prevFrame;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Home";
    [self.navigationController.navigationBar setTitleTextAttributes:
       @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    isFullScreen = false;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]
      initWithTarget:self action:@selector(handleTap:)];
    tapGesture.delegate = self;
    [self.tableView addGestureRecognizer:tapGesture];
//    self.tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgToFullScreen)];;
//    self.tap.delegate = self;
//    [self.view addGestureRecognizer:self.tap];
    [[HealthKitSharedManager sharedManager] requestAuthorization];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl setTintColor:[UIColor whiteColor]];
    [self.refreshControl addTarget:self action:@selector(beginRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    self.tableView.layoutMargins = UIEdgeInsetsZero;
    self.tableView.separatorInset = UIEdgeInsetsZero;
}

- (void)handleTap:(UITapGestureRecognizer *)gestureRecognizer {
    CGPoint p = [gestureRecognizer locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:p];
    if (indexPath == nil) {
    } else if (gestureRecognizer.state == UIGestureRecognizerStateBegan || gestureRecognizer.state == 2) {
        PostCell *postCell = [self.tableView cellForRowAtIndexPath:indexPath];
        if (postCell.postImageView == gestureRecognizer.view) {
            self.prevImageView = postCell.postImageView;
            [self imgToFullScreen];
        }
    }
}

//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
//    BOOL shouldReceiveTouch = YES;
//
//    if (gestureRecognizer == self.tap) {
//        CGPoint p = [gestureRecognizer locationInView:self.tableView];
//        NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:p];
//        if (indexPath != nil) {
//            Post *post = self.arrayOfPosts[indexPath.row];
//            NSLog(@"%@", post.author.username);
//            //if (post[@"image"]) {
//                //PostCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
//                shouldReceiveTouch = (touch.view == self.prevImageView);
//            //}
//        }
//        
//    }
//    return shouldReceiveTouch;
//}

-(void)imgToFullScreen{
    if (!isFullScreen) {
        [UIView animateWithDuration:0.5 delay:0 options:0 animations:^{
            //save previous frame
            prevFrame = self.prevImageView.frame;
            [self.prevImageView setFrame:[[UIScreen mainScreen] bounds]];
        }completion:^(BOOL finished){
            isFullScreen = true;
        }];
        return;
    } else {
        [UIView animateWithDuration:0.5 delay:0 options:0 animations:^{
            [self.prevImageView setFrame:prevFrame];
        }completion:^(BOOL finished){
            isFullScreen = false;
        }];
        return;
    }
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
