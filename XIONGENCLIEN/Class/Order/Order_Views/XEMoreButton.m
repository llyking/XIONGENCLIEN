//
//  XEMoreButton.m
//  XIONGEN
//
//  Created by Ios on 2018/1/19.
//  Copyright © 2018年 Ios. All rights reserved.
//

#import "XEMoreButton.h"

#define top 5

@implementation XEMoreButton

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = WhiteColor;
        [self initUIView];
    }
    return self;
}

-(void)initUIView {
    _img_left = [[UIImageView alloc] init];
    [self addSubview:_img_left];
    
    _img_right = [[UIImageView alloc] init];
     NSString *morePath = [[NSBundle mainBundle] pathForResource:@"home_icon_more@2x" ofType:@"png"];
    _img_right.image = [UIImage imageWithContentsOfFile:morePath];
    [self addSubview:_img_right];
    
    _lb_title = [[UILabel alloc] init];
    _lb_title.textColor = UIColorFromRGB(0x333333);
    _lb_title.textAlignment = NSTextAlignmentLeft;
    _lb_title.font = LSYUIFont(15);
    [self addSubview:_lb_title];
    
    _lb_more = [[UILabel alloc] init];
    _lb_more.textColor = UIColorFromRGB(0x666666);
    _lb_more.textAlignment = NSTextAlignmentRight;
    _lb_more.font = LSYUIFont(13);
    [self addSubview:_lb_more];
    
    _line = [[UILabel alloc] init];
    _line.backgroundColor = LineColor;
    [self addSubview:_line];
}

-(void)layoutSubviews {
//    _img_left.frame = CGRectMake(mergin_left, top, 30, self.frame.size.height-2*top);
    _img_right.frame = CGRectMake(self.frame.size.width-mergin_right-8, (self.frame.size.height-12)/2, 8, 12);
    _lb_title.frame = CGRectMake(CGRectGetMaxX(_img_left.frame)+10, top, 150, self.frame.size.height-2*top);
    _lb_more.frame = CGRectMake(CGRectGetMinX(_img_right.frame)-160, top, 150, self.frame.size.height-2*top);
    
    _line.frame = CGRectMake(0, self.frame.size.height-1, self.frame.size.width, 1);
}



@end
