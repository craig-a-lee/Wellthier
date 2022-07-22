//
//  LibraryViewController.m
//  Wellthier
//
//  Created by Craig Lee on 7/13/22.
//

#import "LibraryViewController.h"
#import "Parse/Parse.h"
#import "Workout.h"
#import "WorkoutCollectionViewCell.h"
#import "WorkoutViewController.h"
#import "NewWorkoutViewController.h"
#import "AddToWorkoutViewController.h"

@interface LibraryViewController () <AddToWorkoutViewControllerDelegate, NewWorkoutViewControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation LibraryViewController

- (void)viewDidLoad {
    [self.activityIndicator startAnimating];
    [super viewDidLoad];
    self.title = @"Profile";
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.currentUser = PFUser.currentUser;
    self.profilePic.file = self.currentUser[@"profilePic"];
    [self.profilePic loadInBackground];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getWorkouts];
}

- (void) getWorkouts {
    PFQuery *workoutQuery = [Workout query];
    [workoutQuery includeKey:@"author"];
    [workoutQuery whereKey:@"author" equalTo:PFUser.currentUser];
    [workoutQuery findObjectsInBackgroundWithBlock:^(NSArray<Workout *> * _Nullable workouts, NSError * _Nullable error) {
        if (workouts) {
            self.arrayOfWorkouts = (NSMutableArray *) workouts;
            self.filteredWorkouts = (NSMutableArray *) workouts;
            [self.collectionView reloadData];
            [self.activityIndicator stopAnimating];
        }
    }];
}

- (void) didCreateWorkout {
    [self getWorkouts];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.filteredWorkouts.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WorkoutCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WorkoutCell" forIndexPath:indexPath];
    Workout *workout = self.filteredWorkouts[indexPath.row];
    cell.workoutImageView.file = workout[@"image"];
    [cell.workoutImageView loadInBackground];
    cell.workoutAuthorInfo.text = self.currentUser[@"displayName"];
    cell.workoutTitle.text = workout.title;
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"workoutSegueFromProfile"]) {
        NSIndexPath *indexPath = [self.collectionView indexPathForCell:sender];
        Workout *selectedWorkout = self.filteredWorkouts[indexPath.row];
        WorkoutViewController *wVC = [segue destinationViewController];
        wVC.detailWorkout = selectedWorkout;
    } else if ([segue.identifier isEqualToString:@"profileToNewWorkoutSegue"]) {
        NewWorkoutViewController *controller = [segue destinationViewController];
        controller.delegate = self;
    }
}

@end
