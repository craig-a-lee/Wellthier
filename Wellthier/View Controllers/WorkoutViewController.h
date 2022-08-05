//
//  WorkoutViewController.h
//  Wellthier
//
//  Created by Craig Lee on 7/14/22.
//

#import <UIKit/UIKit.h>
#import "Workout.h"
#import "Exercise.h"

@import Parse;

NS_ASSUME_NONNULL_BEGIN

@interface WorkoutViewController : UIViewController

@property (nonatomic, weak) IBOutlet UILabel *workoutTitleLabel;
@property (nonatomic, weak) IBOutlet UILabel *authorLabel;
@property (nonatomic, strong) IBOutlet PFImageView *workoutImageView;
@property (nonatomic, strong) NSArray <Exercise*> *arrayOfExercises;
@property (nonatomic, strong) NSArray <Exercise*> *filteredExercises;
@property (nonatomic, strong) Workout *detailWorkout;

@end

NS_ASSUME_NONNULL_END
