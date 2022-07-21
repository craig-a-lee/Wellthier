//
//  PostCell.h
//  Wellthier
//
//  Created by Craig Lee on 7/19/22.
//

#import <UIKit/UIKit.h>
#import "Post.h"

@import Parse;

NS_ASSUME_NONNULL_BEGIN

@interface PostCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *toProfileHiddenButton;
@property (weak, nonatomic) IBOutlet UILabel *displayName;
@property (weak, nonatomic) IBOutlet UITextView *postText;
@property (weak, nonatomic) IBOutlet PFImageView *postImageView;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (strong, nonatomic) Post *detailPost;
@property (weak, nonatomic) IBOutlet PFImageView *profilePicView;

- (void)setPostDetails: (Post *)post;

@end

NS_ASSUME_NONNULL_END
