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

@property (nonatomic, weak) IBOutlet UILabel *workoutType;
@property (nonatomic, weak) IBOutlet UILabel *startDateInfo;
@property (nonatomic, weak) IBOutlet UILabel *endDate;
@property (nonatomic, weak) IBOutlet UILabel *durationInfo;
@property (nonatomic, weak) IBOutlet UILabel *energyBurnedInfo;
@property (nonatomic, strong) HKWorkout *workout;

@end

NS_ASSUME_NONNULL_END
