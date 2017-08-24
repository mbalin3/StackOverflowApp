//
//  StackoverflowQuestion.h
//  StackOverflow
//
//  Created by DVT Hyde Park on 2017/08/23.
//  Copyright © 2017 DVT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StackoverflowQuestion : NSObject

@property(nonatomic, copy) NSString *questionTitle;
@property(nonatomic) int numberOfAnswers;
@property(nonatomic) BOOL isAnswerAccepted;
@property(nonatomic) int timeElapsed;
@property(nonatomic) NSArray *questionTags;

@end
