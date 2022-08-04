//
//  Workout.m
//  Wellthier
//
//  Created by Craig Lee on 7/13/22.
//

#import "Workout.h"
#import <Parse/Parse.h>
#import "Exercise.h"

@implementation Workout

@dynamic postID;
@dynamic userID;
@dynamic author;
@dynamic title;
@dynamic image;
@dynamic likeCount;
@dynamic exercises;

+ (nonnull NSString*)parseClassName {
    return @"Workout";
}

+ (void)postUserWorkout:(UIImage* _Nullable )image withTitle:(NSString* _Nullable )title withCompletion:(PFBooleanResultBlock  _Nullable)completion {
        Workout *newWorkout = [Workout new];
        newWorkout.image = [self getPFFileFromImage:image];
        newWorkout.author = [PFUser currentUser];
        newWorkout.title = title;
        newWorkout.exercises = [NSMutableArray new];
        newWorkout.likeCount = @(0);
        [newWorkout saveInBackgroundWithBlock: completion];
}

+ (void)updateUserWorkout:(Workout* _Nullable )workout withExercise:(Exercise* _Nullable )exercise withCompletion:(PFBooleanResultBlock  _Nullable)completion {
    [workout addObject:exercise.exerciseID forKey:@"exercises"];
    [workout saveInBackgroundWithBlock: completion];
}

+ (void)deleteExerciseFromWorkout:(Workout* _Nullable )workout withExercise:(Exercise* _Nullable )exercise withCompletion:(PFBooleanResultBlock  _Nullable)completion {
    [workout removeObject:exercise.exerciseID forKey:@"exercises"];
    [workout saveInBackgroundWithBlock: completion];
}

+ (PFFileObject*)getPFFileFromImage:(UIImage* _Nullable)image {
    if (!image) {
        return nil;
    }
    
    NSData *imageData = UIImagePNGRepresentation(image);
    if (!imageData) {
        return nil;
    }
    
    return [PFFileObject fileObjectWithName:@"image.png" data:imageData];
}

@end
