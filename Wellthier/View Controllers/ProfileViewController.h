//
//  ProfileViewController.h
//  Wellthier
//
//  Created by Craig Lee on 7/21/22.
//

#import <Parse/Parse.h>
#import <UIKit/UIKit.h>
#import "Workout.h"
#import "Post.h"

@import Parse;

NS_ASSUME_NONNULL_BEGIN

@interface ProfileViewController : UIViewController

@property (nonatomic, weak) IBOutlet PFImageView *profilePic;
@property (nonatomic, weak) IBOutlet UILabel *displayNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *usernameLabel;
@property (nonatomic, strong) NSArray <Workout *> *arrayOfWorkouts;
@property (nonatomic, strong) NSArray <Post *> *arrayOfPosts;
@property (nonatomic, strong) PFUser *selectedUser;

@end

NS_ASSUME_NONNULL_END
