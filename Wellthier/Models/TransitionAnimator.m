//
//  TransitionAnimator.m
//  Wellthier
//
//  Created by Craig Lee on 7/29/22.
//

#import "TransitionAnimator.h"
#import <UIKit/UIKit.h>
#import "WorkoutViewController.h"
#import "LibraryViewController.h"

@implementation TransitionAnimator

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    WorkoutViewController* toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    LibraryViewController* fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    [[transitionContext containerView] addSubview:toView];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        toView.frame = [transitionContext finalFrameForViewController:toViewController];
        [toView layoutIfNeeded];
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];

}


@end
