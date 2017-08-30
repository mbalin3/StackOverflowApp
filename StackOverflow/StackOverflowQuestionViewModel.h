//
//  StackOverflowQuestionViewModel.h
//  StackOverflow
//
//  Created by DVT Hyde Park on 2017/08/28.
//  Copyright © 2017 DVT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StackoverflowQuestion.h"

@protocol QuestionDelegate <NSObject>
-(void)reloadCollectionView;
@end

@interface StackOverflowQuestionViewModel : NSObject

@property(nonatomic, weak) id<QuestionDelegate> delegate;
@property(nonatomic) NSMutableArray *mostRecentQuestions;

-(instancetype)init;
-(void)getStackOverflowJSON:(NSString*) url;
-(void)mapJSONDataToQuestion:(NSDictionary*)json;
-(NSMutableArray*)getMostRecentQusetions;
-(NSString*)hasMultipleAnswers:(int)numberOfAnswerForQuestion ;
@end
