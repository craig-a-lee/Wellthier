//
//  WorkoutTableViewCell.h
//  Wellthier
//
//  Created by Craig Lee on 7/18/22.
//

#import <UIKit/UIKit.h>
#import "Workout.h"

@import Parse;

NS_ASSUME_NONNULL_BEGIN

@interface WorkoutTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet PFImageView *workoutImageView;
@property (nonatomic, weak) IBOutlet UILabel *workoutName;
@property (nonatomic, weak) IBOutlet UILabel *numberOfExercises;
@property (nonatomic, strong) Workout *workout;

- (void)setWorkoutDetails:(Workout *)workout;

@end

NS_ASSUME_NONNULL_END
