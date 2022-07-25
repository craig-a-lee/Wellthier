//
//  LoginViewController.h
//  Wellthier
//
//  Created by Craig Lee on 7/13/22.
//

#import "ViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface LoginViewController : ViewController

@property (nonatomic, weak) IBOutlet UITextField *usernameField;
@property (nonatomic, weak) IBOutlet UITextField *passwordField;

- (IBAction)tapGesture:(id)sender;

@end

NS_ASSUME_NONNULL_END
