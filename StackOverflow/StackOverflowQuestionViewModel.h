//
//  StackOverflowQuestionViewModel.h
//  StackOverflow
//
//  Created by DVT Hyde Park on 2017/08/28.
//  Copyright © 2017 DVT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StackoverflowQuestion.h"

@interface StackOverflowQuestionViewModel : NSObject

@property(nonatomic) NSMutableArray *mostRecentQuestions;

-(instancetype)init;
-(void)mapJSONDataToQuestion:(NSDictionary*)json;
-(NSMutableArray*)getMostRecentQusetions;
-(NSString*)hasMultipleAnswers:(int)numberOfAnswerForQuestion;
-(NSString*)formatTimeToString:(NSDate*)time;
@end
