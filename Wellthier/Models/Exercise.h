//
//  Exercise.h
//  Wellthier
//
//  Created by Craig Lee on 7/8/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Exercise : NSObject 

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *bodyPart;
@property (nonatomic, strong) NSString *target;
@property (nonatomic, strong) NSString *equipment;
@property (nonatomic, strong) NSURL *gifUrl;
@property (nonatomic, strong) NSString *exerciseID;

- (id)initWithDictionary:(NSDictionary *)dictionary;
+ (NSArray *)exercisesWithDictionaries:(NSArray *)dictionaries;

@end

NS_ASSUME_NONNULL_END
