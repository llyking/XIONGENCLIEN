//
//  AlterListView.h
//  XIONGEN
//
//  Created by Ios on 2018/1/31.
//  Copyright © 2018年 Ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlterListView : UIView

@property (nonatomic,copy) void (^backWithString)(NSString *text);
@property (nonatomic,copy) void (^backImage)(UIImage *image);

+(instancetype)shareAlterView;
-(void)initAlterViewWithTitleString:(NSString *)title andDataArray:(NSArray *)dataArray andSelectType:(BOOL)isSingle;
-(void)initAlterPhotoViewWithController:(UIViewController *)controller;

@end
