//
//  XEInputBoxView.m
//  XIONGEN
//
//  Created by Ios on 2018/1/20.
//  Copyright © 2018年 Ios. All rights reserved.
//

#import "XEInputBoxView.h"

@implementation XEInputBoxView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = WhiteColor;
        if (!_lb_name) {
            _lb_name = [[UILabel alloc] init];
            _lb_name.textColor = UIColorFromRGB(0x333333);
            _lb_name.textAlignment = NSTextAlignmentRight;
            _lb_name.font = LSYUIFont(15);
            [self addSubview:_lb_name];
        }
        
        if (!_tf_text) {
            _tf_text = [[UITextField alloc] init];
            _tf_text.backgroundColor = WhiteColor;
            _tf_text.textColor = UIColorFromRGB(0x333333);
            _tf_text.font = LSYUIFont(13);
            _tf_text.textAlignment = NSTextAlignmentLeft;
            _tf_text.layer.borderColor = LineColor.CGColor;
            _tf_text.layer.borderWidth = 1.0f;
            UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
            leftView.backgroundColor = [UIColor whiteColor];
            _tf_text.leftView = leftView;
            _tf_text.leftViewMode = UITextFieldViewModeAlways;
            [self addSubview:_tf_text];
        }
    }
    return self;
}


-(void)layoutSubviews {
    _lb_name.frame = CGRectMake(0, 0, 80, self.frame.size.height);
    _tf_text.frame = CGRectMake(CGRectGetMaxX(_lb_name.frame)+10, 0, self.frame.size.width-CGRectGetWidth(_lb_name.frame)-2*mergin_left-20, self.frame.size.height);
}


@end
