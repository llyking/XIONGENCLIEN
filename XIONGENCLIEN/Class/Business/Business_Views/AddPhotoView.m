//
//  AddPhotoView.m
//  XIONGEN
//
//  Created by Ios on 2018/2/26.
//  Copyright © 2018年 Ios. All rights reserved.
//

#import "AddPhotoView.h"

@implementation AddPhotoView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = WhiteColor;
        [self createView];
    }
    return self;
}


-(void)createView {
    
    if (!_lb) {
        _lb = [[UILabel alloc] init];
        _lb.frame = CGRectMake(mergin_left, 0, 300, self.frame.size.height);
        _lb.textAlignment = NSTextAlignmentLeft;
        _lb.textColor = UIColorFromRGB(0x333333);
        _lb.font = LSYUIFont(15);
        _lb.adjustsFontSizeToFitWidth = YES;
        [self addSubview:_lb];
    }
    
    if (!_img) {
        _img = [[UIImageView alloc] init];
        _img.userInteractionEnabled = YES;
        _img.frame = CGRectMake(kScreenWidth-50, 5, 30, 30);
        _img.image = [UIImage imageNamed:@"add@2x"];
        [self addSubview:_img];
    }
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addPhoto)];
    [_img addGestureRecognizer:tap];
}

-(void)addPhoto {
    if (self.addPhotoBlock) {
        self.addPhotoBlock();
    }
}

@end
