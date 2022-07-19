//
//  ExerciseCommonManager.m
//  Wellthier
//
//  Created by Craig Lee on 7/18/22.
//

#import "ExerciseSharedManager.h"
#import "ExerciseAPIManager.h"

@implementation ExerciseSharedManager

+ (id)sharedManager {
    static ExerciseSharedManager *commonManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        commonManager = [[self alloc] init];
    });
    return commonManager;
}

- (void) fetchAllExercises {
    ExerciseAPIManager *manager = [ExerciseAPIManager new];
    [manager fetchAllExercises:^(NSArray *exercises, NSError *error) {
        self.allExercises = exercises;
    }];
}

@end
