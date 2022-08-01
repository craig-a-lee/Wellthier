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

- (void) fetchAllExercisesFromApi {
    ExerciseAPIManager *manager = [ExerciseAPIManager new];
    [manager fetchAllExercises:^(NSArray *exercises, NSError *error) {
        self.allExercises = exercises;
    }];
}

- (void)fetchAllExercisesFromFile {
//    NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Values" ofType:@"plist"]];
    

    //NSString *path = @"/Users/craiglee/Desktop/Projects/Wellthier/Wellthier/ExerciseData.plist";
    NSDictionary *theDict = [NSDictionary dictionaryWithContentsOfFile:@"ExerciseData.plist"];
    // NSFileManager *manager = [NSFileManager defaultManager];
    NSArray *exercisesFromFile;
    self.allExercises = [Exercise exercisesWithDictionaries:exercisesFromFile];
}

@end
