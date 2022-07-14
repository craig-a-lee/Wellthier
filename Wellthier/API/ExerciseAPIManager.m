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
    self.headers =  @{ @"X-RapidAPI-Key": @"59155f3b42msh4c970b09e3798d7p149cb3jsnd367e6d28891",
                       @"X-RapidAPI-Host": @"exercisedb.p.rapidapi.com" };
    return self;
}

- (void) fetchAllExercises: (void(^)(NSArray *exercises, NSError *error))completion {

    NSMutableURLRequest *request = [self urlRequestForItems:@""];

    NSURLSessionDataTask *dataTask = [self.session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    if (error) {
                                                        NSLog(@"%@", error);
                                                    } else {
                                                        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                                                        NSLog(@"%@", httpResponse);
                                                        NSArray *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];

                                                        //NSArray *dictionaries = dataDictionary;
                                                        NSArray *exercises = [Exercise exercisesWithDictionaries:dataDictionary];
                                                        completion(exercises, nil);
                                                        
                                                    }
                                                }];
    [dataTask resume];
}

- (NSMutableURLRequest *) urlRequestForItems: (NSString *) itemsName {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://exercisedb.p.rapidapi.com/exercises%@", itemsName]]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"GET"];
    [request setAllHTTPHeaderFields:self.headers];
    
    return request;
}

- (void) fetchBodyParts: (void(^)(NSArray *bodyParts, NSError *error))completion {
    NSMutableURLRequest *request = [self urlRequestForItems:@"/bodyPartList"];
    


    NSURLSessionDataTask *dataTask = [self.session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    if (error) {
                                                        NSLog(@"%@", error);
                                                    } else {
                                                        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                                                        NSLog(@"%@", httpResponse);
                                                        NSArray *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                                                        completion(dataDictionary, nil);
                                                    }
                                                }];
    [dataTask resume];

}
@end
