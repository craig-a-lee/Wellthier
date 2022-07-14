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

@interface WorkoutCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet PFImageView *workoutImageView;
@property (weak, nonatomic) IBOutlet UILabel *workoutTitle;
@property (weak, nonatomic) IBOutlet UILabel *workoutAuthorInfo;
@property (strong, nonatomic) Workout *workout;

@end

NS_ASSUME_NONNULL_END
