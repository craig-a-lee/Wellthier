//
//  DraftSharedManager.h
//  Wellthier
//
//  Created by Craig Lee on 8/2/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DraftSharedManager : NSObject

@property (nonatomic, strong) NSMutableDictionary <NSString *, NSDictionary *> *allDrafts;

+ (id)sharedManager;
- (void)fetchAllDrafts;
- (void)addDraftToFile:(NSDictionary *)draft forUser:(NSString *)username;
- (NSDictionary *)fetchDraftForUser:(NSString *) username;

@end

NS_ASSUME_NONNULL_END
