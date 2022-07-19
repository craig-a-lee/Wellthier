//
//  ExerciseAPIManager.m
//  Wellthier
//
//  Created by Craig Lee on 7/8/22.
//

#import "ExerciseAPIManager.h"
#import "Exercise.h"

@interface ExerciseAPIManager()

@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) NSDictionary *headers;

@end

@implementation ExerciseAPIManager

-(id) init {
    self = [super init];
    self.session = [NSURLSession sharedSession];
    self.headers =  @{ @"X-RapidAPI-Key": @"e99f2849d4msh4efe5bd2dd65144p123359jsn5caff4b8683d",
                       @"X-RapidAPI-Host": @"exercisedb.p.rapidapi.com" };
    return self;
}

- (void) fetchAllExercises: (void(^)(NSArray *exercises, NSError *error))completion {

    NSMutableURLRequest *request = [self urlRequestForItems:@""];
    [self makeRequest:request completion:^(id object, NSError *error) {
                                                            if (error) {
                                                            } else {
                                                                if ([object isKindOfClass:[NSArray class]]) {
                                                                    NSArray *allExercises = (NSArray *)object;
                                                                    NSArray *exercises = [Exercise exercisesWithDictionaries:allExercises];
                                                                    completion(exercises, nil);
                                                                }
                                                            }
    }];
}

- (NSMutableURLRequest *) urlRequestForItems: (NSString *) itemsName {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://exercisedb.p.rapidapi.com/exercises%@", itemsName]]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"GET"];
    [request setAllHTTPHeaderFields:self.headers];
    
    return request;
}

- (void) makeRequest:(NSMutableURLRequest *)request completion:(void(^)(id object, NSError *error))completion {
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    if (error) {
                                                    } else {
                                                        id dataObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                                                        completion(dataObject, nil);
                                                    }
                                                }];
    [dataTask resume];
}

@end
