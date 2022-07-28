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

- (void)setPostDetails: (Post *)post {
    _detailPost = post;
    self.displayNameLabel.text = post.author[@"displayName"];
    self.date.text = post.createdAt.shortTimeAgoSinceNow;
    if (post[@"image"]) {
        self.postImageView.file = post[@"image"];
        [self.postImageView loadInBackground];
        self.postImageView.hidden = NO;
    } else {
        self.postImageView.image = nil;
        self.postImageView.hidden = YES;
    }
    self.usernameLabel.text = post.author.username;
    self.postTextView.text = post[@"text"];
    self.profilePicView.file = post.author[@"profilePic"];
    [self.profilePicView loadInBackground];
}

- (void) setSelected:(BOOL)selected {
    [super setSelected:selected];
}


@end
