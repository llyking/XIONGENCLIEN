//
//  Drop_downButton.m
//  XIONGEN
//
//  Created by Ios on 2018/1/19.
//  Copyright © 2018年 Ios. All rights reserved.
//

#import "Drop_downButton.h"

@implementation Drop_downButton

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColorFromRGBWithAlpha(0x000000, 0.3);
        _img_dropdown = [[UIImageView alloc] init];
        [self addSubview:_img_dropdown];
        
        _lb_title = [[UILabel alloc] init];
        _lb_title.textColor = UIColorFromRGB(0x333333);
        _lb_title.textAlignment = NSTextAlignmentLeft;
        _lb_title.font = LSYUIFont(15);
        [self addSubview:_lb_title];
        
        self.selected = NO;
        [self addTarget:self action:@selector(dropdown:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

-(void)layoutSubviews {
    _img_dropdown.frame = CGRectMake((self.frame.size.height-6)/2, self.frame.size.width-10, 10, 6);
    _lb_title.frame = CGRectMake(0, 0, self.frame.size.width-_img_dropdown.frame.size.width, self.frame.size.height);
}

-(void)dropdown:(UIButton *)btn {
    self.selected = !self.selected;
    if (self.selected) {
        _img_dropdown.image = [UIImage imageNamed:@"login_password_on@2x"];
    } else {
        _img_dropdown.image = [UIImage imageNamed:@"login_password_up@2x"];
    }
    if (self.DropDownChooseTitle) {
        self.DropDownChooseTitle(self.selected);
    }
}

@end
