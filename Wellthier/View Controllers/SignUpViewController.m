//
//  SignUpViewController.m
//  Wellthier
//
//  Created by Craig Lee on 7/7/22.
//

#import "SignUpViewController.h"
#import "Parse/Parse.h"
#import "Workout.h"
#import "HealthKit/HealthKit.h"
#import "HealthKitUI/HealthKitUI.h"

@interface SignUpViewController ()

@end

@implementation SignUpViewController 

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)didTapUploadPic:(id)sender {
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Select:"
                                                                               message:@""
                                                                        preferredStyle:(UIAlertControllerStyleAlert)];
    
    UIAlertAction *chooseAction = [UIAlertAction actionWithTitle:@"Choose Picture"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * _Nonnull action) {
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:imagePickerVC animated:YES completion:nil];
                                                 }];
    
    UIAlertAction *takePicAction = [UIAlertAction actionWithTitle:@"Take a Picture"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * _Nonnull action) {
                                                             // handle response here.

        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
        }
        else {
            imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }
        [self presentViewController:imagePickerVC animated:YES completion:nil];
                                                     }];
    // add the OK action to the alert controller
    [alert addAction:chooseAction];
    [alert addAction:takePicAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    // Get the image captured by the UIImagePickerController
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];

    // Do something with the images (based on your use case)
    CGSize size = CGSizeMake(112, 112);
    self.profilePicImageView.image = [self resizeImage:originalImage withSize:size];
    
    // Dismiss UIImagePickerController to go back to your original view controller
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size {
    UIImageView *resizeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    
    resizeImageView.contentMode = UIViewContentModeScaleAspectFill;
    resizeImageView.image = image;
    
    UIGraphicsBeginImageContext(size);
    [resizeImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (IBAction)didTapSignUp:(id)sender {
    UIAlertController *emptyAlert = [UIAlertController alertControllerWithTitle:@"Empty Field"
                                                                               message:@"There is an empty field, please fill it."
                                                                        preferredStyle:(UIAlertControllerStyleAlert)];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                       style:UIAlertActionStyleDefault
                                                     handler:nil];
    UIAlertController *invalidAlert = [UIAlertController alertControllerWithTitle:@"Invalid Username"
                                                                               message:@"Account already exists for this username."
                                                                        preferredStyle:(UIAlertControllerStyleAlert)];
    [emptyAlert addAction:okAction];
    [invalidAlert addAction:okAction];
    
    if ([self.usernameField.text isEqual:@""] || [self.passwordField.text isEqual:@""] || [self.displayNameField.text isEqual:@""]) {
        [self presentViewController:emptyAlert animated:YES completion:nil];
    } else {
        PFUser *newUser = [PFUser user];
        newUser.username = self.usernameField.text;
        newUser[@"displayName"] = self.displayNameField.text;
        newUser.password = self.passwordField.text;
        newUser[@"profilePic"] = [self getPFFileFromImage:self.profilePicImageView.image];
        [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
            if (error.code == 202) {
                [self presentViewController:invalidAlert animated:YES completion:nil];
            } else {
                // manually segue to logged in view
                [Workout postUserWorkout:[UIImage imageNamed:@"purpleheart"] withTitle:@"Liked Exercises" withCompletion:^(BOOL succeeded, NSError * _Nullable error) {

                }];
                [self performSegueWithIdentifier:@"postSignUpSegue" sender:sender];
            }
        }];
    }
}

- (PFFileObject *)getPFFileFromImage:(UIImage * _Nullable)image {
    if (!image) {
        return nil;
    }
    NSData *imageData = UIImagePNGRepresentation(image);
    if (!imageData) {
        return nil;
    }
    return [PFFileObject fileObjectWithName:@"image.png" data:imageData];
}

- (IBAction)tapGesture:(id)sender {
    [_displayNameField resignFirstResponder];
    [_usernameField resignFirstResponder];
    [_passwordField resignFirstResponder];
}

@end
