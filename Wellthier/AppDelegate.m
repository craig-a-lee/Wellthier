//
//  AppDelegate.m
//  Wellthier
//
//  Created by Craig Lee on 7/6/22.
//

#import <Parse/Parse.h>
#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    ParseClientConfiguration *config = [ParseClientConfiguration  configurationWithBlock:^(id<ParseMutableClientConfiguration> configuration) {
        configuration.applicationId = @"X0oPQxZ9JY0Wmwb5DgleCECZJNqjdK5NXOXuBKWw";
        configuration.clientKey = @"fShMEGtvQdVH4feEwSLJCMMXyIqcOi7MMJqjoRGw";
        configuration.server = @"https://parseapi.back4app.com";
    }];
    [Parse initializeWithConfiguration:config];
    return YES;
}

- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}

@end
