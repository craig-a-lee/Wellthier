//
//  HealthKitWorkoutsViewController.m
//  Wellthier
//
//  Created by Craig Lee on 7/25/22.
//


#import <DateTools/DateTools.h>
#import "HealthKitWorkoutsViewController.h"
#import "HealthKitWorkoutTableViewCell.h"
#import "HealthKitSharedManager.h"

@interface HealthKitWorkoutsViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) HealthKitWorkoutTableViewCell *currentlySelectedCell;

@end

@implementation HealthKitWorkoutsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    [self getWorkouts];
}

- (void)getWorkouts {
    [[HealthKitSharedManager sharedManager] getLatestWorkout:^(NSArray<HKWorkout *> * _Nonnull workouts) {
        self.arrayOfWorkouts = workouts;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayOfWorkouts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateStyle = NSDateFormatterMediumStyle;
    dateFormatter.timeStyle = NSDateFormatterNoStyle;
    [dateFormatter setDateFormat:@"MM-dd-yyyy HH:mm:ss"];
    HealthKitWorkoutTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HealthKitWorkoutTableViewCell"];
    HKWorkout *workout = self.arrayOfWorkouts[indexPath.row];
    cell.workoutType.text = [NSString stringWithFormat:@"Workout Type: %@", [[HealthKitSharedManager sharedManager] getWorkoutType: workout.workoutActivityType]];
    cell.startDate.text = [NSString stringWithFormat:@"Start Date: %@", [dateFormatter stringFromDate:workout.startDate]];
    cell.endDate.text = [NSString stringWithFormat:@"End Date: %@", [dateFormatter stringFromDate:workout.endDate]];
    cell.duration.text = [NSString stringWithFormat:@"Duration: %f", workout.duration];
    if (workout.totalEnergyBurned) {
        cell.energyBurned.text = [NSString stringWithFormat:@"Energy Burned: %@", workout.totalEnergyBurned];
    }
    return cell;
}

- (IBAction)didTapCancel:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HealthKitWorkoutTableViewCell *selectedCell= [self.tableView cellForRowAtIndexPath:indexPath];
    selectedCell.accessoryType = UITableViewCellAccessoryCheckmark;
    self.currentlySelectedCell = selectedCell;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HealthKitWorkoutTableViewCell *selectedCell= [self.tableView cellForRowAtIndexPath:indexPath];
    selectedCell.accessoryType = UITableViewCellAccessoryNone;
 }


@end
