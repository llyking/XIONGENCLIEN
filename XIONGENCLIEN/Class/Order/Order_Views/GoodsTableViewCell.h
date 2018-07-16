//
//  GoodsTableViewCell.h
//  XIONGEN
//
//  Created by Ios on 2018/1/25.
//  Copyright © 2018年 Ios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsModel.h"

@interface GoodsTableViewCell : UITableViewCell

@property (nonatomic,assign) NSInteger Tag;
@property (nonatomic,strong) NSIndexPath *indxePath;
@property (nonatomic,strong) GoodsModel *goods;

/**
 加
 */
@property (nonatomic, copy) void (^AddBlock)(UILabel *countLabel);

/**
 减
 */
@property (nonatomic, copy) void (^CutBlock)(UILabel *countLabel);

@end
