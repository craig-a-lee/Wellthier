//
//  PostCell.h
//  Wellthier
//
//  Created by Craig Lee on 7/19/22.
//

#import <UIKit/UIKit.h>

@import Parse;

NS_ASSUME_NONNULL_BEGIN

@interface PostCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *profilePic;
@property (weak, nonatomic) IBOutlet UILabel *displayName;
@property (weak, nonatomic) IBOutlet UITextView *postText;
@property (weak, nonatomic) IBOutlet PFImageView *postImageView;
@property (weak, nonatomic) IBOutlet UILabel *date;

@end

NS_ASSUME_NONNULL_END
