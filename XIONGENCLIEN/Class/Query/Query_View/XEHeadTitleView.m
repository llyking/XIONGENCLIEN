//
//  XEHeadTitleView.m
//  XIONGEN
//
//  Created by Ios on 2018/1/18.
//  Copyright © 2018年 Ios. All rights reserved.
//

#import "XEHeadTitleView.h"

@implementation XEHeadTitleView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = ThemeColor;
        
        _lb_title = [[UILabel alloc] init];
        _lb_title.textColor = WhiteColor;
        _lb_title.textAlignment = NSTextAlignmentCenter;
        _lb_title.font = LSYUIFont(17);
        [self addSubview:_lb_title];
        
        _btn_right = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btn_right setBackgroundImage:HKFastImage(@"") forState:UIControlStateNormal];
        [_btn_right addTarget:self action:@selector(topBtnAction) forControlEvents:UIControlEventTouchUpInside];
        _btn_right.titleLabel.font = LSYUIFont(13);
        _btn_right.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [_btn_right setTitleColor:WhiteColor forState:UIControlStateNormal];
        [self addSubview:_btn_right];
    }
    return self;
}


-(void)layoutSubviews {
    _lb_title.frame=CGRectMake(0, StatubarHeight, self.frame.size.width, NavigtionHeight);
    _btn_right.frame=CGRectMake(kScreenWidth-mergin_right-100, StatubarHeight, 100, NavigtionHeight);
}

-(void)topBtnAction {
    
}

@end
