//
//  Draft.m
//  Wellthier
//
//  Created by Craig Lee on 8/2/22.
//

#import "Draft.h"

@implementation Draft

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    self.username = dictionary[@"username"];
    self.draftText = dictionary[@"draftText"];
    self.draftImage = dictionary[@"draftImage"];
    return self;
}

+ (NSArray *)draftsWithDictionaries:(NSArray *)dictionaries {
    NSMutableArray *drafts = [[NSMutableArray alloc] init];
    for (NSDictionary *dictionary in dictionaries) {
        Draft *draft = [[Draft alloc] initWithDictionary:dictionary];
        [drafts addObject:draft];
    }
    return drafts;
}

@end
