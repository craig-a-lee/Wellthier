//
//  NewWorkoutViewController.m
//  Wellthier
//
//  Created by Craig Lee on 7/11/22.
//

#import "NewWorkoutViewController.h"

@interface NewWorkoutViewController ()

@end

@implementation NewWorkoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    
    [self presentViewController:alert animated:YES completion:^{
        // optional code for what happens after the alert controller has finished presenting
    }];
}


- (IBAction)didTapCreate:(id)sender {
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
