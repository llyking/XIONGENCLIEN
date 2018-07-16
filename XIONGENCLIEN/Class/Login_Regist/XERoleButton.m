//
//  XERoleButton.m
//  XIONGEN
//
//  Created by Ios on 2018/1/20.
//  Copyright © 2018年 Ios. All rights reserved.
//

#import "XERoleButton.h"

@implementation XERoleButton

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        if (!_img_select) {
            _img_select = [[UIImageView alloc] init];
            [self addSubview:_img_select];
        }
        
        if (!_lb_name) {
            _lb_name = [[UILabel alloc] init];
            _lb_name.textColor = UIColorFromRGB(0x333333);
            _lb_name.textAlignment = NSTextAlignmentLeft;
            _lb_name.font = LSYUIFont(15);
            [self addSubview:_lb_name];
        }
    }
    return self;
}

-(void)layoutSubviews {
    _img_select.frame = CGRectMake(0, 0, 25, 25);
    _lb_name.frame = CGRectMake(CGRectGetMaxX(_img_select.frame)+10, 0, 100, 25);
}

@end
