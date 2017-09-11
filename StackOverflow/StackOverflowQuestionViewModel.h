//
//  StackOverflowQuestionViewModel.h
//  StackOverflow
//
//  Created by DVT Hyde Park on 2017/08/28.
//  Copyright © 2017 DVT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StackoverflowQuestion.h"
#import "StackOverflowQuestionCell.h"

@interface StackOverflowQuestionViewModel : NSObject

@property(nonatomic) NSMutableArray *mostRecentQuestions;

- (instancetype)init;
- (void) mapJSONDataToQuestion:(NSDictionary*)json;
- (NSMutableArray*) allRecentQuestions;
- (NSString*) hasMultipleAnswers:(NSInteger)numberOfAnswerForQuestion;
- (NSString*) hoursElapsedString: (NSInteger)hoursElaped;
- (NSString*) formatTimeToString:(NSDate*)time;
- (void) createQuestionTagsFromArray: (NSMutableArray*)allTagsForQuestion cellToAddTags:(StackOverflowQuestionCell*)questionCell;
- (BOOL) checkAcceptanceofAnswer: (NSInteger)acceptedAnswerId;
- (void) makeViewBackgroundGreenIfAnswerAccepted: (BOOL)isAnswerAccepted
                                withAcceptanceId: (NSInteger)acceptedAnswerId
                             cellToChangeToGreen: (StackOverflowQuestionCell*)questionCell;
@end
