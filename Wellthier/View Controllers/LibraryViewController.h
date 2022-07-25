//
//  LibraryViewController.h
//  Wellthier
//
//  Created by Craig Lee on 7/13/22.
//

#import "ViewController.h"
#import "Workout.h"

@import Parse;

NS_ASSUME_NONNULL_BEGIN

@interface LibraryViewController : ViewController

@property (nonatomic, weak) IBOutlet PFImageView *profilePic;
@property (nonatomic, strong) PFUser *currentUser;
@property (nonatomic, strong) NSMutableArray <Workout *> *arrayOfWorkouts;
@property (nonatomic, strong) NSMutableArray <Workout *> *filteredWorkouts;

@end

NS_ASSUME_NONNULL_END
