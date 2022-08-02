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

@property (weak, nonatomic) IBOutlet PFImageView *workoutImageView;
@property (weak, nonatomic) IBOutlet UILabel *workoutTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberOfExercisesLabel;
@property (strong, nonatomic) Workout *workout;

- (void)setParams:(Workout *)detailWorkout;

@end

NS_ASSUME_NONNULL_END
