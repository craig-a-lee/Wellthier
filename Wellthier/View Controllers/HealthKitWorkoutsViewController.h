//
//  HealthKitWorkoutsViewController.h
//  Wellthier
//
//  Created by Craig Lee on 7/25/22.
//

#import <HealthKit/HealthKit.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HealthKitWorkoutsViewController : UIViewController

@property (nonatomic, strong) NSArray <HKWorkout *> *arrayOfWorkouts;

@end

NS_ASSUME_NONNULL_END
