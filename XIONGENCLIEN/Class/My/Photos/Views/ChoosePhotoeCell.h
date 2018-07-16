//
//  ChoosePhotoeCell.h
//  TianCi
//
//  Created by Ios on 2018/1/5.
//  Copyright © 2018年 Ios. All rights reserved.
//

#define imgNormal @"selected_normal@2x"
#define imgSelect @"selected_selected@2x"

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>
#import "LLYPhotoAsset.h"

@protocol ChoosePhotoeCellDelegate <NSObject>

@optional

- (void)pushIndex:(NSInteger)index;
- (void)pushCheckBtnIndex:(NSInteger)index StatusString:(NSString *)statusStr;

@end

@interface ChoosePhotoeCell : UICollectionViewCell

//相册小图
@property (nonatomic, retain) UIImageView           *imageView;
//标识相册选中状态的按钮
@property (nonatomic, retain) UIButton              *checkBtn;
@property (nonatomic, assign) id<ChoosePhotoeCellDelegate> delegate;

- (void)makeImageCell:(PHAsset*)asset takePhotos:(NSString *)photoStr;
//判断图片是否被选择
- (void)checkBtnIsSelected:(NSString *)selected;

@end
