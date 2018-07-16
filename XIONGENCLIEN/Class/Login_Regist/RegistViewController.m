//
//  RegistViewController.m
//  XIONGEN
//
//  Created by Ios on 2018/1/20.
//  Copyright © 2018年 Ios. All rights reserved.
//

#import "RegistViewController.h"
#import "XEInputBoxView.h"
#import "XERoleButton.h"

@interface RegistViewController ()

@property (nonatomic,strong) XEInputBoxView *number;
@property (nonatomic,strong) XEInputBoxView *name;
@property (nonatomic,strong) XEInputBoxView *phone;
@property (nonatomic,strong) XEInputBoxView *passw;

@property (nonatomic,strong) XEInputBoxView *company;
@property (nonatomic,strong) XEInputBoxView *position;
@property (nonatomic,strong) XEInputBoxView *departmen;

@end

@implementation RegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.Namelab.text = @"注册";
    [self setUIView];
}

-(void)setUIView {
    
    if (!_number) {
        _number = [[XEInputBoxView alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight+30, kScreenWidth, 30)];
        _number.lb_name.text = @"用户名:";
        _number.tf_text.placeholder = @"请输入用户名";
        [self.view addSubview:_number];
    }
    
    if (!_passw) {
        _passw = [[XEInputBoxView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_number.frame)+30, kScreenWidth, 30)];
        _passw.lb_name.text = @"密码:";
        _passw.tf_text.placeholder = @"请输入密码";
        [self.view addSubview:_passw];
    }
    
    if (!_phone) {
        _phone = [[XEInputBoxView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_passw.frame)+30, kScreenWidth, 30)];
        _phone.lb_name.text = @"手机号:";
        _phone.tf_text.placeholder = @"请输入手机号";
        [self.view addSubview:_phone];
    }
    
    if (!_name) {
        _name = [[XEInputBoxView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_phone.frame)+30, kScreenWidth, 30)];
        _name.lb_name.text = @"姓名:";
        _name.tf_text.placeholder = @"请输入姓名";
        [self.view addSubview:_name];
    }
    
    if (!_company) {
        _company = [[XEInputBoxView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_name.frame)+30, kScreenWidth, 30)];
        _company.lb_name.text = @"公司:";
        _company.tf_text.placeholder = @"请输入公司";
        [self.view addSubview:_company];
    }
    
    if (!_departmen) {
        _departmen = [[XEInputBoxView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_company.frame)+30, kScreenWidth, 30)];
        _departmen.lb_name.text = @"部门:";
        _departmen.tf_text.placeholder = @"请输入部门";
        [self.view addSubview:_departmen];
    }
    
    if (!_position) {
        _position = [[XEInputBoxView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_departmen.frame)+30, kScreenWidth, 30)];
        _position.lb_name.text = @"职务:";
        _position.tf_text.placeholder = @"请输入职务";
        [self.view addSubview:_position];
    }
    
    
    UIButton *post = [UIButton buttonWithType:UIButtonTypeCustom];
    post.frame = CGRectMake((kScreenWidth-300)/2, CGRectGetMaxY(_passw.frame)+30, 300, 40);
    post.tag = 2;
    post.backgroundColor = ThemeColor;
    post.layer.cornerRadius = 4;
    post.layer.masksToBounds = YES;
    [post setTitle:@"注册" forState:UIControlStateNormal];
    post.titleLabel.font = LSYUIFont(17);
    post.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [post setTitleColor:WhiteColor forState:UIControlStateNormal];
    [post addTarget:self action:@selector(chooseRoleAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:post];
    
}

//点击事件
-(void)chooseRoleAction:(UIButton *)btn {
    switch (btn.tag) {
        case 2:
        {
            //注册
        }
            break;
        default:
            break;
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
