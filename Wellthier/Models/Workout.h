//
//  Workout.h
//  Wellthier
//
//  Created by Craig Lee on 7/13/22.
//

#import <Parse/Parse.h>
#import "Exercise.h"

NS_ASSUME_NONNULL_BEGIN

@interface Workout : PFObject <PFSubclassing>

@property (nonatomic, strong) NSString *postID;
@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) PFUser *author;
@property (nonatomic, strong) PFFileObject *image;
@property (nonatomic, strong) NSNumber *likeCount;
@property (nonatomic, strong) NSMutableArray *exercises;

+ (void) postUserWorkout: ( UIImage * _Nullable )image withTitle: ( NSString * _Nullable )title withCompletion: (PFBooleanResultBlock  _Nullable)completion;
+ (void) updateUserWorkout: ( Workout * _Nullable )workout withExercise: ( Exercise * _Nullable )exercise withCompletion: (PFBooleanResultBlock  _Nullable)completion;
+ (void) deleteExerciseFromWorkout: ( Workout * _Nullable )workout withExercise: ( Exercise * _Nullable )exercise withCompletion: (PFBooleanResultBlock  _Nullable)completion;

@end

NS_ASSUME_NONNULL_END
