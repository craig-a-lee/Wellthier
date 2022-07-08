//
//  ExerciseAPIManager.h
//  Wellthier
//
//  Created by Craig Lee on 7/8/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ExerciseAPIManager : NSObject

- (void) fetchAllExercises: (void(^)(NSArray *exercises, NSError *error))completion;

@end

NS_ASSUME_NONNULL_END
