//
//  XE_HomeHeadTitleView.m
//  XIONGEN
//
//  Created by Ios on 2018/1/17.
//  Copyright © 2018年 Ios. All rights reserved.
//

#import "XE_HomeHeadTitleView.h"

@implementation XE_HomeHeadTitleView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _lb_title = [[UILabel alloc] init];
        _lb_title.text = @"雄恩贸易";
        _lb_title.textColor = WhiteColor;
        _lb_title.textAlignment = NSTextAlignmentCenter;
        _lb_title.font = LSYUIFont(17);
        [self addSubview:_lb_title];
        
        _btn_scan = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btn_scan setBackgroundImage:HKFastImage(@"") forState:UIControlStateNormal];
        _btn_scan.tag = XEHomeTopScanBtnType;
        _btn_scan.adjustsImageWhenHighlighted = NO;
        [_btn_scan addTarget:self action:@selector(topBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_btn_scan];
        
        _btn_my = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btn_my setBackgroundImage:HKFastImage(@"") forState:UIControlStateNormal];
        _btn_my.tag = XEHomeTopMyBtnType;
        _btn_my.adjustsImageWhenHighlighted = NO;
        [_btn_my addTarget:self action:@selector(topBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_btn_my];
    }
    return self;
}

- (void)topBtnAction:(UIButton *)sender {
    XEBtnType btnType = sender.tag;
    if (self.xeHomeHeadViewBtnCallBack) {
        self.xeHomeHeadViewBtnCallBack(btnType);
    }
}

-(void)layoutSubviews {
    _lb_title.frame=CGRectMake(0, StatubarHeight, self.frame.size.width, NavigtionHeight);
    _btn_scan.frame=CGRectMake(mergin_left, StatubarHeight+(NavigtionHeight-30)/2, 30, 30);
    _btn_my.frame=CGRectMake(kScreenWidth-mergin_left-30, StatubarHeight+(NavigtionHeight-30)/2, 30, 30);
}


@end
