//
//  AddToWorkoutViewController.h
//  Wellthier
//
//  Created by Craig Lee on 7/18/22.
//

#import "ViewController.h"
#import "Workout.h"

NS_ASSUME_NONNULL_BEGIN

@protocol AddToWorkoutViewControllerDelegate

- (void) didAddToWorkout;

@end

@interface AddToWorkoutViewController : ViewController

@property (weak, nonatomic) id<AddToWorkoutViewControllerDelegate> delegate;
@property (strong, nonatomic) NSArray <Workout *> *arrayOfWorkouts;
@property (strong, nonatomic) NSArray <Workout *> *filteredWorkouts;
@property (strong, nonatomic) Exercise *selectedExercise;

@end

NS_ASSUME_NONNULL_END
