//
//  FollowOrderTableViewCell.h
//  XIONGEN
//
//  Created by Ios on 2018/1/23.
//  Copyright © 2018年 Ios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderStatusModel.h"

@interface FollowOrderTableViewCell : UITableViewCell

@property (nonatomic,strong) UIButton *btn_orderType;
@property (nonatomic,strong) OrderStatusModel *statuM;

@end
