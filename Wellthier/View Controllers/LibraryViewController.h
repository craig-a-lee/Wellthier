//
//  LibraryViewController.h
//  Wellthier
//
//  Created by Craig Lee on 7/13/22.
//

#import <UIKit/UIKit.h>
#import "Workout.h"

@import Parse;

NS_ASSUME_NONNULL_BEGIN

@interface LibraryViewController : UIViewController

@property (nonatomic, weak) IBOutlet PFImageView *profilePic;
@property (nonatomic, strong) PFUser *currentUser;
@property (nonatomic, strong) NSMutableArray <Workout *> *arrayOfWorkouts;
@property (nonatomic, strong) NSMutableArray <Workout *> *filteredWorkouts;
@property (nonatomic, weak) IBOutlet UILabel *displayName;

@end

NS_ASSUME_NONNULL_END
