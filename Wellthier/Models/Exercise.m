//
//  Exercise.m
//  Wellthier
//
//  Created by Craig Lee on 7/8/22.
//

#import "Exercise.h"

@implementation Exercise

- (id) initWithDictionary:(NSDictionary *)dictionary {
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

+ (NSArray *) exercisesWithDictionaries: (NSArray *) dictionaries {
    NSMutableArray *exercises = [[NSMutableArray alloc] init];
    for (NSDictionary *dictionary in dictionaries) {
        Exercise *exercise = [[Exercise alloc] initWithDictionary:dictionary];
        [exercises addObject:exercise];
    }
    return exercises;
}

#pragma mark NSCoding

#define kNameKey            @"Title"
#define kTargetKey          @"target"
#define kEquipmentKey       @"equipment"
#define kBodyPartKey        @"bodyPart"
#define kGifKey             @"gifUrl"
#define kExerciseIDKey      @"id"

- (void) encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:_name forKey:kNameKey];
    [encoder encodeObject:_target forKey:kTargetKey];
    [encoder encodeObject:_equipment forKey:kEquipmentKey];
    [encoder encodeObject:_bodyPart forKey:kBodyPartKey];
    [encoder encodeObject:_gifUrl forKey:kGifKey];
    [encoder encodeObject:_exerciseID forKey:kExerciseIDKey];
}

- (id)initWithCoder:(NSCoder *)decoder {
    NSString *name = [decoder decodeObjectForKey:kNameKey];
    NSString *target = [decoder decodeObjectForKey:kTargetKey];
    NSString *equipment = [decoder decodeObjectForKey:kEquipmentKey];
    NSString *bodyPart = [decoder decodeObjectForKey:kBodyPartKey];
    NSString *gifUrl = [decoder decodeObjectForKey:kGifKey];
    NSString *exerciseID = [decoder decodeObjectForKey:kExerciseIDKey];
    NSDictionary *dictionary = @{@"name": name, @"target": target, @"equipment": equipment, @"bodyPart": bodyPart, @"gifUrl": gifUrl, @"id": exerciseID};
    return [self initWithDictionary:dictionary];
}

@end
