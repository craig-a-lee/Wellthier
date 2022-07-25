//
//  SignUpViewController.h
//  Wellthier
//
//  Created by Craig Lee on 7/7/22.
//

#import "ViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SignUpViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, weak) IBOutlet UITextField *displayNameField;
@property (nonatomic, weak) IBOutlet UITextField *usernameField;
@property (nonatomic, weak) IBOutlet UITextField *passwordField;
@property (nonatomic, weak) IBOutlet UIImageView *profilePic;
- (IBAction)tapGesture:(id)sender;

@end

NS_ASSUME_NONNULL_END
