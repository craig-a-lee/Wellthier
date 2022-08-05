//
//  WorkoutCell.m
//  Wellthier
//
//  Created by Craig Lee on 7/13/22.
//

#import "WorkoutCollectionViewCell.h"
#import "Workout.h"

@implementation WorkoutCollectionViewCell

- (void)setWorkoutDetails:(Workout *)detailWorkout {
    self.workoutImageView.file = detailWorkout[@"image"];
    [self.workoutImageView loadInBackground];
    self.numberOfExercisesLabel.text = [NSString stringWithFormat:@"%lu Exercises", detailWorkout.exercises.count];
    self.workoutTitleLabel.text = detailWorkout.title;
}

@end
