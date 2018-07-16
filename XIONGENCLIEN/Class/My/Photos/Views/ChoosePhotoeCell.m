//
//  ChoosePhotoeCell.m
//  TianCi
//
//  Created by Ios on 2018/1/5.
//  Copyright © 2018年 Ios. All rights reserved.
//

#import "ChoosePhotoeCell.h"

@implementation ChoosePhotoeCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createImageview];
        [self crateCheckBtn];
    }
    return self;
}
//创建ImageView
- (void)createImageview {
    _imageView = [[UIImageView alloc] init];
    _imageView.userInteractionEnabled = YES;
    [_imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage)]];
    self.imageView.frame = self.bounds;
    [self addSubview:self.imageView];
}

- (void)tapImage {
    [self.delegate pushIndex:self.imageView.tag];
}

//创建标识图片是否选中的按钮
- (void)crateCheckBtn {
    _checkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _checkBtn.frame = CGRectMake(self.bounds.size.width-20, 0, 20, 20);
    [self.imageView addSubview:self.checkBtn];
    [_checkBtn setImage:[UIImage imageNamed:imgNormal] forState:UIControlStateNormal];
    [_checkBtn addTarget:self action:@selector(checkBtnSelect:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)checkBtnSelect:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    if (sender.selected) {
        [_checkBtn setImage:[UIImage imageNamed:imgSelect] forState:UIControlStateNormal];
    }else {
        [_checkBtn setImage:[UIImage imageNamed:imgNormal] forState:UIControlStateNormal];
    }
    [self.delegate pushCheckBtnIndex:sender.tag-100 StatusString:[NSString stringWithFormat:@"%d",sender.selected]];
}

- (void)checkBtnIsSelected:(NSString *)selected {
    if ([selected isEqualToString:@"1"]) {
        _checkBtn.selected = YES;
        [_checkBtn setImage:[UIImage imageNamed:imgSelect] forState:UIControlStateNormal];
    }else {
        _checkBtn.selected = NO;
        [_checkBtn setImage:[UIImage imageNamed:imgNormal] forState:UIControlStateNormal];
    }
}

//设置cell里的图片
- (void)makeImageCell:(PHAsset*)asset takePhotos:(NSString *)photoStr {
    if (!photoStr) {
        LLYPhotoAsset *wkwasset = [[LLYPhotoAsset alloc] init];
        UIImage *image =  [wkwasset smallImageSize:self.bounds.size asset:asset];
        [self.imageView setImage:image];
        _imageView.hidden    = NO;
        _checkBtn.hidden     = NO;
    }else {
        _imageView.hidden    = YES;
        _checkBtn.hidden     = YES;
    }
}


@end
