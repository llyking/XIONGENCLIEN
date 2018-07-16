//
//  PublicViewController.h
//  TianCi
//
//  Created by Ios on 17/3/14.
//  Copyright © 2017年 Ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PublicViewController : UIViewController

@property(nonatomic,retain)UIView *topView;

@property(nonatomic,retain)UILabel *Namelab;

@property(nonatomic,retain)UIScrollView *topScrollerView;

/**
 *  创建右边按钮
 *
 *  @param images 根据数组个数创建btn个数
 *  @param handle 按钮点击事件 右边起tag == 0 以此类推
 */
- (void)createRightBtnWithImageArray:(NSArray *)images handle:(void(^)(NSInteger tag)) handle;


/**
 *  同意push登录方法
 */
- (void)superPushLoginView;


/**
 *  修改返回按钮
 */
-(void)backButtonBar;

@end
