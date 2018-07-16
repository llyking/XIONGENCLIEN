//
//  BroughtButton.m
//  ConsUnion
//
//  Created by MAC2 on 16/12/14.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "BroughtButton.h"

@implementation BroughtButton

-(instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = WhiteColor;
        self.left_imgV = [[UIImageView alloc] initWithFrame:CGRectMake(15, (frame.size.height - 17)/2, 17, 17)];
        self.left_imgV.contentMode = UIViewContentModeScaleToFill;
        [self addSubview:self.left_imgV];
        
        _message_Lab = [[UILabel alloc]init];
        _message_Lab.backgroundColor = [UIColor redColor];
        _message_Lab.layer.cornerRadius = 6;
        _message_Lab.layer.masksToBounds = YES;
        _message_Lab.hidden = YES;
        _message_Lab.textColor = WhiteColor;
        _message_Lab.textAlignment = NSTextAlignmentCenter;
        _message_Lab.font = [UIFont systemFontOfSize:10];
        [self addSubview:_message_Lab];
        
        self.left_lab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.left_imgV.frame)+10, 0, frame.size.width - 30, frame.size.height)];
        self.left_lab.font = [UIFont systemFontOfSize:15];
        self.left_lab.textColor = UIColorFromRGB(0x333333);
        [self addSubview:self.left_lab];
        
        self.right_imgV = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width - 23, (frame.size.height - 14)/2, 8, 14)];
        self.right_imgV.image = [UIImage imageNamed:@"my_icon_nexts@2x"];
        [self addSubview:self.right_imgV];
        
        _message_Lab.frame = CGRectMake(CGRectGetMinX(self.right_imgV.frame)-15, CGRectGetMinY(self.right_imgV.frame), 12, 12);
        
        self.right_lab = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, frame.size.width - 45, frame.size.height)];
        self.right_lab.font = [UIFont systemFontOfSize:15];
        self.right_lab.textColor = UIColorFromRGB(0x999999);
        self.right_lab.textAlignment = NSTextAlignmentRight;
        [self addSubview:self.right_lab];
        
        self.top_line = [[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.height - 1, frame.size.width, 1)];
        self.top_line.backgroundColor = LineColor;
        [self addSubview:self.top_line];
        
    }
    
    return self;
    
}





@end
