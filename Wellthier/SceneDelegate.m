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

- (void)sceneDidDisconnect:(UIScene *)scene {
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
}

- (void)sceneDidBecomeActive:(UIScene *)scene {
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
}

- (void)sceneWillResignActive:(UIScene *)scene {
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
}


- (void)sceneWillEnterForeground:(UIScene *)scene {
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the changes made on entering the background.
}


- (void)sceneDidEnterBackground:(UIScene *)scene {
    // Called as the scene transitions from the foreground to the background.
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.
}

@end
