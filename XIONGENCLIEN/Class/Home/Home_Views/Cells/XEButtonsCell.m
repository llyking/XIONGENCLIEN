//
//  XEButtonsCell.m
//  XIONGEN
//
//  Created by Ios on 2018/1/18.
//  Copyright © 2018年 Ios. All rights reserved.
//

#import "XEButtonsCell.h"

@implementation XEButtonsCell

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
//        _lb_text = [[UILabel alloc] init];
//        _lb_text.textColor = UIColorFromRGB(333333);
//        _lb_text.textAlignment = NSTextAlignmentCenter;
//        _lb_text.layer.borderColor = LineColor.CGColor;
//        _lb_text.layer.borderWidth = 0.5f;
//        _lb_text.font = LSYUIFont(15);
//        [self addSubview:_lb_text];
        
        
        self.homeButn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.homeButn.layer.borderColor = LineColor.CGColor;
        self.homeButn.layer.borderWidth = 0.5f;
        self.homeButn.titleLabel.font = LSYUIFont(15);
//        self.homeButn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        self.homeButn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [self.homeButn setTitleColor:UIColorFromRGB(333333) forState:UIControlStateNormal];
        [self.homeButn setImage:[UIImage imageWithContentsOfFile:ImagePath(@"home_friends@2x")] forState:UIControlStateNormal];
//        self.homeButn.imageEdgeInsets = UIEdgeInsetsMake(-30, 0, 0, -30);
//        self.homeButn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, -50, 30);
        
        [self addSubview:self.homeButn];
        
    }
    return self;
}

-(void)layoutSubviews {
    self.homeButn.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    //设置文字偏移：向下偏移图片高度＋向左偏移图片宽度 （偏移量是根据［图片］大小来的，这点是关键）
    self.homeButn.titleEdgeInsets = UIEdgeInsetsMake(self.homeButn.imageView.frame.size.height+20, -self.homeButn.imageView.frame.size.width, 0, 0);
    //设置图片偏移：向上偏移文字高度＋向右偏移文字宽度 （偏移量是根据［文字］大小来的，这点是关键）
    self.homeButn.imageEdgeInsets = UIEdgeInsetsMake(-self.homeButn.titleLabel.bounds.size.height, 0, 0, -self.homeButn.titleLabel.bounds.size.width);
}

@end
