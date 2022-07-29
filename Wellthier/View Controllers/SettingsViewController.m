//
//  SettingsViewController.m
//  Wellthier
//
//  Created by Craig Lee on 7/13/22.
//

#import <Parse/Parse.h>
#import "SettingsViewController.h"
#import "SceneDelegate.h"
#import "LoginViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (IBAction)didTapLogOut:(id)sender {   
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        [self performSegueWithIdentifier:@"logoutSegue" sender:self];
    }];
}
- (IBAction)didTapEditProfile:(id)sender {
}

@end
