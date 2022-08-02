//
//  DraftSharedManager.h
//  Wellthier
//
//  Created by Craig Lee on 8/2/22.
//

#import <Foundation/Foundation.h>
#import "Draft.h"

NS_ASSUME_NONNULL_BEGIN

@interface DraftSharedManager : NSObject

@property (nonatomic, strong) NSMutableArray <Draft *> *allDraftObjects;
@property (nonatomic, strong) NSMutableArray <NSDictionary *> *allDraftDictionaries;

+ (id)sharedManager;
- (void)fetchAllDrafts;
- (void)addDraftToFile:(NSDictionary*) draft;

@end

NS_ASSUME_NONNULL_END
