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

@interface WorkoutFeedViewController () <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *loadingMoreDataIndicator;
@property (nonatomic, weak) UIImageView *prevImageView;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (nonatomic, strong) UIImageView *fullScreenImageView;
@property (nonatomic, strong) UIScrollView *fullScreenScrollView;
@property (nonatomic, strong) Post *selectedPost;
@property (nonatomic, strong) UITapGestureRecognizer *tap;
@property (nonatomic, assign) BOOL isMoreDataLoading;
@property (nonatomic, assign) int numberOfPostsToSkip;

@end

@implementation WorkoutFeedViewController

CGFloat lastScale;

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

- (void)handleTap:(UITapGestureRecognizer *)gestureRecognizer {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:gestureRecognizer.view.tag inSection:0];
    PostCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    if (cell.postImageView.image != nil) {
        self.prevImageView = (UIImageView *) gestureRecognizer.view;
        [self animateFullScreenImage];
    }
}

- (void) handleDismissingPicture:(UITapGestureRecognizer *)gestureRecognizer {
    self.tableView.hidden = NO;
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = NO;
    [self.fullScreenScrollView removeFromSuperview];
}

- (void)handlePinchGesture:(UIPinchGestureRecognizer *)pinch {
    UIView *pinchView = pinch.view;
    CGRect bounds = pinchView.bounds;
    CGPoint pinchCenter = [pinch locationInView:pinchView];
    pinchCenter.x -= CGRectGetMidX(bounds);
    pinchCenter.y -= CGRectGetMidY(bounds);
    CGAffineTransform transform = pinchView.transform;
    transform = CGAffineTransformTranslate(transform, pinchCenter.x, pinchCenter.y);
    CGFloat scale = pinch.scale;
    transform = CGAffineTransformScale(transform, scale, scale);
    transform = CGAffineTransformTranslate(transform, -pinchCenter.x, -pinchCenter.y);
    pinchView.transform = transform;
    pinch.scale = 1.0;
}

- (void)animateFullScreenImage {
    self.fullScreenScrollView = [UIScrollView new];
    self.fullScreenScrollView.frame = self.view.frame;
    self.fullScreenScrollView.userInteractionEnabled = YES;
    self.fullScreenScrollView.layer.zPosition = MAXFLOAT;
    self.fullScreenScrollView.center = self.tableView.center;
    [self.view addSubview:self.fullScreenScrollView];
    [UIView animateWithDuration:0.5 delay:0 options:0 animations:^{
        self.fullScreenImageView = [UIImageView new];
        self.fullScreenImageView.layer.zPosition = MAXFLOAT;
        self.fullScreenImageView.image = self.prevImageView.image;
        self.fullScreenImageView.contentMode = UIViewContentModeScaleAspectFit;
        self.fullScreenImageView.center = self.tableView.center;
        self.fullScreenImageView.frame = self.view.frame;
        [self.fullScreenScrollView addSubview:self.fullScreenImageView];
        UITapGestureRecognizer *singleTapGesture = [[UITapGestureRecognizer alloc]
                                                initWithTarget:self action:@selector(handleDismissingPicture:)];
        singleTapGesture.numberOfTapsRequired = 1;
        UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc]
                                                  initWithTarget:self action:@selector(handlePinchGesture:)];
        singleTapGesture.delegate = self;
        self.fullScreenScrollView.bouncesZoom = YES;
        self.fullScreenScrollView.clipsToBounds = YES;
        pinchGesture.delegate = self;
        [self.fullScreenScrollView addGestureRecognizer:singleTapGesture];
        [self.fullScreenScrollView addGestureRecognizer:pinchGesture];
        self.tableView.hidden = YES;
        self.navigationController.navigationBarHidden = YES;
        self.tabBarController.tabBar.hidden = YES;
    } completion: nil];
    return;
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
            __weak WorkoutFeedViewController *weakSelf = self;
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.tableView reloadData];
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
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]
      initWithTarget:self action:@selector(handleTap:)];
    tapGesture.delegate = self;
    PostCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"PostCell"];
    Post *post = self.arrayOfPosts[indexPath.row];
    cell.detailPost = post;
    [cell setPostDetails:cell.detailPost];
    cell.toProfileHiddenButton.tag = indexPath.row;
    [cell.postImageView addGestureRecognizer:tapGesture];
    cell.postImageView.tag = indexPath.row;
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"feedToProfileSegue"]) {
        Post *selectedPost = self.arrayOfPosts[[sender tag]];
        PFUser *userToPass = selectedPost.author;
        ProfileViewController *profileController = [segue destinationViewController];
        profileController.selectedUser = userToPass;
    }
}

@end
