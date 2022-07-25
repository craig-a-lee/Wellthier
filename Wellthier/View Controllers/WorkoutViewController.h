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

@property (nonatomic, weak) IBOutlet UILabel *workoutTitle;
@property (nonatomic, weak) IBOutlet UILabel *author;
@property (nonatomic, strong) NSArray <Exercise*> *arrayOfExercises;
@property (nonatomic, strong) NSArray <Exercise*> *filteredExercises;
@property (nonatomic, strong) Workout *detailWorkout;
@property (nonatomic, strong) IBOutlet PFImageView *workoutImageView;

@end

NS_ASSUME_NONNULL_END
