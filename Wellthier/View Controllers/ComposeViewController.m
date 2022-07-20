//
//  ComposeViewController.m
//  Wellthier
//
//  Created by Craig Lee on 7/19/22.
//

#import "ComposeViewController.h"
#import "Parse/Parse.h"
#import "HealthKit/HealthKit.h"
#import "HealthKitSharedManager.h"

@interface ComposeViewController ()

@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[self.textView layer] setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [[self.textView layer] setBorderWidth:1.0];
    [self setParams];
    self.clearImageButton.hidden = YES;
}

- (void) setParams {
    self.currentUser = PFUser.currentUser;
    self.profilePic.file = self.currentUser[@"profilePic"];
    [self.profilePic loadInBackground];
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
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * _Nonnull action) {
                                                     }];
    [alert addAction:chooseAction];
    [alert addAction:takePicAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    CGSize size = CGSizeMake(112, 112);
    self.selectedPhotoView.image = [self resizeImage:originalImage withSize:size];
    self.clearImageButton.hidden = NO;
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

- (IBAction)didTapClearImageButton:(id)sender {
    self.selectedPhotoView.image = nil;
    self.clearImageButton.hidden = YES;
}

- (IBAction)didTapFetchData:(id)sender {
    HKWorkout *latestWorkout = [[HealthKitSharedManager sharedManager] getLatestWorkout];
}

- (IBAction)didTapPost:(id)sender {
}

- (IBAction)didTapCancel:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}


@end
