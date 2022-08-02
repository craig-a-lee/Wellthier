//
//  DraftSharedManager.m
//  Wellthier
//
//  Created by Craig Lee on 8/2/22.
//

#import "DraftSharedManager.h"
#import "Draft.h"

@implementation DraftSharedManager

+ (id)sharedManager {
    static DraftSharedManager *commonManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        commonManager = [[self alloc] init];
    });
    return commonManager;
}

- (void)addDraftToFile:(NSDictionary*) draft {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"DraftData.plist"];
    Draft *draftObject = [Draft new];
    draftObject.username = draft[@"username"];
    draftObject.draftText = draft[@"draftText"];
    draftObject.draftImage = draft[@"draftImage"];
    [self.allDraftDictionaries addObject:draft];
    [self.allDraftObjects addObject:draftObject];
    [self.allDraftDictionaries writeToFile:filePath atomically:YES];
}

- (void)fetchAllDrafts {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"DraftData.plist"];
    NSArray *draftsFromFile = [NSArray new];
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]) {
        NSDictionary *attributes = [manager attributesOfItemAtPath:filePath error:nil];
        unsigned long long size = [attributes fileSize];
        if (attributes && size == 0) {
            self.allDraftDictionaries = [NSMutableArray new];
            self.allDraftObjects = [NSMutableArray new];
        } else {
            draftsFromFile = [NSArray arrayWithContentsOfFile:filePath];
            self.allDraftDictionaries = (NSMutableArray *) draftsFromFile;
            self.allDraftObjects = (NSMutableArray *) [Draft draftsWithDictionaries:draftsFromFile];
        }
    } else {
        self.allDraftDictionaries = [NSMutableArray new];
        self.allDraftObjects = [NSMutableArray new];
    }
}


@end
