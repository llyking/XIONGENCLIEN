//
//  LeftImageTextField.m
//  XIONGEN
//
//  Created by Ios on 2018/3/12.
//  Copyright © 2018年 Ios. All rights reserved.
//

#import "LeftImageTextField.h"

@implementation LeftImageTextField

-(instancetype)initWithFrame:(CGRect)frame Placehold:(NSString *)placehold andLeftImageName:(NSString *)name {
    
    self = [super initWithFrame:frame];
    
    self.backgroundColor = WhiteColor;
    self.textAlignment = NSTextAlignmentLeft;
    self.placeholder = placehold;
    self.searchIcon = [[UIImageView alloc] init];
    self.searchIcon.image = [UIImage imageWithContentsOfFile:ImagePath(name)];
    // contentMode：default is UIViewContentModeScaleToFill，要设置为UIViewContentModeCenter：使图片居中，防止图片填充整个imageView
//    self.searchIcon.contentMode = UIViewContentModeCenter;
    self.leftView = self.searchIcon;
    self.leftViewMode = UITextFieldViewModeAlways;
    
    return self;
}


-(CGRect)leftViewRectForBounds:(CGRect)bounds {
    CGRect rect = [super leftViewRectForBounds:bounds];
    rect.origin.x +=10;
    rect.origin.y =5;
    return rect;
}

-(CGRect)textRectForBounds:(CGRect)bounds {
    CGRect rect = [super textRectForBounds:bounds];
    rect.origin.x = 40;
    return rect;
}

-(CGRect)editingRectForBounds:(CGRect)bounds {
    CGRect rect = [super editingRectForBounds:bounds];
    rect.origin.x = 40;
    return rect;
}

@end
