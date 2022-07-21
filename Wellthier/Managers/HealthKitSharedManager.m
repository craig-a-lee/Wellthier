//
//  HealthKitSharedManager.m
//  Wellthier
//
//  Created by Craig Lee on 7/20/22.
//

#import "HealthKitSharedManager.h"

@implementation HealthKitSharedManager

+ (id)sharedManager {
    static HealthKitSharedManager *commonManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        commonManager = [[self alloc] init];
        commonManager.healthStore = [[HKHealthStore alloc] init];
    });
    return commonManager;
}

- (void) requestAuthorization {
    if (![HKHealthStore isHealthDataAvailable]) {
        return;
    }
    
    NSSet *readTypes = [[NSSet alloc] initWithArray:@[[HKObjectType workoutType], [HKSeriesType activitySummaryType], [HKSeriesType workoutType]]];
    
    [self.healthStore requestAuthorizationToShareTypes:nil readTypes:readTypes completion:^(BOOL success, NSError * _Nullable error) {
        
    }];
}

- (void) getLatestWorkout: (void(^)(HKWorkout *workout))completion {
    HKObjectType *type = [HKObjectType workoutType];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey: HKSampleSortIdentifierStartDate ascending:false];
    HKQuery *query = [[HKSampleQuery alloc] initWithSampleType:type predicate:nil limit:HKObjectQueryNoLimit sortDescriptors:@[sortDescriptor] resultsHandler:^(HKSampleQuery * _Nonnull query, NSArray<__kindof HKSample *> * _Nullable results, NSError * _Nullable error) {
        if (results.count > 0) {
            completion(results[0]);
        } else {
            completion(nil);
        }
    }];
    [self.healthStore executeQuery:query];
}

@end
