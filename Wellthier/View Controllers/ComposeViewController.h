//
//  ComposeViewController.h
//  Wellthier
//
//  Created by Craig Lee on 7/19/22.
//

#import "ViewController.h"
#import "Parse/Parse.h"

@import Parse;

NS_ASSUME_NONNULL_BEGIN

@interface ComposeViewController : ViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet PFImageView *profilePic;
@property (strong, nonatomic) PFUser *currentUser;
@property (weak, nonatomic) IBOutlet PFImageView *selectedPhotoView;
@property (weak, nonatomic) IBOutlet UIButton *clearImageButton;

@end

NS_ASSUME_NONNULL_END
