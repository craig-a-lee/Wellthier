//
//  Draft.h
//  Wellthier
//
//  Created by Craig Lee on 8/2/22.
//

#import <Foundation/Foundation.h>

#import <Parse/Parse.h>

NS_ASSUME_NONNULL_BEGIN

@interface Draft : NSObject

@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *draftText;
@property (nonatomic, strong) NSData *draftImage;

- (id) initWithDictionary:(NSDictionary *)dictionary;
+ (NSArray *) draftsWithDictionaries: (NSArray *) dictionaries;

@end

NS_ASSUME_NONNULL_END
