//
//  MessageTableViewCell.h
//  XIONGENCLIEN
//
//  Created by Ios on 2018/3/23.
//  Copyright © 2018年 Ios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TYAttributedLabel.h"

@interface MessageTableViewCell : UITableViewCell

@property (nonatomic,strong) UIView *bgV;
@property (nonatomic,strong) UILabel *dateLable;
@property (nonatomic,strong) TYAttributedLabel *label;

@end
