//
//  HttpClient.h
//  StackOverflow
//
//  Created by DVT Hyde Park on 2017/08/28.
//  Copyright © 2017 DVT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpClient : NSObject<NSURLSessionDataDelegate>

@property(nonatomic) NSMutableData *response;
@property(nonatomic) NSString *url;

-(instancetype)initWithUrl:(NSString*)url;

@end
