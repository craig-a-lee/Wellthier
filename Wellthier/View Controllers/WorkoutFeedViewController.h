//
//  FeedViewController.h
//  Wellthier
//
//  Created by Craig Lee on 7/19/22.
//

#import "ViewController.h"
#import "Post.h"

NS_ASSUME_NONNULL_BEGIN

@interface WorkoutFeedViewController : UIViewController

@property (strong, nonatomic) NSArray <Post *> *arrayOfPosts;

@end

NS_ASSUME_NONNULL_END
