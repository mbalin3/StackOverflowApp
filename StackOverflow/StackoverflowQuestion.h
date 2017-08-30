//
//  StackoverflowQuestion.h
//  StackOverflow
//
//  Created by DVT Hyde Park on 2017/08/23.
//  Copyright © 2017 DVT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StackoverflowQuestion : NSObject

@property(nonatomic, copy) NSMutableString *questionTitle;
@property(nonatomic) int numberOfAnswersforQuestion;
@property(nonatomic) BOOL isAnswerAccepted;
@property(nonatomic) NSString *timeElapsed;
@property(nonatomic) NSMutableArray *questionTags;

@end
