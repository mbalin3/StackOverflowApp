//
//  StackOverflowQuestionViewModel.m
//  StackOverflow
//
//  Created by DVT Hyde Park on 2017/08/28.
//  Copyright © 2017 DVT. All rights reserved.
//

#import "StackOverflowQuestionViewModel.h"
#import "HttpClient.h"

@implementation StackOverflowQuestionViewModel

-(instancetype)init {
    self = [super init];
    
    if(self) {
        self.mostRecentQuestions = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void)getStackOverflowJSON:(NSString*) url {
    dispatch_queue_t jsonQueue = dispatch_queue_create("JSON Queue",NULL);
    
    dispatch_async(jsonQueue, ^{
        
        HttpClient *getStackOverflowQuestions = [[HttpClient alloc] initWithUrl:url];
    });
}

-(void)mapJSONDataToQuestion:(NSDictionary*)json {
    
    NSLog(@"Mapping JSON...  %@", json);
    NSArray *items = [json objectForKey:@"items"];
    NSLog(@"items count:: %lu", (unsigned long)[items count]);
    
    for(int index=0; index < [items count]; index++) {

        StackoverflowQuestion *questionItem = [[StackoverflowQuestion alloc] init];
        questionItem.questionTitle = [[items objectAtIndex:index] objectForKey: @"title"];
        NSLog(@"Adding questionItem:...%@", questionItem.questionTitle);
        [self.mostRecentQuestions addObject:questionItem];
        NSLog(@"question count:: %lu", (unsigned long)[self.mostRecentQuestions count]);
    }
}

-(NSMutableArray*)getMostRecentQusetions {
    return self.mostRecentQuestions;
}

@end
