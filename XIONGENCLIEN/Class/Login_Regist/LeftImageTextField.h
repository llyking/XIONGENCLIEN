//
//  LeftImageTextField.h
//  XIONGEN
//
//  Created by Ios on 2018/3/12.
//  Copyright © 2018年 Ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftImageTextField : UITextField

@property (nonatomic,strong) UIImageView *searchIcon;

-(instancetype)initWithFrame:(CGRect)frame Placehold:(NSString *)placehold andLeftImageName:(NSString *)name;


@end
