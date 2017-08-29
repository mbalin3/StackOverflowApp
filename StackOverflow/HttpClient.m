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
        [self sendRequest:url];
    }
    return self;
}

-(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler {

        NSHTTPURLResponse *httpresponse = (NSHTTPURLResponse*)response;
        NSLog(@"FINALLY got DELEGATE:  Recieved response CODE....%ld", (long)httpresponse.statusCode);
        if(httpresponse.statusCode >= 200 || httpresponse.statusCode <= 299) {
             completionHandler(NSURLSessionResponseAllow);
        }
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {
 
     NSLog(@"DATA response: -------> %@ ", data);
     NSError *error = nil;
    if(data) {
       
            NSDictionary *json=[NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            NSLog(@"JSON response: -------> %@ ", json);
        
        if (json) {
            StackOverflowQuestionViewModel *questionViewModel = [[StackOverflowQuestionViewModel alloc] init];
            [questionViewModel mapJSONDataToQuestion:json];
        } else {
            NSLog(@"An error occurred....>>>> %@", error.localizedDescription);
        }
    }
}

-(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    if(error){
        NSLog(@"An error occured: %@", error);
    }
}

-(void)sendRequest:(NSString *)withUrlString {
    
   // NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSession *sess = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:nil];
    
    NSURL *url = [NSURL URLWithString:withUrlString];
    NSURLSessionDataTask *task = [sess dataTaskWithURL:url];
    [task resume];

}


@end
