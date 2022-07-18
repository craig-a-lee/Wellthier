//
//  AddToWorkoutViewController.h
//  Wellthier
//
//  Created by Craig Lee on 7/18/22.
//

#import "ViewController.h"
#import "Workout.h"

NS_ASSUME_NONNULL_BEGIN

@interface AddToWorkoutViewController : ViewController

@property (strong, nonatomic) NSArray <Workout *> *arrayOfWorkouts;
@property (strong, nonatomic) NSArray <Workout *> *filteredWorkouts;


@end

NS_ASSUME_NONNULL_END
