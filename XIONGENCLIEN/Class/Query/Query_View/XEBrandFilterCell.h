//
//  XEBrandFilterCell.h
//  XIONGEN
//
//  Created by Ios on 2018/1/18.
//  Copyright © 2018年 Ios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XECategoryModel.h"

@interface XEBrandFilterCell : UICollectionViewCell

@property (nonatomic,strong) UIButton *btn_category;
@property (nonatomic,strong) XECategoryModel *model;

/**
 *  选择类别
 */
@property (nonatomic,copy) void(^ChooseCategoryItemCallBack)(void);

@end
