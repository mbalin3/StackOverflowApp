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

@interface StackOverflowQustionsListViewController ()


//@property (strong, nonatomic)


@end

@implementation StackOverflowQustionsListViewController
{
    IBOutlet UILabel *headerLabel;
    NSMutableArray *tempArray;
    CollectionViewListLayout *listlayout;
    StackOverflowQuestionViewModel *questionsViewModel;
    IBOutlet UIButton *reloadButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Questions";
    headerLabel.text = @"Questions tagged \"iOS\" ";
    questionsViewModel = [[StackOverflowQuestionViewModel alloc] init];
    tempArray = [[NSMutableArray alloc] init];
    
    [self requestJSON:@"https://api.stackexchange.com/2.2/questions?pagesize=50&order=desc&sort=creation&tagged=ios&site=stackoverflow"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self initCollectionView];
}

-(void)initCollectionView {
    listlayout = [[CollectionViewListLayout alloc] init];
    self.questionsCollectionView.dataSource = self;
    self.questionsCollectionView.collectionViewLayout = listlayout;
}

-(void)reloadCollectionView {
    tempArray = [questionsViewModel getMostRecentQusetions];
    [self.questionsCollectionView reloadData];
}

-(void)requestJSON: (NSString *) url{
    HttpClient *getStackOverflowQuestions = [[HttpClient alloc] initWithUrl:url];
    [getStackOverflowQuestions sendRequest:url success:^(NSDictionary *responseJson) {
        
        NSLog(@"RESPONSE JSON: %@", responseJson);
        [questionsViewModel mapJSONDataToQuestion:responseJson];
        tempArray = [questionsViewModel getMostRecentQusetions];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.questionsCollectionView reloadData];
        });
        } failure:^(NSError *error){
            NSLog(@"ERROR ::  %@", error.localizedDescription)	;
    }];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return tempArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"StackOverflowQuestionCell";
   
    StackOverflowQuestionCell *questionCell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    //NSAssert(self.tempArray != nil);
    if(tempArray.count != 0) {
        questionCell.questionLabel.text = [[tempArray objectAtIndex:indexPath.row] questionTitle];
        questionCell.numberOfAnswers.text = [NSString stringWithFormat:@"%d",[[tempArray objectAtIndex:indexPath.row] numberOfAnswersforQuestion]];
        questionCell.answersLabel.text = [questionsViewModel hasMultipleAnswers:[[tempArray objectAtIndex:indexPath.row] numberOfAnswersforQuestion]];
        questionCell.timeElapsedLabel.text = [questionsViewModel formatTimeToString:[[tempArray objectAtIndex:indexPath.row] timeElapsed]];
        NSLog(@"Time elapsed:::%@", [[tempArray objectAtIndex:indexPath.row] timeElapsed]);
        
        if([[tempArray objectAtIndex:indexPath.row] isAnswerAccepted] ) {
            NSLog(@"isAnswered and GREEN %d ----> Count %@", [[tempArray objectAtIndex:indexPath.row] isAnswerAccepted], [NSString stringWithFormat:@"%d",[[tempArray objectAtIndex:indexPath.row] numberOfAnswersforQuestion]]);
            [questionCell.numberOfAnswersView setBackgroundColor: [UIColor colorWithRed:0.37 green:0.75 blue:0.49 alpha:1.0]];
        }
        
        CGFloat fontSize = 12.0;
        NSMutableArray *allTagsForQuestion = [[NSMutableArray alloc] init];
        allTagsForQuestion = [tempArray[indexPath.row] questionTags] ;
        for (int tagsIndex = 0; tagsIndex < allTagsForQuestion.count; tagsIndex++) {
            UITextField *newTag = [[UITextField alloc] init];
            newTag.text = [NSString stringWithFormat:@"   %@  ", allTagsForQuestion[tagsIndex]];
            newTag.font = [newTag.font fontWithSize:fontSize];
            newTag.layer.cornerRadius = 5;
            newTag.userInteractionEnabled = NO;
            [newTag setBackgroundColor: [UIColor colorWithRed:0.92 green:0.92 blue:0.92 alpha:1.0]];
            [newTag setTextColor: [UIColor colorWithRed:0.45 green:0.45 blue:0.45 alpha:1.0]];
            [questionCell.tagsStackview addArrangedSubview:newTag];
        }
    }
    return questionCell;
}

-(void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [self.questionsCollectionView.collectionViewLayout invalidateLayout];
    [self.questionsCollectionView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
