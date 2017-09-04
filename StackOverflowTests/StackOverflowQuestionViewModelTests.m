//
//  StackOverflowQuestionViewModelTests.m
//  StackOverflow
//
//  Created by DVT Hyde Park on 2017/09/01.
//  Copyright © 2017 DVT. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "StackOverflowQuestionViewModel.h"

@interface StackOverflowQuestionViewModelTests : XCTestCase
@property (nonatomic) StackOverflowQuestionViewModel *stackoverflowQuestionViewModelTotest;
@end

@implementation StackOverflowQuestionViewModelTests

- (void)setUp {
    [super setUp];
    self.stackoverflowQuestionViewModelTotest = [StackOverflowQuestionViewModel new];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

 - (void)testPluralityOfAnswer {
     int inputAnswersCount = 1;
     NSString *resultantString = [self.stackoverflowQuestionViewModelTotest hasMultipleAnswers:inputAnswersCount];
     NSString *expectedString = @"Answer";
 
     XCTAssertEqualObjects(expectedString, resultantString, @"The output is incorrect");
 }

@end
