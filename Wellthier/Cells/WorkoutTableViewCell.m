//
//  WorkoutTableViewCell.m
//  Wellthier
//
//  Created by Craig Lee on 7/18/22.
//

#import "WorkoutTableViewCell.h"

@implementation WorkoutTableViewCell

- (void)setWorkoutDetails:(Workout *)workout {
    self.workoutImageView.file = workout[@"image"];
    [self.workoutImageView loadInBackground];
    self.workoutName.text = workout.title;
    self.numberOfExercises.text = [NSString stringWithFormat:@"%lu Exercises", workout.exercises.count];
    self.workout = workout;
}

@end
