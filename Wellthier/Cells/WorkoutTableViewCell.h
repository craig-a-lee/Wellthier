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

@property (weak, nonatomic) IBOutlet PFImageView *workoutImageView;
@property (weak, nonatomic) IBOutlet UILabel *workoutName;
@property (weak, nonatomic) IBOutlet UILabel *workoutAuthorInfo;
@property (strong, nonatomic) Workout *workout;

@end

NS_ASSUME_NONNULL_END
