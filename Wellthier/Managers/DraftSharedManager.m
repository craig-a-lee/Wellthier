//
//  DraftSharedManager.m
//  Wellthier
//
//  Created by Craig Lee on 8/2/22.
//

#import "DraftSharedManager.h"

@implementation DraftSharedManager

+ (id)sharedManager {
    static DraftSharedManager *commonManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        commonManager = [[self alloc] init];
    });
    return commonManager;
}

- (void)addDraftToFile:(NSDictionary*)draft forUser:(NSString *) username {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"DraftData.plist"];
    [self.allDrafts setObject:draft forKey:username];
    [self.allDrafts writeToFile:filePath atomically:YES];
}

- (void)fetchAllDrafts {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"DraftData.plist"];
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]) {
        NSDictionary *attributes = [manager attributesOfItemAtPath:filePath error:nil];
        unsigned long long size = [attributes fileSize];
        if (attributes && size == 0) {
            self.allDrafts = [NSMutableDictionary new];
        } else {
            self.allDrafts = [NSMutableDictionary dictionaryWithContentsOfFile:filePath];
        }
    } else {
        self.allDrafts = [NSMutableDictionary new];
    }
}

- (NSDictionary *)fetchDraftForUser:(NSString *) username {
    return self.allDrafts[username];
}


@end
