//
//  WorkoutViewController.h
//  Wellthier
//
//  Created by Craig Lee on 7/14/22.
//

#import "ViewController.h"
#import "Workout.h"
#import "Exercise.h"

@import Parse;

NS_ASSUME_NONNULL_BEGIN

@interface WorkoutViewController : ViewController

@property (weak, nonatomic) IBOutlet UILabel *workoutTitle;
@property (weak, nonatomic) IBOutlet UILabel *author;
@property (strong, nonatomic) NSArray <Exercise*> *arrayOfExercises;
@property (strong, nonatomic) NSArray <Exercise*> *filteredExercises;
@property (strong, nonatomic) Workout *detailWorkout;
@property (weak, nonatomic) IBOutlet PFImageView *workoutImageView;

@end

NS_ASSUME_NONNULL_END
