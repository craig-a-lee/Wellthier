//
//  LibraryViewController.h
//  Wellthier
//
//  Created by Craig Lee on 7/13/22.
//

#import "ViewController.h"
@import Parse;
NS_ASSUME_NONNULL_BEGIN

@interface LibraryViewController : ViewController
@property (weak, nonatomic) IBOutlet PFImageView *profilePic;
@property (strong, nonatomic) PFUser *currUser;
@property (strong, nonatomic) NSMutableArray *arrayOfWorkouts;


@end

NS_ASSUME_NONNULL_END
