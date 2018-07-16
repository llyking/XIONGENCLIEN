//
//  MessageTableViewCell.m
//  XIONGENCLIEN
//
//  Created by Ios on 2018/3/23.
//  Copyright © 2018年 Ios. All rights reserved.
//

#import "MessageTableViewCell.h"

@implementation MessageTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createLabel];
    }
    return self;
}

-(void)createLabel {
    
    self.bgV = [[UIView alloc] init];
    self.bgV.backgroundColor = WhiteColor;
    self.bgV.layer.cornerRadius = 4;
    self.bgV.layer.masksToBounds = YES;
    [self.contentView addSubview:self.bgV];
    
    self.dateLable = [[UILabel alloc] init];
    self.dateLable.textColor = UIColorFromRGB(0x999999);
    self.dateLable.textAlignment = NSTextAlignmentLeft;
    self.dateLable.font = LSYUIFont(13);
    self.dateLable.text = @"2018-03-23";
    [self.bgV addSubview:self.dateLable];
    
    self.label = [[TYAttributedLabel alloc] init];
    self.label.font = LSYUIFont(15);
    [self.bgV addSubview:self.label];
}

-(void)layoutSubviews {
    
    self.bgV.frame = CGRectMake(mergin_left, 10, kScreenWidth-2*mergin_left, self.label.textContainer.textHeight+35);
    [self setShodam];
    self.dateLable.frame = CGRectMake(5, 10, self.bgV.frame.size.width-10, 15);
    [self.label setFrameWithOrign:CGPointMake(5, CGRectGetMaxY(self.dateLable.frame)+5) Width:kScreenWidth-3*mergin_left];
}

-(void)setShodam {
    
    UIView *shadowView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth-20, self.bgV.frame.size.height)];
    [self.contentView addSubview:shadowView];

    shadowView.layer.shadowColor = [UIColor grayColor].CGColor;
    shadowView.layer.shadowOffset = CGSizeMake(1, 3);
    shadowView.layer.shadowOpacity = 0.6;
    shadowView.layer.shadowRadius = 4.0;
    shadowView.layer.cornerRadius = 4.0;
    shadowView.clipsToBounds = NO;
    [shadowView addSubview:self.bgV];
}


@end
