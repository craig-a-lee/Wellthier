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

- (void) getLatestWorkout: (void(^)(NSArray <HKWorkout *> *workouts))completion {
    HKObjectType *type = [HKObjectType workoutType];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey: HKSampleSortIdentifierStartDate ascending:false];
    HKQuery *query = [[HKSampleQuery alloc] initWithSampleType:type predicate:nil limit:HKObjectQueryNoLimit sortDescriptors:@[sortDescriptor] resultsHandler:^(HKSampleQuery * _Nonnull query, NSArray<__kindof HKSample *> * _Nullable results, NSError * _Nullable error) {
        if (results.count > 0) {
            completion(results);
        } else {
            completion(nil);
        }
    }];
    [self.healthStore executeQuery:query];
}

- (NSString *) getWorkoutType: (HKWorkoutActivityType)workoutType{
    switch (workoutType) {
        case HKWorkoutActivityTypeAmericanFootball:
            return @"American Football";
        case HKWorkoutActivityTypeArchery:
            return @"Archery";
        case HKWorkoutActivityTypeAustralianFootball:
            return @"Australian Football";
        case HKWorkoutActivityTypeBadminton:
            return @"Badminton";
        case HKWorkoutActivityTypeBaseball:
            return @"Baseball";
        case HKWorkoutActivityTypeBasketball:
            return @"Basketball";
        case HKWorkoutActivityTypeBowling:
            return @"Bowling";
        case HKWorkoutActivityTypeBoxing:
            return @"Boxing";
        case HKWorkoutActivityTypeClimbing:
            return @"Climbing";
        case HKWorkoutActivityTypeCrossTraining:
            return @"Cross Training";
        case HKWorkoutActivityTypeCurling:
            return @"Curling";
        case HKWorkoutActivityTypeCycling:
            return @"Cycling";
        case HKWorkoutActivityTypeSocialDance:
        case HKWorkoutActivityTypeCardioDance:
            return @"Dance";
        case HKWorkoutActivityTypeElliptical:
            return @"Elliptical";
        case HKWorkoutActivityTypeEquestrianSports:
            return @"Equestrian Sports";
        case HKWorkoutActivityTypeFencing:
            return @"Fencing";
        case HKWorkoutActivityTypeFishing:
            return @"Fishing";
        case HKWorkoutActivityTypeFunctionalStrengthTraining:
            return @"Functional Strength Training";
        case HKWorkoutActivityTypeGolf:
            return @"Golf";
        case HKWorkoutActivityTypeGymnastics:
            return @"Gymnastics";
        case HKWorkoutActivityTypeHandball:
            return @"Handball";
        case HKWorkoutActivityTypeHiking:
            return @"Hiking";
        case HKWorkoutActivityTypeHockey:
            return @"Hockey";
        case HKWorkoutActivityTypeHunting:
            return @"Hunting";
        case HKWorkoutActivityTypeLacrosse:
            return @"Lacrosse";
        case HKWorkoutActivityTypeMartialArts:
            return @"Martial Arts";
        case HKWorkoutActivityTypeMindAndBody:
            return @"Mind and Body";
        case HKWorkoutActivityTypePaddleSports:
            return @"Paddle Sports";
        case HKWorkoutActivityTypePlay:
            return @"Play";
        case HKWorkoutActivityTypePreparationAndRecovery:
            return @"Preparation and Recovery";
        case HKWorkoutActivityTypeRacquetball:
            return @"Racquetball";
        case HKWorkoutActivityTypeRowing:
            return @"Rowing";
        case HKWorkoutActivityTypeRugby:
            return @"Rugby";
        case HKWorkoutActivityTypeRunning:
            return @"Running";
        case HKWorkoutActivityTypeSailing:
            return @"Sailing";
        case HKWorkoutActivityTypeSkatingSports:
            return @"Skating Sports";
        case HKWorkoutActivityTypeSnowSports:
            return @"Snow Sports";
        case HKWorkoutActivityTypeSoccer:
            return @"Soccer";
        case HKWorkoutActivityTypeSoftball:
            return @"Softball";
        case HKWorkoutActivityTypeSquash:
            return @"Squash";
        case HKWorkoutActivityTypeStairClimbing:
            return @"Stair Climbing";
        case HKWorkoutActivityTypeSurfingSports:
            return @"Surfing Sports";
        case HKWorkoutActivityTypeSwimming:
            return @"Swimming";
        case HKWorkoutActivityTypeTableTennis:
            return @"Table Tennis";
        case HKWorkoutActivityTypeTennis:
            return @"Tennis";
        case HKWorkoutActivityTypeTrackAndField:
            return @"Track and Field";
        case HKWorkoutActivityTypeTraditionalStrengthTraining:
            return @"Traditional Strength Training";
        case HKWorkoutActivityTypeVolleyball:
            return @"Volleyball";
        case HKWorkoutActivityTypeWalking:
            return @"Walking";
        case HKWorkoutActivityTypeWaterFitness:
            return @"Water Fitness";
        case HKWorkoutActivityTypeWaterPolo:
            return @"Water Polo";
        case HKWorkoutActivityTypeWaterSports:
            return @"Water Sports";
        case HKWorkoutActivityTypeWrestling:
            return @"Wrestling";
        case HKWorkoutActivityTypeYoga:
            return @"Yoga";
        case HKWorkoutActivityTypeBarre:
            return @"Barre";
        case HKWorkoutActivityTypeCoreTraining:
            return @"Core Training";
        case HKWorkoutActivityTypeCrossCountrySkiing:
            return @"Cross Country Skiing";
        case HKWorkoutActivityTypeDownhillSkiing:
            return @"Downhill Skiing";
        case HKWorkoutActivityTypeFlexibility:
            return @"Flexibility";
        case HKWorkoutActivityTypeHighIntensityIntervalTraining:
            return @"High Intensity Interval Training";
        case HKWorkoutActivityTypeJumpRope:
            return @"Jump Rope";
        case HKWorkoutActivityTypeKickboxing:
            return @"Kickboxing";
        case HKWorkoutActivityTypePilates:
            return @"Pilates";
        case HKWorkoutActivityTypeSnowboarding:
            return @"Snowboarding";
        case HKWorkoutActivityTypeStairs:
            return @"Stairs";
        case HKWorkoutActivityTypeStepTraining:
            return @"Step Training";
        case HKWorkoutActivityTypeWheelchairWalkPace:
            return @"Wheelchair Walk Pace";
        case HKWorkoutActivityTypeWheelchairRunPace:
            return @"Wheelchair Run Pace";
        case HKWorkoutActivityTypeTaiChi:
            return @"Tai Chi";
        case HKWorkoutActivityTypeMixedCardio:
            return @"Mixed Cardio";
        case HKWorkoutActivityTypeHandCycling:
            return @"Hand Cycling";
        case HKWorkoutActivityTypeDiscSports:
            return @"Disc Sports";
        case HKWorkoutActivityTypeFitnessGaming:
            return @"Fitness Gaming";
        default:
            return @"Other";
    }
    return 0;
}

@end
