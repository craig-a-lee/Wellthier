//
//  NewWorkoutViewController.h
//  Wellthier
//
//  Created by Craig Lee on 7/11/22.
//

#import "ViewController.h"

NS_ASSUME_NONNULL_BEGIN

@protocol NewWorkoutViewControllerDelegate

- (void)didCreateWorkout;

@end

@interface NewWorkoutViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) id<NewWorkoutViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIImageView *workoutImage;
@property (weak, nonatomic) IBOutlet UITextField *workoutName;

@end

NS_ASSUME_NONNULL_END
