//
//  PostDetailsViewController.h
//  Wellthier
//
//  Created by Craig Lee on 7/28/22.
//

#import <UIKit/UIKit.h>

@import Parse;

NS_ASSUME_NONNULL_BEGIN

@interface PostDetailsViewController : UIViewController

@property (nonatomic, weak) IBOutlet PFImageView *pictureView;

@end

NS_ASSUME_NONNULL_END
