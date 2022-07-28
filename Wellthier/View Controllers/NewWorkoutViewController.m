//
//  NewWorkoutViewController.m
//  Wellthier
//
//  Created by Craig Lee on 7/11/22.
//

#import "NewWorkoutViewController.h"
#import "Workout.h"

@interface NewWorkoutViewController ()

@end

@implementation NewWorkoutViewController

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
                                                             // handle response here.
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
        }
        else {
            imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }
        [self presentViewController:imagePickerVC animated:YES completion:nil];
                                                     }];
    
    UIAlertAction *takePicAction = [UIAlertAction actionWithTitle:@"Take a Picture"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * _Nonnull action) {
            imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imagePickerVC animated:YES completion:nil];

                                                     }];
    [alert addAction:chooseAction];
    [alert addAction:takePicAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];

    CGSize size = CGSizeMake(167, 167);
    self.workoutImageView.image = [self resizeImage:originalImage withSize:size];

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

- (IBAction)didTapCreate:(id)sender {
    [Workout postUserWorkout:self.workoutImageView.image withTitle:self.workoutName.text withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        [self.delegate didCreateWorkout];
        [self.navigationController popViewControllerAnimated:true];
    }];
}



@end
