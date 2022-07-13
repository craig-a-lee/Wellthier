//
//  SignUpViewController.m
//  Wellthier
//
//  Created by Craig Lee on 7/7/22.
//

#import "SignUpViewController.h"
#import "Parse/Parse.h"

@interface SignUpViewController ()

@end

@implementation SignUpViewController 

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.profilePic.layer.cornerRadius = self.profilePic.frame.size.height /2;
    self.profilePic.layer.masksToBounds = YES;
    self.profilePic.layer.borderWidth = 0;
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
                                                             // handle response here.
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
        }
        else {
            NSLog(@"Camera 🚫 available so we will use photo library instead");
            imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }
        [self presentViewController:imagePickerVC animated:YES completion:nil];
                                                     }];
    
    UIAlertAction *takePicAction = [UIAlertAction actionWithTitle:@"Take a Picture"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * _Nonnull action) {
                                                             // handle response here.
            NSLog(@"Camera 🚫 available so we will use photo library instead");
            imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
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
    self.profilePic.image = [self resizeImage:originalImage withSize:size];
    
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
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Empty Field"
                                                                               message:@"There is an empty field, please fill it."
                                                                        preferredStyle:(UIAlertControllerStyleAlert)];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * _Nonnull action) {
                                                             // handle response here.
                                                     }];
    // add the OK action to the alert controller
    [alert addAction:okAction];
    
    if ([self.usernameField.text isEqual:@""] || [self.passwordField.text isEqual:@""] || [self.displayNameField.text isEqual:@""]) {
        [self presentViewController:alert animated:YES completion:^{
            // optional code for what happens after the alert controller has finished presenting
        }];
    } else {
        PFUser *newUser = [PFUser user];
        
        // set user properties
        newUser.username = self.usernameField.text;
        newUser[@"displayName"] = self.displayNameField.text;
        newUser.password = self.passwordField.text;
        newUser[@"profilePic"] = [self getPFFileFromImage:self.profilePic.image];
        
        // call sign up function on the object
        [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
            if (error != nil) {
                NSLog(@"Error: %@", error.localizedDescription);
            } else {
                NSLog(@"User registered successfully");
                // manually segue to logged in view
                    [self performSegueWithIdentifier:@"postSignUpSegue" sender:sender];
            }
        }];
    }
}

- (PFFileObject *)getPFFileFromImage: (UIImage * _Nullable)image {
 
    // check if image is not nil
    if (!image) {
        return nil;
    }
    
    NSData *imageData = UIImagePNGRepresentation(image);
    // get image data and check if that is not nil
    if (!imageData) {
        return nil;
    }
    
    return [PFFileObject fileObjectWithName:@"image.png" data:imageData];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)gesture:(id)sender {
    [_displayNameField resignFirstResponder];
    [_usernameField resignFirstResponder];
    [_passwordField resignFirstResponder];
}
@end
