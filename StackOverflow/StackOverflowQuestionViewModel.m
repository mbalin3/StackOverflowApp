
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

-(void)mapJSONDataToQuestion:(NSDictionary*)json {
    
    NSArray *items = [json objectForKey:@"items"];
    NSLog(@"items count:: %lu", (unsigned long)[items count]);
    
    for(int index=0; index < [items count]; index++) {
        StackoverflowQuestion *questionItem = [[StackoverflowQuestion alloc] init];
        [questionItem setQuestionTitle: [[items objectAtIndex:index] objectForKey: @"title"]];
        questionItem.numberOfAnswersforQuestion = [[[items objectAtIndex:index] objectForKey:@"answer_count"] intValue];
        questionItem.isAnswerAccepted = [[[items objectAtIndex:index] objectForKey:@"is_answered"] boolValue];
        questionItem.timeElapsed = [[items objectAtIndex:index] objectForKey:@"creation_date"];
        questionItem.questionTags = [[items objectAtIndex:index] objectForKey:@"tags"] ;
        
        NSLog(@"Adding questionItem:...%@", questionItem.questionTitle);
        NSLog(@"Adding TIME:...%@", (questionItem.timeElapsed));
        [self.mostRecentQuestions addObject:questionItem];
    }
     NSLog(@"question count:: %lu", (unsigned long)[self.mostRecentQuestions count]);
}


-(NSMutableArray*)getMostRecentQusetions {
    return self.mostRecentQuestions;
}

-(NSString*)formatTimeToString:(NSDate*)time {
    //NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    
    //long newTime = time/(1000*60*60);
    long now = (long)(NSTimeInterval)([[NSDate date] timeIntervalSince1970]);
    
    NSLog(@"COnverted time::  %ld ", now);
    NSString *timeString = [NSString stringWithFormat:@"%@", time];
    long convertedTime = [timeString longLongValue];
    //long newTime = convertedTime/(1000*60*60);
    long newTime = now - convertedTime;
    long toNewTime = newTime/(1000*60*60);
    NSLog(@"RESULT time %ld",toNewTime);
    
    return [NSString stringWithFormat:@"%ld hours ago", toNewTime];
}

-(NSString*)hasMultipleAnswers:(int)numberOfAnswerForQuestion {
    if (numberOfAnswerForQuestion == 1) {
        return @"Answer";
    } else {
        return @"Answers";
    }
}

@end
