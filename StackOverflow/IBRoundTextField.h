//
//  IBRoundTextField.h
//  StackOverflow
//
//  Created by DVT Hyde Park on 2017/09/04.
//  Copyright © 2017 DVT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IBRoundTextField : UITextField

@property(nonatomic) IBInspectable CGFloat fontSize;
@property(nonatomic) IBInspectable CGFloat cornerRadius;
@property(nonatomic) IBInspectable BOOL isTextFieldEnabled;

@end
