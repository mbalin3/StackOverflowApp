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

@interface StackOverflowQustionsListViewController ()
@property (strong, nonatomic) IBOutlet UICollectionView *questionsCollectionView;
@property (weak, nonatomic) IBOutlet UILabel *headerLabel;
@property (strong, nonatomic) NSArray *tempArray;
@property (nonatomic) CollectionViewListLayout *listlayout;

@end

@implementation StackOverflowQustionsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Questions";
    
    self.headerLabel.text = @"Questions tagged ---";
    self.tempArray = @[@"iOS: add imageView in a scrollview dsafds", @"Constraints not working in UITableview dgsdfds", @"Reading from a Firebase database dfgdfgdg", @"How to update toValue/fromValue over gfdfd", @"Json object that return from Api fddghfd", @"Fragment - how can getActivity() dfgdfgdg", @"gfdfd", @"fddghfd", @"dfgdfgdg"];
    
    [self getJSONData];
    [self initCollectionView];
    
}


-(void)getJSONData {
    NSError *error;
    NSString *url_string = [NSString stringWithFormat:@"https://api.stackexchange.com/2.2/questions?pagesize=50&order=desc&sort=activity&tagged=ios&site=stackoverflow"];
    NSData *data = [NSData dataWithContentsOfURL: [NSURL URLWithString:  url_string]];
    NSMutableDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    NSLog(@"json: %@", json);
}

-(void)initCollectionView {
    self.listlayout = [[CollectionViewListLayout alloc] init];
    self.questionsCollectionView.dataSource = self;
    self.questionsCollectionView.collectionViewLayout = self.listlayout;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.tempArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"StackOverflowQuestionCell";
    
    StackOverflowQuestionCell *questionCell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    questionCell.questionLabel.text = [self.tempArray objectAtIndex:indexPath.row];
    questionCell.numberOfAnswers.text = @"3";
   // questionCell.numberOfAnswersView.layer.cornerRadius = 25;
    questionCell.answersLabel.text = @"Answers";
    questionCell.timeElapsedLabel.text = @"2 hours ago";
    
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
