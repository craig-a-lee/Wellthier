//
//  ExerciseCommonManager.h
//  Wellthier
//
//  Created by Craig Lee on 7/18/22.
//

#import <Foundation/Foundation.h>
#import "Exercise.h"

NS_ASSUME_NONNULL_BEGIN

@interface ExerciseSharedManager : NSObject //change to exercise shared manager

+ (id)sharedManager;
- (void)fetchAllExercisesFromApi;
- (void)fetchAllExercisesFromFile;

@property (nonatomic, strong) NSArray <Exercise *> *allExercises;

@end

NS_ASSUME_NONNULL_END
