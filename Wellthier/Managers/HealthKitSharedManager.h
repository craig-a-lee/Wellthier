//
//  HealthKitSharedManager.h
//  Wellthier
//
//  Created by Craig Lee on 7/20/22.
//

#import <Foundation/Foundation.h>
#import "HealthKit/HealthKit.h"

NS_ASSUME_NONNULL_BEGIN

@interface HealthKitSharedManager : NSObject

@property (nonatomic, retain) HKHealthStore *healthStore;

+ (id)sharedManager;
- (void)requestAuthorization;
- (HKWorkout*) getLatestWorkout;

@end

NS_ASSUME_NONNULL_END
