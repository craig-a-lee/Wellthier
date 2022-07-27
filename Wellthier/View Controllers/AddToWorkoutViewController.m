//
//  AddToWorkoutViewController.m
//  Wellthier
//
//  Created by Craig Lee on 7/18/22.
//

#import <Parse/Parse.h>
#import "AddToWorkoutViewController.h"
#import "Workout.h"
#import "WorkoutTableViewCell.h"

@interface AddToWorkoutViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) WorkoutTableViewCell *currentlySelectedCell;

@end

@implementation AddToWorkoutViewController

- (void) viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.currentlySelectedCell = nil;
    self.searchBar.delegate = self;
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getWorkouts];
}

- (void) getWorkouts {
    PFQuery *workoutQuery = [Workout query];
    [workoutQuery includeKey:@"author"];
    [workoutQuery whereKey:@"author" equalTo:PFUser.currentUser];
    [workoutQuery whereKey:@"title" notEqualTo:@"Liked Exercises"];
    [workoutQuery findObjectsInBackgroundWithBlock:^(NSArray<Workout *> * _Nullable workouts, NSError * _Nullable error) {
        if (workouts) {
            self.arrayOfWorkouts = workouts;
            self.filteredWorkouts = [[workouts reverseObjectEnumerator] allObjects];

            [self.tableView reloadData];
        }
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        return self.filteredWorkouts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WorkoutTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"WorkoutTableViewCell"];
    Workout *workout = self.filteredWorkouts[indexPath.row];
    [cell setCellParams:workout];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    WorkoutTableViewCell *selectedCell= [self.tableView cellForRowAtIndexPath:indexPath];
    selectedCell.accessoryType = UITableViewCellAccessoryCheckmark;
    self.currentlySelectedCell = selectedCell;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    WorkoutTableViewCell *selectedCell= [self.tableView cellForRowAtIndexPath:indexPath];
    selectedCell.accessoryType = UITableViewCellAccessoryNone;
 }

- (IBAction)didTapDone:(id)sender {
    if (self.currentlySelectedCell) {
        Workout *workout = self.currentlySelectedCell.workout;
        [Workout updateUserWorkout:workout withExercise:self.selectedExercise withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
            [self dismissViewControllerAnimated:true completion:nil];
        }];
    }
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    searchText = [searchText lowercaseString];
    if (searchText.length != 0) {
        NSPredicate *searchPredicate = [NSPredicate predicateWithBlock:^BOOL(Workout *evaluatedObject, NSDictionary *bindings) {
            return ([evaluatedObject.title containsString:searchText]);
        }];
        self.filteredWorkouts = (NSMutableArray *) [self.arrayOfWorkouts filteredArrayUsingPredicate:searchPredicate];
    }
    else {
        self.filteredWorkouts = self.arrayOfWorkouts;
    }
    [self.tableView reloadData];
}


- (IBAction)didTapCancel:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

@end
