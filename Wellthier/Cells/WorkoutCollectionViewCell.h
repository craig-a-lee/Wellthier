//
//  WorkoutCell.h
//  Wellthier
//
//  Created by Craig Lee on 7/13/22.
//

#import <UIKit/UIKit.h>
#import "Workout.h"
@import Parse;

NS_ASSUME_NONNULL_BEGIN

@interface WorkoutCollectionViewCell : UICollectionViewCell

@property (nonatomic, weak) IBOutlet PFImageView *workoutImageView;
@property (nonatomic, weak) IBOutlet UILabel *workoutTitleLabel;
@property (nonatomic, weak) IBOutlet UILabel *numberOfExercisesLabel;

- (void)setWorkoutDetails:(Workout *)detailWorkout;

@end

NS_ASSUME_NONNULL_END
