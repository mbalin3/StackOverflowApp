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



-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if(self) {
        [self initDefaultProperties];
    }
    return self;
}

-(void) initDefaultProperties {
   
    _cornerRadius = 15;
    _isTextFieldEnabled = NO;
    _fontSize = 12;
    
    self.font = [self.font fontWithSize:_fontSize];
    self.layer.cornerRadius = self.cornerRadius;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [super drawRect:rect];
    [self initDefaultProperties];
    
}


@end
