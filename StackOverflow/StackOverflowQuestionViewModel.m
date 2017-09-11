
//
//  StackOverflowQuestionViewModel.m
//  StackOverflow
//
//  Created by DVT Hyde Park on 2017/08/28.
//  Copyright © 2017 DVT. All rights reserved.
//

#import "StackOverflowQuestionViewModel.h"
#import "StackOverflowQustionsListViewController.h"
#import "StackOverflowQuestionCell.h"
#import "HttpClient.h"
#import "CustomColors.h"


@implementation StackOverflowQuestionViewModel

- (instancetype)init {
    self = [super init];
    
    if(self) {
        self.mostRecentQuestions = [NSMutableArray array];
    }
    return self;
}

- (void) mapJSONDataToQuestion: (NSDictionary*)json {
    
    NSAssert(json != nil, @"The questions json object is nil");
    NSArray *items = [json objectForKey:@"items"];
    NSLog(@"items count:: %ld", items.count);
    
    for (int index=0; index < [items count]; index++) {
        StackoverflowQuestion *questionItem = [[StackoverflowQuestion alloc] init];
        [questionItem setQuestionTitle: [[items objectAtIndex:index] objectForKey: @"title"]];
        [questionItem setAnswerCount: [[[items objectAtIndex:index] objectForKey:@"answer_count"] integerValue]];
        [questionItem setAcceptedAnswerId:[[[items objectAtIndex:index] objectForKey:@"accepted_answer_id"] longValue]];
        [questionItem setIsAnswerAccepted: [self checkAcceptanceofAnswer:questionItem.acceptedAnswerId]];
        [questionItem setTimeElapsed: [[items objectAtIndex:index] objectForKey:@"creation_date"]];
        [questionItem setQuestionTags: [[items objectAtIndex:index] objectForKey:@"tags"]];
        
        [self.mostRecentQuestions addObject:questionItem];
        [self setMostRecentQuestions:self.mostRecentQuestions];
    }
     NSLog(@"question count:: %lu", (unsigned long)[self.mostRecentQuestions count]);
}

- (NSMutableArray *)allRecentQuestions {
    NSAssert(self.mostRecentQuestions != 0, [NSString stringWithFormat: @"The 'mostRecentQuestions' array count is 0"]);
    return self.mostRecentQuestions;
}


- (BOOL) checkAcceptanceofAnswer: (NSInteger)acceptedAnswerId {
    if (acceptedAnswerId != 0) {
        return 1;
    } else {
        return 0;
    }
}

- (NSString*) formatTimeToString: (NSDate*)time {
    long now = (long)(NSTimeInterval)([[NSDate date] timeIntervalSince1970]);
    NSString *timeString = [NSString stringWithFormat:@"%@", time];
    long convertedTime = [timeString longLongValue];
    long newTime = now - convertedTime;
    long toNewTime = newTime/(1000*60*60);
    NSLog(@"Time elapsed:::%ld", toNewTime);
    
    return [self hoursElapsedString: toNewTime];
}

- (NSString*) hasMultipleAnswers: (NSInteger)numberOfAnswerForQuestion {
    if (numberOfAnswerForQuestion == 1) {
        return @"Answer";
    } else {
        return @"Answers";
    }
}

- (NSString*) hoursElapsedString: (NSInteger)hoursElaped {
    if (hoursElaped ==1) {
        return [NSString stringWithFormat: @"%ld hour ago", hoursElaped];
    } else {
        return [NSString stringWithFormat: @"%ld hours ago", hoursElaped];
    }
}

- (void) makeViewBackgroundGreenIfAnswerAccepted: (BOOL)isAnswerAccepted
                                withAcceptanceId: (NSInteger)acceptedAnswerId
                             cellToChangeToGreen: (StackOverflowQuestionCell*)questionCell {
    
    if(acceptedAnswerId > 0 && isAnswerAccepted) {
        [questionCell.numberOfAnswersView setBackgroundColor: [UIColor acceptanceGreenColor]];
    } else {
        [questionCell.numberOfAnswersView setBackgroundColor: [UIColor grayViewsBackgroundColor]];
    }
}

- (void) createQuestionTagsFromArray: (NSMutableArray*)allTagsForQuestion cellToAddTags:(StackOverflowQuestionCell*)questionCell {
    for (int tagsIndex = 0; tagsIndex < allTagsForQuestion.count; tagsIndex++) {
        UITextField *newTag = [UITextField new];
        newTag.text = [NSString stringWithFormat:@"   %@  ", allTagsForQuestion[tagsIndex]];
        newTag.layer.cornerRadius = 5;
        newTag.userInteractionEnabled = NO;
        newTag.font = [newTag.font fontWithSize:(CGFloat)12];
        newTag.textColor = [UIColor darkGrayTextColor];
        newTag.backgroundColor =  [UIColor grayViewsBackgroundColor];
        
        [questionCell.tagsStackview addArrangedSubview:newTag];
    }
}

@end
