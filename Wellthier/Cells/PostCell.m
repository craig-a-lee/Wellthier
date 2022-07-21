//
//  PostCell.m
//  Wellthier
//
//  Created by Craig Lee on 7/19/22.
//

#import "PostCell.h"
#import "DateTools/DateTools.h"
#import "Parse/Parse.h"

@import Parse;

@implementation PostCell

//- (void)awakeFromNib {
//    [super awakeFromNib];
//}
//
//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
//}

- (void)setPostDetails: (Post *)post {
    _detailPost = post;
    self.displayName.text = post.author[@"displayName"];
    self.date.text = post.createdAt.shortTimeAgoSinceNow;
    if (post[@"image"]) {
        self.postImageView.file = post[@"image"];
        [self.postImageView loadInBackground];
    }
    self.postText.text = post[@"text"];
    PFImageView *helperImageView = [PFImageView new];
    helperImageView.file = post.author[@"profilePic"];
    [helperImageView loadInBackground];
    [self.profilePic setImage:helperImageView.image forState:UIControlStateNormal];
}

@end
