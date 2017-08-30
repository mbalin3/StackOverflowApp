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

@property (weak, nonatomic) IBOutlet UILabel *headerLabel;
@property (strong, nonatomic) NSMutableArray *tempArray;
@property (nonatomic) CollectionViewListLayout *listlayout;
@property (nonatomic) StackOverflowQuestionViewModel *questionsViewModel;
@property (weak, nonatomic) IBOutlet UIButton *reloadButton;

@end

@implementation StackOverflowQustionsListViewController

@synthesize questionsCollectionView;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Questions";
    
    self.headerLabel.text = @"Questions tagged ---";
    
    self.questionsViewModel = [[StackOverflowQuestionViewModel alloc] init];
   // [self.questionsViewModel getStackOverflowJSON:@"https://api.stackexchange.com/2.2/questions?pagesize=50&order=desc&sort=activity&tagged=ios&site=stackoverflow"];
    
    self.tempArray = [[NSMutableArray alloc] init];
    
    [self requestJSON:@"https://api.stackexchange.com/2.2/questions?pagesize=50&order=desc&sort=activity&tagged=ios&site=stackoverflow"];
   /* self.tempArray = @[@"iOS: add imageView in a scrollview dsafds", @"Constraints not working in UITableview dgsdfds", @"Reading from a Firebase database dfgdfgdg", @"How to update toValue/fromValue over gfdfd", @"Json object that return from Api fddghfd", @"Fragment - how can getActivity() dfgdfgdg", @"gfdfd", @"fddghfd", @"dfgdfgdg"];*/

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self initCollectionView];
}


-(void)initCollectionView {
    self.listlayout = [[CollectionViewListLayout alloc] init];
    self.questionsCollectionView.dataSource = self;
    self.questionsCollectionView.collectionViewLayout = self.listlayout;
}

-(void)reloadCollectionView {
    self.tempArray = [self.questionsViewModel getMostRecentQusetions];
    [self.questionsCollectionView reloadData];
}

-(void)requestJSON: (NSString *) url{
    HttpClient *getStackOverflowQuestions = [[HttpClient alloc] initWithUrl:url];
    [getStackOverflowQuestions sendRequest:url success:^(NSDictionary *responseJson) {
        
        NSLog(@"RESPONSE JSON: %@", responseJson);
        [self.questionsViewModel mapJSONDataToQuestion:responseJson];
        //[self.delegate reloadCollectionView];
        self.tempArray = [self.questionsViewModel getMostRecentQusetions];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.questionsCollectionView reloadData];

        });
            } failure:^(NSError *error){
        NSLog(@"ERROR ::  %@", error.localizedDescription)	;
    }];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.tempArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"StackOverflowQuestionCell";
   
    StackOverflowQuestionCell *questionCell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];

    if(self.tempArray.count != 0) {
        questionCell.questionLabel.text = [[self.tempArray objectAtIndex:indexPath.row] questionTitle];
        questionCell.numberOfAnswers.text = [NSString stringWithFormat:@"%d",[[self.tempArray objectAtIndex:indexPath.row] numberOfAnswersforQuestion]];
        // questionCell.numberOfAnswersView.layer.cornerRadius = 25;
        
        questionCell.answersLabel.text = [self.questionsViewModel hasMultipleAnswers:[[self.tempArray objectAtIndex:indexPath.row] numberOfAnswersforQuestion]];
        questionCell.timeElapsedLabel.text = [[self.tempArray objectAtIndex:indexPath.row] timeElapsed];
    }
    return questionCell;
}



-(void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [self.questionsCollectionView.collectionViewLayout invalidateLayout];
    [self.questionsCollectionView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
