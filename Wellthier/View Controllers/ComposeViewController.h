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

@interface ComposeViewController : ViewController

@property (weak, nonatomic) IBOutlet PFImageView *profilePic;
@property (strong, nonatomic) PFUser *currentUser;

@end

NS_ASSUME_NONNULL_END
