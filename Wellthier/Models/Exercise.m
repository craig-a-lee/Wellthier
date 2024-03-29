//
//  Exercise.m
//  Wellthier
//
//  Created by Craig Lee on 7/8/22.
//

#import "Exercise.h"

@implementation Exercise

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    self.name = dictionary[@"name"];
    self.target = dictionary[@"target"];
    self.equipment = dictionary[@"equipment"];
    self.bodyPart = dictionary[@"bodyPart"];
    NSString *gifString = dictionary[@"gifUrl"];
    gifString = [gifString stringByReplacingOccurrencesOfString:@"http" withString:@"https"];
    self.gifUrl = [NSURL URLWithString:gifString];
    self.exerciseID = dictionary[@"id"];
    return self;
}

+ (NSArray <Exercise *>*)exercisesWithDictionaries:(NSArray *)dictionaries {
    NSMutableArray *exercises = [[NSMutableArray alloc] init];
    for (NSDictionary *dictionary in dictionaries) {
        Exercise *exercise = [[Exercise alloc] initWithDictionary:dictionary];
        [exercises addObject:exercise];
    }
    return exercises;
}

@end
