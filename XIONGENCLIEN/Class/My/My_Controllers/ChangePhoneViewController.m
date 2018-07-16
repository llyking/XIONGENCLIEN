//
//  ChangePhoneViewController.m
//  XIONGEN
//
//  Created by Ios on 2018/1/23.
//  Copyright © 2018年 Ios. All rights reserved.
//

#import "ChangePhoneViewController.h"

@interface ChangePhoneViewController ()

@property (nonatomic,strong) UITextField *phoneTF;

@end

@implementation ChangePhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.Namelab.text = @"手机号修改";
    [self createUIView];
}

-(void)createUIView {
    _phoneTF = [[UITextField alloc] initWithFrame:CGRectMake(mergin_left, SafeAreaTopHeight+20, kScreenWidth-2*mergin_left, 40)];
    _phoneTF.backgroundColor = WhiteColor;
    _phoneTF.textColor = UIColorFromRGB(0x333333);
    _phoneTF.font = LSYUIFont(15);
    _phoneTF.textAlignment = NSTextAlignmentLeft;
    _phoneTF.placeholder = @"请输入新号码";
    _phoneTF.layer.cornerRadius = 4;
    _phoneTF.layer.masksToBounds = YES;
    _phoneTF.layer.borderColor = LineColor.CGColor;
    _phoneTF.layer.borderWidth = 1.0f;
    UIView *leftV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 40)];
    _phoneTF.leftView = leftV;
    _phoneTF.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:_phoneTF];
}

-(void)backButtonBar {
    if (self.changePhoneBlock) {
        self.changePhoneBlock(_phoneTF.text);
    }
    [self.navigationController popViewControllerAnimated:YES];
}




@end
