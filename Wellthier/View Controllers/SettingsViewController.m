//
//  SettingsViewController.m
//  Wellthier
//
//  Created by Craig Lee on 7/13/22.
//

#import "SettingsViewController.h"
#import "Parse/Parse.h"
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

@end
