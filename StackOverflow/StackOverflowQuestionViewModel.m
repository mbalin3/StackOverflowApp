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

/*-(void)getStackOverflowJSON:(NSString*) url {
    
    HttpClient *getStackOverflowQuestions = [[HttpClient alloc] initWithUrl:url];
    [getStackOverflowQuestions sendRequest:url success:^(NSDictionary *responseJson) {
        
        NSLog(@"RESPONSE JSON: %@", responseJson);
        [self mapJSONDataToQuestion:responseJson];
        [self.delegate reloadCollectionView];
    
    } failure:^(NSError *error){
        NSLog(@"ERROR ::  %@", error.localizedDescription)	;
    }];
}*/

-(void)mapJSONDataToQuestion:(NSDictionary*)json {
    
    NSLog(@"Mapping JSON...  %@", json);
    NSArray *items = [json objectForKey:@"items"];
    NSLog(@"items count:: %lu", (unsigned long)[items count]);
    
    for(int index=0; index < [items count]; index++) {

        StackoverflowQuestion *questionItem = [[StackoverflowQuestion alloc] init];
        questionItem.questionTitle = [[items objectAtIndex:index] objectForKey: @"title"];
        questionItem.numberOfAnswersforQuestion = [[[items objectAtIndex:index] objectForKey:@"answer_count"] intValue];
       // questionItem.isAnswerAccepted = [[items objectAtIndex:index] objectForKey:@"is_answered"];
        questionItem.timeElapsed = [self formatTimeToString:[[items objectAtIndex:index] objectForKey:@"creation_date"]];
        
        questionItem.questionTags = [json valueForKeyPath:@"items.tags"];
        
        NSLog(@"Adding questionItem:...%@", questionItem.questionTitle);
        [self.mostRecentQuestions addObject:questionItem];
       
    }
     NSLog(@"question count:: %lu", (unsigned long)[self.mostRecentQuestions count]);
}


-(NSMutableArray*)getMostRecentQusetions {
    return self.mostRecentQuestions;
}

-(NSString*)formatTimeToString:(NSDate*)time {
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    NSString *timeString = [formatter stringFromDate:time];
    return timeString;
}

-(NSString*)hasMultipleAnswers:(int)numberOfAnswerForQuestion {
    if (numberOfAnswerForQuestion == 1) {
        return @"Answer";
    } else {
        return @"Answers";
    }
}

@end
