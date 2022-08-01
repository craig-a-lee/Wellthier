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
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"ExerciseData.plist"];
    NSArray *exercisesFromFile = [NSArray new];
    exercisesFromFile = [NSArray arrayWithContentsOfFile:filePath];
    NSLog(@"%@", exercisesFromFile);
    self.allExercises = [Exercise exercisesWithDictionaries:exercisesFromFile];
}

@end
