//
//  ViewController.m
//  StackOverflow
//
//  Created by DVT Hyde Park on 2017/08/21.
//  Copyright © 2017 DVT. All rights reserved.
//

#import "StackOverflowQustionsListViewController.h"
#import "StackOverflowQuestionCell.h"
#import "CollectionViewListLayout.h"
#import "StackOverflowQuestionViewModel.h"
#import "HttpClient.h"
#import "CustomColors.h"


@interface StackOverflowQustionsListViewController ()

@end

@implementation StackOverflowQustionsListViewController
{
    IBOutlet UILabel *headerLabel;
    NSMutableArray *questionsArray;
    CollectionViewListLayout *listlayout;
    StackOverflowQuestionViewModel *questionsViewModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Questions";
    headerLabel.text = @"Questions tagged \"iOS\" ";
    questionsViewModel = [[StackOverflowQuestionViewModel alloc] init];
    questionsArray = [NSMutableArray array];
    [self initCollectionView];
    [self requestJSON:@"https://api.stackexchange.com/2.2/questions?pagesize=50&order=desc&sort=activity&tagged=ios&site=stackoverflow"];
}

- (void)viewWillAppear: (BOOL)animated {
    [super viewWillAppear:animated];
    [self.questionsCollectionView reloadData];
}

- (void)initCollectionView {
    listlayout = [[CollectionViewListLayout alloc] init];
    self.questionsCollectionView.dataSource = self;
    self.questionsCollectionView.collectionViewLayout = listlayout;
}

- (void)requestJSON: (NSString *)url {
    HttpClient *getStackOverflowQuestions = [[HttpClient alloc] initWithUrl:url];
    [getStackOverflowQuestions sendRequest:url success:^(NSDictionary *responseJson) {
        
        NSLog(@"RESPONSE JSON: %@", responseJson);
        [questionsViewModel mapJSONDataToQuestion:responseJson];
        questionsArray = [questionsViewModel allRecentQuestions];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.questionsCollectionView reloadData];
        });
        } failure:^(NSError *error){
            NSLog(@"ERROR ::  %@", error.localizedDescription);
    }];
}

- (NSInteger)collectionView: (UICollectionView *)collectionView numberOfItemsInSection: (NSInteger)section {
    NSAssert(questionsArray != nil, @"The Questions array is nil");
    return questionsArray.count;
}

- (UICollectionViewCell *)collectionView: (UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"StackOverflowQuestionCell";
   
    StackOverflowQuestionCell *questionCell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    NSAssert(questionsArray != nil, @"The Questions array is nil");
    StackoverflowQuestion *questionAtIndexPath = [questionsArray objectAtIndex:indexPath.item];
    
    if(questionsArray.count != 0) {
        questionCell.questionLabel.text = [questionAtIndexPath questionTitle];
        questionCell.numberOfAnswersLabel.text = [NSString stringWithFormat:@"%ld", [questionAtIndexPath answerCount]];
        questionCell.answersLabel.text = [questionsViewModel hasMultipleAnswers: [questionAtIndexPath answerCount]];
        questionCell.timeElapsedLabel.text = [questionsViewModel formatTimeToString: [questionAtIndexPath timeElapsed]];
        
        NSMutableArray *allTagsForQuestion = [NSMutableArray array];
        allTagsForQuestion = [questionAtIndexPath questionTags] ;
        [questionsViewModel createQuestionTagsFromArray: allTagsForQuestion cellToAddTags:questionCell];
        [questionsViewModel makeViewBackgroundGreenIfAnswerAccepted: [questionAtIndexPath isAnswerAccepted]
                                                   withAcceptanceId: [questionAtIndexPath acceptedAnswerId]
                                                cellToChangeToGreen: questionCell];
    }
    return questionCell;
}

- (void)viewWillTransitionToSize: (CGSize)size withTransitionCoordinator: (id<UIViewControllerTransitionCoordinator>)coordinator {
    [self.questionsCollectionView.collectionViewLayout invalidateLayout];
    [self.questionsCollectionView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
