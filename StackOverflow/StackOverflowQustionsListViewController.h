//
//  ViewController.h
//  StackOverflow
//
//  Created by DVT Hyde Park on 2017/08/21.
//  Copyright © 2017 DVT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StackOverflowQuestionViewModel.h"

@interface StackOverflowQustionsListViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate>
@property (strong, nonatomic) IBOutlet UICollectionView *questionsCollectionView;

@end

