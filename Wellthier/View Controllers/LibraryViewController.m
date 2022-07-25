//
//  LibraryViewController.m
//  Wellthier
//
//  Created by Craig Lee on 7/13/22.
//

#import <Parse/Parse.h>
#import "LibraryViewController.h"
#import "Workout.h"
#import "WorkoutCollectionViewCell.h"
#import "WorkoutViewController.h"
#import "NewWorkoutViewController.h"
#import "AddToWorkoutViewController.h"
#import "ProfileViewController.h"

@interface LibraryViewController () <AddToWorkoutViewControllerDelegate, NewWorkoutViewControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation LibraryViewController

- (void)viewDidLoad {
    [self.activityIndicator startAnimating];
    [super viewDidLoad];
    self.title = @"Workouts";
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.currentUser = PFUser.currentUser;
    self.profilePic.file = self.currentUser[@"profilePic"];
    self.displayName.text = self.currentUser[@"displayName"];
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
    [cell setParams:workout];
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"workoutSegueFromLibrary"]) {
        NSIndexPath *indexPath = [self.collectionView indexPathForCell:sender];
        Workout *selectedWorkout = self.filteredWorkouts[indexPath.row];
        WorkoutViewController *wVC = [segue destinationViewController];
        wVC.detailWorkout = selectedWorkout;
    } else if ([segue.identifier isEqualToString:@"libraryToNewWorkoutSegue"]) {
        NewWorkoutViewController *controller = [segue destinationViewController];
        controller.delegate = self;
    } else if ([segue.identifier isEqualToString:@"libraryToProfileSegue"]) {
        ProfileViewController *controller = [segue destinationViewController];
        controller.selectedUser = PFUser.currentUser;
    }
        
}

@end
