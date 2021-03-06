//
//  LoginViewController.m
//  Wellthier
//
//  Created by Craig Lee on 7/13/22.
//

#import <Parse/Parse.h>
#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)didTapLogin:(id)sender {
    UIAlertController *emptyAlert = [UIAlertController alertControllerWithTitle:@"Empty Field"
                                                                               message:@"There is an empty field, please fill it."
                                                                        preferredStyle:(UIAlertControllerStyleAlert)];

    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * _Nonnull action) {
                                                             // handle response here.
                                                     }];
    UIAlertController *invalidAlert = [UIAlertController alertControllerWithTitle:@"Invalid Credentials"
                                                                               message:@"An account does not exist with these credentials, please try again."
                                                                        preferredStyle:(UIAlertControllerStyleAlert)];
    // add the OK action to the alert controller
    [emptyAlert addAction:okAction];
    [invalidAlert addAction:okAction];
    
    if ([self.usernameField.text isEqual:@""] || [self.passwordField.text isEqual:@""]) {
        [self presentViewController:emptyAlert animated:YES completion:^{
            // optional code for what happens after the alert controller has finished presenting
        }];
    }
    else {
        NSString *username = self.usernameField.text;
        NSString *password = self.passwordField.text;
        
        [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
            if (error != nil) {
                [self presentViewController:invalidAlert animated:YES completion:^{
                    // optional code for what happens after the alert controller has finished presenting
                }];
            } else {
                NSLog(@"User logged in successfully");
                
                // display view controller that needs to shown after successful login
                [self performSegueWithIdentifier:@"loginSegue" sender:self];
            }
        }];
    }
}

- (IBAction)tapGesture:(id)sender {
    [_usernameField resignFirstResponder];
    [_passwordField resignFirstResponder];
}
@end
