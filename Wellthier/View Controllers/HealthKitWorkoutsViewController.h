//
//  HealthKitWorkoutsViewController.h
//  Wellthier
//
//  Created by Craig Lee on 7/25/22.
//

#import <HealthKit/HealthKit.h>
#import <UIKit/UIKit.h>
#import "HealthKitWorkoutTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@protocol HealtKitWorkoutsViewControllerDelegate

- (void)didPickWorkout:(HKWorkout *) workout;

@end

@interface HealthKitWorkoutsViewController : UIViewController

@property (nonatomic, weak) id<HealtKitWorkoutsViewControllerDelegate> delegate;
@property (nonatomic, strong) NSArray <HKWorkout *> *arrayOfWorkouts;

@end

NS_ASSUME_NONNULL_END
