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

@property (nonatomic, weak) IBOutlet UIButton *toProfileHiddenButton;
@property (nonatomic, weak) IBOutlet UILabel *displayNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *usernameLabel;
@property (nonatomic, weak) IBOutlet UILabel *date;
@property (nonatomic, weak) IBOutlet UITextView *postTextView;
@property (nonatomic, weak) IBOutlet PFImageView *postImageView;
@property (nonatomic, weak) IBOutlet PFImageView *profilePicView;
@property (nonatomic, strong) Post *detailPost;

- (void)setPostDetails:(Post *)post;

@end

NS_ASSUME_NONNULL_END
