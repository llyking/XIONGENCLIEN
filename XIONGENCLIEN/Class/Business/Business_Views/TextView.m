//
//  TextView.m
//  XIONGEN
//
//  Created by Ios on 2018/1/31.
//  Copyright © 2018年 Ios. All rights reserved.
//

#import "TextView.h"

@implementation TextView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = WhiteColor;
        [self createView];
    }
    return self;
}


-(void)createView {
    
    if (!_lb_left) {
        _lb_left = [[UILabel alloc] init];
        _lb_left.frame = CGRectMake(mergin_left, 0, 70, self.frame.size.height);
        _lb_left.textAlignment = NSTextAlignmentLeft;
        _lb_left.textColor = UIColorFromRGB(0x333333);
        _lb_left.font = LSYUIFont(15);
        _lb_left.adjustsFontSizeToFitWidth = YES;
        [self addSubview:_lb_left];
    }
    
    if (!_tf) {
        _tf = [[UITextField alloc] init];
        _tf.frame = CGRectMake(CGRectGetMaxX(_lb_left.frame), 0, self.frame.size.width-2*mergin_left-70, self.frame.size.height);
        _tf.placeholder = @"请输入";
        _tf.textAlignment = NSTextAlignmentLeft;
        _tf.textColor = UIColorFromRGB(0x333333);
        _tf.font = LSYUIFont(15);
        _tf.delegate = self;
        _tf.returnKeyType = UIReturnKeyDone;
        [self addSubview:_tf];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [_tf resignFirstResponder];
    return YES;
}


@end
