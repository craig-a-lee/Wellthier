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

- (IBAction)didTapLogin:(id)sender {
    UIAlertController *emptyAlert = [UIAlertController alertControllerWithTitle:@"Empty Field"
                                                                               message:@"There is an empty field, please fill it."
                                                                        preferredStyle:(UIAlertControllerStyleAlert)];

    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                       style:UIAlertActionStyleDefault
                                                     handler:nil];
    UIAlertController *invalidAlert = [UIAlertController alertControllerWithTitle:@"Invalid Credentials"
                                                                               message:@"An account does not exist with these credentials, please try again."
                                                                        preferredStyle:(UIAlertControllerStyleAlert)];
    [emptyAlert addAction:okAction];
    [invalidAlert addAction:okAction];
    
    if ([self.usernameField.text isEqual:@""] || [self.passwordField.text isEqual:@""]) {
        [self presentViewController:emptyAlert animated:YES completion:nil];
    }
    else {
        NSString *username = self.usernameField.text;
        NSString *password = self.passwordField.text;
        
        [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
            if (error != nil) {
                [self presentViewController:invalidAlert animated:YES completion:nil];
            } else {
                NSLog(@"User logged in successfully");
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
