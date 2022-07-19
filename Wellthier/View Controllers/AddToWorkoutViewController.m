//
//  AddToWorkoutViewController.m
//  Wellthier
//
//  Created by Craig Lee on 7/18/22.
//

#import "AddToWorkoutViewController.h"
#import "Parse/Parse.h"
#import "Workout.h"
#import "WorkoutTableViewCell.h"

@interface AddToWorkoutViewController () <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation AddToWorkoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self getWorkouts];
}

- (void)getWorkouts {
    PFQuery *workoutQuery = [Workout query];
    [workoutQuery includeKey:@"author"];
    [workoutQuery whereKey:@"author" equalTo:PFUser.currentUser];
    [workoutQuery whereKey:@"title" notEqualTo:@"Liked Exercises"];
    [workoutQuery findObjectsInBackgroundWithBlock:^(NSArray<Workout *> * _Nullable workouts, NSError * _Nullable error) {
        if (workouts) {
            self.arrayOfWorkouts = workouts;
            self.filteredWorkouts = workouts;
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
    cell.workoutImageView.file = workout[@"image"];
    [cell.workoutImageView loadInBackground];
    PFUser *user = workout[@"author"];
    cell.workoutName.text = workout.title;
    cell.workoutAuthorInfo.text = user.username;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    WorkoutTableViewCell *selectedCell= [self.tableView cellForRowAtIndexPath:indexPath];
    selectedCell.accessoryType = UITableViewCellAccessoryCheckmark;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
     [tableView deselectRowAtIndexPath:indexPath animated:YES];
     WorkoutTableViewCell *selectedCell= [self.tableView cellForRowAtIndexPath:indexPath];
     selectedCell.accessoryType = UITableViewCellAccessoryNone;
 }

@end
