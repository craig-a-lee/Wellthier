//
//  NewWorkoutViewController.h
//  Wellthier
//
//  Created by Craig Lee on 7/11/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol NewWorkoutViewControllerDelegate

- (void)didCreateWorkout;

@end

@interface NewWorkoutViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, weak) id<NewWorkoutViewControllerDelegate> delegate;
@property (nonatomic, weak) IBOutlet UIImageView *workoutImage;
@property (nonatomic, weak) IBOutlet UITextField *workoutName;

@end

NS_ASSUME_NONNULL_END
