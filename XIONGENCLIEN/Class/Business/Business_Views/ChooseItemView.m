//
//  ChooseItemView.m
//  XIONGEN
//
//  Created by Ios on 2018/2/26.
//  Copyright © 2018年 Ios. All rights reserved.
//

#import "ChooseItemView.h"

@implementation ChooseItemView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = WhiteColor;
        [self createView];
    }
    return self;
}

-(void)createView {
    
    _btn = [UIButton buttonWithType:UIButtonTypeCustom];
    _btn.frame = CGRectMake(mergin_left, 10, 200, 20);
    [_btn setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateNormal];
    _btn.titleLabel.font = LSYUIFont(15);
    [_btn setImage:[UIImage imageNamed:@"choose_nor@2x"] forState:UIControlStateNormal];
    [self addSubview:_btn];
    
    _btn.selected = NO;
    _btn.imageEdgeInsets = UIEdgeInsetsMake(0, -90, 0, 0);
    _btn.titleEdgeInsets = UIEdgeInsetsMake(0, -80, 0, 0);
    
    _textBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _textBtn.frame = CGRectMake(kScreenWidth-100, 10, 80, 20);
    [_textBtn setTitleColor:ThemeColor forState:UIControlStateNormal];
    _textBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    _textBtn.titleLabel.font = LSYUIFont(15);
    [self addSubview:_textBtn];
    
}

@end
