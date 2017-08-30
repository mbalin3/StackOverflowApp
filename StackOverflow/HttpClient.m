//
//  HttpClient.m
//  StackOverflow
//
//  Created by DVT Hyde Park on 2017/08/28.
//  Copyright © 2017 DVT. All rights reserved.
//

#import "HttpClient.h"
#import "StackOverflowQuestionViewModel.h"

@implementation HttpClient


-(instancetype)initWithUrl:(NSString *)url {
    self = [super init];
    
    if(self) {
        _url = url;
       // [self sendRequest:url];
    }
    return self;
}


-(void)sendRequest:(NSString *)withUrlString success:(void (^)(NSDictionary *responseDict))success failure:(void(^)(NSError* error))failure {
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURL *url = [NSURL URLWithString:withUrlString];
    
    
    NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler: ^(NSData *data, NSURLResponse *response, NSError *error) {
    
        NSLog(@"DATA:: %@",data);
        if (error)
            failure(error);
        else {
            NSDictionary *json  = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            NSLog(@"%@",json);
            success(json);
        }
    }];
    
    [task resume];
}


@end
