//
//  XEBrandFilterCell.m
//  XIONGEN
//
//  Created by Ios on 2018/1/18.
//  Copyright © 2018年 Ios. All rights reserved.
//

#import "XEBrandFilterCell.h"

@implementation XEBrandFilterCell

-(instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        _btn_category = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn_category.selected = NO;
        _btn_category.layer.cornerRadius = 4;
        _btn_category.layer.masksToBounds = YES;
        _btn_category.layer.borderColor = LineColor.CGColor;
        _btn_category.layer.borderWidth = 1.0f;
        _btn_category.titleLabel.font = LSYUIFont(15);
        _btn_category.backgroundColor = UIColorFromRGB(0xf6f6f6);
        [_btn_category setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateNormal];
        _btn_category.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [_btn_category addTarget:self action:@selector(chooseAction) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_btn_category];
    }
    return self;
}

-(void)chooseAction {
    
    if (self.ChooseCategoryItemCallBack) {
        self.ChooseCategoryItemCallBack();
    }
}

-(void)setModel:(XECategoryModel *)model {
    _model = model;
    [_btn_category setTitle:_model.category forState:UIControlStateNormal];
    if (_model.isSelect) {
        _btn_category.backgroundColor = ThemeColor;
//        _btn_category.layer.borderColor = ThemeColor.CGColor;
        [_btn_category setTitleColor:WhiteColor forState:UIControlStateNormal];
    } else {
        _btn_category.backgroundColor = UIColorFromRGB(0xf6f6f6);
//        _btn_category.layer.borderColor = LineColor.CGColor;
        [_btn_category setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateNormal];
    }
}

-(void)layoutSubviews {
    _btn_category.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}

@end
