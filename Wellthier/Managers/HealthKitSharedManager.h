//
//  HealthKitSharedManager.h
//  Wellthier
//
//  Created by Craig Lee on 7/20/22.
//

#import <Foundation/Foundation.h>
#import <HealthKit/HealthKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HealthKitSharedManager : NSObject

@property (nonatomic, retain) HKHealthStore *healthStore;

+ (id)sharedManager;
- (void)requestAuthorization;
- (void)getLatestWorkout:(void(^)(NSArray <HKWorkout *> *workouts))completion;

@end

NSString *WellthierAppGetWorkoutType(HKWorkoutActivityType enumeration);
NSString *WellthierAppFormattedDuration(NSTimeInterval interval);

NS_ASSUME_NONNULL_END
