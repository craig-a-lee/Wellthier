//
//  ComposeViewController.h
//  Wellthier
//
//  Created by Craig Lee on 7/19/22.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@import Parse;

NS_ASSUME_NONNULL_BEGIN

@interface ComposeViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, weak) IBOutlet PFImageView *profilePic;
@property (nonatomic, strong) PFUser *currentUser;
@property (nonatomic, weak) IBOutlet PFImageView *selectedPhotoView;
@property (nonatomic, weak) IBOutlet UIButton *clearImageButton;

@end

NS_ASSUME_NONNULL_END
