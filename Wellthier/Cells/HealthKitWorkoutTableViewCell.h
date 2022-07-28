//
//  HealthKitWorkoutTableViewCell.h
//  Wellthier
//
//  Created by Craig Lee on 7/25/22.
//

#import <HealthKit/HealthKit.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HealthKitWorkoutTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *workoutTypeLabel;
@property (nonatomic, weak) IBOutlet UILabel *startDateLabel;
@property (nonatomic, weak) IBOutlet UILabel *endDateLabel;
@property (nonatomic, weak) IBOutlet UILabel *durationLabel;
@property (nonatomic, weak) IBOutlet UILabel *energyBurnedLabel;
@property (nonatomic, strong) HKWorkout *workout;

@end

NS_ASSUME_NONNULL_END
