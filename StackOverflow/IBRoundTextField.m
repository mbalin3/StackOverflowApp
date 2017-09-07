//
//  IBRoundTextField.m
//  StackOverflow
//
//  Created by DVT Hyde Park on 2017/09/04.
//  Copyright © 2017 DVT. All rights reserved.
//

#import "IBRoundTextField.h"
#import "CustomColors.h"

IB_DESIGNABLE

@implementation IBRoundTextField


/*-(void) setTextfieldCornerRadius:(CGFloat)textfieldCornerRadius {
    //self.textfieldCornerRadius = textfieldCornerRadius;
    self.layer.cornerRadius = textfieldCornerRadius;
}

-(CGFloat)textfieldCornerRadius {
    return self.layer.cornerRadius;
}*/

-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if(self) {
        [self initDefaultProperties];
    }
    return self;
}

-(void) initDefaultProperties {
    _colorText = [UIColor darkGrayTextColor];
    //_cornerRadius = 15;
    _isTextFieldEnabled = NO;
    _fontSize = 12;
    
    self.font = [self.font fontWithSize:_fontSize];
    self.textColor = _colorText;
    //self.layer.cornerRadius = self.cornerRadius;
    //self.backgroundColor = self.textFieldBackgroundColor;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [super drawRect:rect];
    [self initDefaultProperties];
    [_textFieldBackgroundColor setStroke];
    //_cornerRadius = 15;
    
}


@end
