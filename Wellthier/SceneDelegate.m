//
//  SceneDelegate.m
//  Wellthier
//
//  Created by Craig Lee on 7/6/22.
//

#import "SceneDelegate.h"
#import "Parse/Parse.h"
#import "ExerciseSharedManager.h"
#import "DraftSharedManager.h"

@interface SceneDelegate ()

@end

@implementation SceneDelegate

- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *exerciseDataFilePath = [documentsDirectory stringByAppendingPathComponent:@"ExerciseData.plist"];
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:exerciseDataFilePath]) {
        NSDictionary *attributes = [manager attributesOfItemAtPath:exerciseDataFilePath error:nil];
        unsigned long long size = [attributes fileSize];
        if (attributes && size == 0) {
            [[ExerciseSharedManager sharedManager] fetchAllExercisesFromApi];
        } else {
            [[ExerciseSharedManager sharedManager] fetchAllExercisesFromFile];
        }
    } else {
        [[ExerciseSharedManager sharedManager] fetchAllExercisesFromApi];
    }
    
    [[DraftSharedManager sharedManager] fetchAllDrafts];
    
    if (PFUser.currentUser) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];

        self.window.rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"MainTabBarController"];
    }
    
}

@end
