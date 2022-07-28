//
//  MainTabBarController.m
//  Wellthier
//
//  Created by Craig Lee on 7/28/22.
//

#import <QuartzCore/QuartzCore.h>
#import "MainTabBarController.h"

@interface MainTabBarController () <UITabBarControllerDelegate>

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITabBarAppearance *appearance = [UITabBarAppearance new];
    appearance.backgroundColor = [UIColor blackColor];
    appearance.shadowImage = [UIImage new];
    appearance.shadowColor = [UIColor lightGrayColor];
    appearance.stackedLayoutAppearance.normal.iconColor = [UIColor lightGrayColor];
    self.delegate = self;
    self.tabBar.standardAppearance = appearance;
    
}

@end
