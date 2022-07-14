//
//  WorkoutCell.m
//  Wellthier
//
//  Created by Craig Lee on 7/13/22.
//

#import "WorkoutCell.h"
#import "Workout.h"

@implementation WorkoutCell

- (void)setParams:(Workout *)detailWorkout {
    _workout = detailWorkout;
    self.workoutImageView.file = detailWorkout[@"image"];
    [self.workoutImageView loadInBackground];
    self.workoutAuthorInfo.text = detailWorkout[@"displayName"];
    self.workoutTitle.text = detailWorkout.title;
}

@end
