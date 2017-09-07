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

- (void) setUp {
    [super setUp];
    self.stackoverflowQuestionViewModelTotest = [StackOverflowQuestionViewModel new];
}

- (void) tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

 - (void) testPluralityOfAnswer {
     int inputAnswersCount = 1;
     NSString *resultantString = [self.stackoverflowQuestionViewModelTotest hasMultipleAnswers:inputAnswersCount];
     NSString *expectedString = @" %d Answer";
 
     XCTAssertEqualObjects(expectedString, resultantString, @"The output is incorrect");
 }

- (void) testPluralityOfHours {
    NSInteger inputHoursElapsed = 0;
    NSString *resultantTimeString = [self.stackoverflowQuestionViewModelTotest hoursElapsedString: inputHoursElapsed];
    NSString *expectedTimeString = [NSString stringWithFormat:@"%ld hours ago", inputHoursElapsed];;
    
    XCTAssertEqualObjects(expectedTimeString, resultantTimeString, @"The output is incorrect");
}

- (void) testAcceptanceOfAnswer {
    int acceptedAnswerId = 0214541;
    BOOL result = [self.stackoverflowQuestionViewModelTotest checkAcceptanceofAnswer:acceptedAnswerId];
   
    XCTAssertTrue(result, @"The output is incorrect");
}

@end
