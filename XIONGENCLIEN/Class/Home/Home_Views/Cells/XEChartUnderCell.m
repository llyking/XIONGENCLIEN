//
//  XEChartUnderCell.m
//  XIONGEN
//
//  Created by Ios on 2018/1/17.
//  Copyright © 2018年 Ios. All rights reserved.
//

#import "XEChartUnderCell.h"

@implementation XEChartUnderCell

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _lb_text = [[UILabel alloc] init];
        _lb_text.textColor = UIColorFromRGB(333333);
        _lb_text.textAlignment = NSTextAlignmentLeft;
        _lb_text.font = LSYUIFont(15);
        [self addSubview:_lb_text];
    }
    return self;
}

-(void)layoutSubviews {
    _lb_text.frame = CGRectMake(mergin_left, 0, self.frame.size.width, self.frame.size.height);
}


@end
