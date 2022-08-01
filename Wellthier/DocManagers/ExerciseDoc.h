//
//  ExerciseDoc.h
//  Wellthier
//
//  Created by Craig Lee on 8/1/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ExerciseDoc : NSObject

@property (copy) NSString *docPath;

- (id)init;
- (id)initWithDocPath:(NSString *)docPath;
- (void)saveData;
- (void)deleteDoc;

@end

NS_ASSUME_NONNULL_END
