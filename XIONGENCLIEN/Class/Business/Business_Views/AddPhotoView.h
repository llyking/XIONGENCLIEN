//
//  AddPhotoView.h
//  XIONGEN
//
//  Created by Ios on 2018/2/26.
//  Copyright © 2018年 Ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddPhotoView : UIView

@property (nonatomic,strong) UILabel *lb;
@property (nonatomic,strong) UIImageView *img;

@property (nonatomic,copy) void (^addPhotoBlock)(void);

@end
