//
//  TransitionSegue.m
//  Wellthier
//
//  Created by Craig Lee on 7/29/22.
//

#import "TransitionSegue.h"
#import <UIKit/UIKit.h>

@implementation TransitionSegue

- (void) perform {
    self.destinationViewController.transitioningDelegate = self;
    [super perform];
}

@end
