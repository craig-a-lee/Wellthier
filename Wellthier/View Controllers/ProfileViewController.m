//
//  ProfileViewController.m
//  Wellthier
//
//  Created by Craig Lee on 7/21/22.
//

#import "ProfileViewController.h"
#import "Workout.h"
#import "WorkoutTableViewCell.h"
#import "PostCell.h"
#import "WorkoutViewController.h"

@interface ProfileViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.segmentedControl setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}
                                                             forState:UIControlStateNormal];
    [self getWorkouts];
    [self getPosts];
    [self setProfileParams];
}

- (void) setProfileParams {
    self.displayName.text = self.selectedUser[@"displayName"];
    self.username.text = self.selectedUser.username;
    self.profilePic.file = self.selectedUser[@"profilePic"];
    [self.profilePic loadInBackground];
}

- (void) getWorkouts {
    PFQuery *workoutQuery = [Workout query];
    [workoutQuery includeKey:@"author"];
    [workoutQuery whereKey:@"author" equalTo:self.selectedUser];
    [workoutQuery findObjectsInBackgroundWithBlock:^(NSArray<Workout *> * _Nullable workouts, NSError * _Nullable error) {
        if (workouts) {
            self.arrayOfWorkouts = (NSMutableArray *) workouts;
            [self.tableView reloadData];
        }
    }];
}

- (void) getPosts {
    PFQuery *postQuery = [Post query];
    [postQuery orderByDescending:@"createdAt"];
    [postQuery includeKey:@"author"];
    [postQuery whereKey:@"author" equalTo:self.selectedUser];
    postQuery.limit = 20;
    [postQuery findObjectsInBackgroundWithBlock:^(NSArray<Post *> * _Nullable posts, NSError * _Nullable error) {
        if (posts) {
            self.arrayOfPosts = posts;
            [self.tableView reloadData];
        }
        else {
        }
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([self.segmentedControl selectedSegmentIndex] == 0) {
        return self.arrayOfWorkouts.count;
    } else {
        return self.arrayOfPosts.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.segmentedControl selectedSegmentIndex] == 0) {
        WorkoutTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"WorkoutTableViewCell"];
        Workout *workout = self.arrayOfWorkouts[indexPath.row];
        cell.workoutImageView.file = workout[@"image"];
        [cell.workoutImageView loadInBackground];
        PFUser *user = workout[@"author"];
        cell.workoutName.text = workout.title;
        cell.workoutAuthorInfo.text = user.username;
        cell.workout = workout;
        return cell;
    } else {
        PostCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"PostCell"];
        Post *post = self.arrayOfPosts[indexPath.row];
        cell.detailPost = post;
        [cell setPostDetails:cell.detailPost];
        return cell;
    }
}

- (IBAction)segmentIndexChanged:(id)sender {
    [self.tableView reloadData];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"workoutSegueFromProfile"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        Workout *selectedWorkout = self.arrayOfWorkouts[indexPath.row];
        WorkoutViewController *wVC = [segue destinationViewController];
        wVC.detailWorkout = selectedWorkout;
    }
}

@end
