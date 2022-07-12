//
//  SignUpViewController.h
//  Wellthier
//
//  Created by Craig Lee on 7/7/22.
//

#import "ViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SignUpViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *displayNameField;
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIImageView *profilePic;
- (IBAction)gesture:(id)sender;

@end

NS_ASSUME_NONNULL_END
