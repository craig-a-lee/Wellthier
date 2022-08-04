//
//  ComposeViewController.m
//  Wellthier
//
//  Created by Craig Lee on 7/19/22.
//

#import <Parse/Parse.h>
#import <HealthKit/HealthKit.h>
#import "ComposeViewController.h"
#import "HealthKitWorkoutsViewController.h"
#import "HealthKitSharedManager.h"
#import "DraftSharedManager.h"
#import "Post.h"

@interface ComposeViewController () <HealtKitWorkoutsViewControllerDelegate>

@property (nonatomic, weak) IBOutlet UITextView *textView;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[self.textView layer] setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [[self.textView layer] setBorderWidth:1.0];
    [self setUserInfo];
    self.clearImageButton.hidden = YES;
}

- (void)setUserInfo {
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
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:imagePickerVC animated:YES completion:nil];

                                                     }];
    
    UIAlertAction *takePicAction = [UIAlertAction actionWithTitle:@"Take a Picture"
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
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * _Nonnull action) {
                                                     }];
    [alert addAction:chooseAction];
    [alert addAction:takePicAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)didPickWorkout:(HKWorkout *)workout {
    NSString *workoutTypeInfo = [NSString stringWithFormat:@"Workout Type: %@", [[HealthKitSharedManager sharedManager] getWorkoutType: workout.workoutActivityType]];
    NSString *workoutDurationInfo = [NSString stringWithFormat:@"Duration: %@", [[HealthKitSharedManager sharedManager] hoursMinsSecsFromDuration:workout.duration]];
    NSString *workoutEnergyBurnedInfo = @"";
    if (workout.totalEnergyBurned) {
        workoutEnergyBurnedInfo = [NSString stringWithFormat:@"Energy Burned: %@", workout.totalEnergyBurned];
    }
    NSString *workoutTextInfo = [NSString stringWithFormat:@"Check out one of last week's workout! \n\n%@ \n%@ \n%@", workoutTypeInfo, workoutDurationInfo, workoutEnergyBurnedInfo];
    dispatch_async(dispatch_get_main_queue(), ^{
        self.textView.text = workoutTextInfo;
    });
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    CGSize size = CGSizeMake(293, 293);
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

- (IBAction)didTapPost:(id)sender {
    [Post makeUserPost:self.selectedPhotoView.image withText:self.textView.text withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        [self dismissViewControllerAnimated:true completion:nil];
    }];
}

- (IBAction)didTapCancel:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Would you like to save this post as a draft?"
                                                                               message:@""
                                                                        preferredStyle:(UIAlertControllerStyleAlert)];
    
    UIAlertAction *saveDraftAction = [UIAlertAction actionWithTitle:@"Save Draft"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * _Nonnull action) {
                                                             // handle response here.
        NSDictionary *draftDictionary = [NSDictionary new];
        NSData *imageData;
        if (self.selectedPhotoView.image) {
            imageData = UIImagePNGRepresentation(self.selectedPhotoView.image);
        } else {
            imageData = [NSData new];
        }
        draftDictionary = @{@"username": PFUser.currentUser.username, @"draftText": self.textView.text, @"draftImage": imageData};
        [[DraftSharedManager sharedManager] addDraftToFile:draftDictionary];        
        [self dismissViewControllerAnimated:true completion:nil];
                                                     }];
    
    UIAlertAction *discardAction = [UIAlertAction actionWithTitle:@"Discard"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:true completion:nil];
                                                     }];
    
    [discardAction setValue:[UIColor redColor] forKey:@"_titleTextColor"];
    [alert addAction:saveDraftAction];
    [alert addAction:discardAction];
    
    if (!(self.selectedPhotoView.image == nil && [self.textView.text isEqualToString:@""])) {
        [self presentViewController:alert animated:YES completion:nil];
    } else {
        [self dismissViewControllerAnimated:true completion:nil];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"healthKitViewSegue"]) {
        UINavigationController *navigationController = [segue destinationViewController];
        HealthKitWorkoutsViewController *healthKitVC = (HealthKitWorkoutsViewController*) navigationController.topViewController;
        healthKitVC.delegate = self;
    }
}

@end
