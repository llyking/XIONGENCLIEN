//
//  PendingTableViewCell.m
//  XIONGEN
//
//  Created by Ios on 2018/1/22.
//  Copyright © 2018年 Ios. All rights reserved.
//

#import "PendingTableViewCell.h"

@interface PendingTableViewCell ()

@end

@implementation PendingTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
    }
    return self;
}

-(void)initUI {
    
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 1)];
    line.backgroundColor = LineColor;
    [self.contentView addSubview:line];
    
    if (!_title) {
        _title = [[UILabel alloc] initWithFrame:CGRectZero];
        [_title setFont:LSYUIFont(15)];
        [_title setTextColor:UIColorFromRGB(0x333333)];
        [_title setTextAlignment:NSTextAlignmentLeft];
        [_title setText:@"申请单"];
        [self.contentView addSubview:_title];
    }
    
    if (!_name) {
        _name = [[UILabel alloc] initWithFrame:CGRectZero];
        [_name setFont:LSYUIFont(13)];
        [_name setTextColor:UIColorFromRGB(0x666666)];
        [_name setTextAlignment:NSTextAlignmentLeft];
        [_name setText:@"发起人:"];
        [self.contentView addSubview:_name];
    }
    
    if (!_time) {
        _time = [[UILabel alloc] initWithFrame:CGRectZero];
        [_time setFont:LSYUIFont(13)];
        [_time setTextColor:UIColorFromRGB(0x666666)];
        [_time setTextAlignment:NSTextAlignmentLeft];
        [_time setText:@"发起时间:"];
        [self.contentView addSubview:_time];
    }
    
    if (!_opinion) {
        _opinion = [[UILabel alloc] initWithFrame:CGRectZero];
        [_opinion setFont:LSYUIFont(13)];
        [_opinion setTextColor:UIColorFromRGB(0x666666)];
        [_opinion setTextAlignment:NSTextAlignmentLeft];
        [_opinion setText:@"上级意见:"];
        [self.contentView addSubview:_opinion];
    }
    
}


-(void)layoutSubviews {
    _title.frame = CGRectMake(mergin_left, 10, self.frame.size.width-2*mergin_left, 20);
    _name.frame = CGRectMake(mergin_left, CGRectGetMaxY(_title.frame)+5, self.frame.size.width-2*mergin_left-10, 20);
    _time.frame = CGRectMake(mergin_left, CGRectGetMaxY(_name.frame)+5, self.frame.size.width-2*mergin_left, 20);
    _opinion.frame = CGRectMake(mergin_left, CGRectGetMaxY(_time.frame)+5, self.frame.size.width-2*mergin_left, 20);
}




- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
