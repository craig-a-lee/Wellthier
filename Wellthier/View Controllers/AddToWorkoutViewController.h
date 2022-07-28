//
//  AddToWorkoutViewController.h
//  Wellthier
//
//  Created by Craig Lee on 7/18/22.
//

#import <UIKit/UIKit.h>
#import "Workout.h"

NS_ASSUME_NONNULL_BEGIN

@protocol AddToWorkoutViewControllerDelegate

- (void) didAddToWorkout;

@end

@interface AddToWorkoutViewController : UIViewController <UISearchBarDelegate>

@property (nonatomic, strong) IBOutlet UISearchBar *searchBar;
@property (nonatomic, weak) id<AddToWorkoutViewControllerDelegate> delegate;
@property (nonatomic, strong) NSArray <Workout *> *arrayOfWorkouts;
@property (nonatomic, strong) NSArray <Workout *> *filteredWorkouts;
@property (nonatomic, strong) Exercise *selectedExercise;

@end

NS_ASSUME_NONNULL_END
