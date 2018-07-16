//
//  ForgetPassViewController.m
//  XIONGEN
//
//  Created by Ios on 2018/1/20.
//  Copyright © 2018年 Ios. All rights reserved.
//

#import "ForgetPassViewController.h"
#import "XEInputBoxView.h"

@interface ForgetPassViewController ()

@property (nonatomic,strong) XEInputBoxView *number;
@property (nonatomic,strong) XEInputBoxView *name;
@property (nonatomic,strong) XEInputBoxView *newpass;
@property (nonatomic,strong) XEInputBoxView *confirmpass;

@end

@implementation ForgetPassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.Namelab.text = @"忘记密码";
    [self createUIView];
}

-(void)createUIView {
    
    if (!_number) {
        _number = [[XEInputBoxView alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight+50, kScreenWidth, 30)];
        _number.lb_name.text = @"手机号:";
        _number.tf_text.placeholder = @"请输入手机号";
        [self.view addSubview:_number];
    }
    
    if (!_name) {
        _name = [[XEInputBoxView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_number.frame)+30, kScreenWidth, 30)];
        _name.lb_name.text = @"用户名:";
        _name.tf_text.placeholder = @"请输入用户名";
        [self.view addSubview:_name];
    }
    
    if (!_newpass) {
        _newpass = [[XEInputBoxView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_name.frame)+30, kScreenWidth, 30)];
        _newpass.lb_name.text = @"新密码:";
        _newpass.tf_text.placeholder = @"请输入新密码";
        _newpass.tf_text.secureTextEntry = YES;
        [self.view addSubview:_newpass];
    }
    
    if (!_confirmpass) {
        _confirmpass = [[XEInputBoxView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_newpass.frame)+30, kScreenWidth, 30)];
        _confirmpass.lb_name.text = @"确认密码:";
        _confirmpass.tf_text.placeholder = @"请确认密码";
        _confirmpass.tf_text.secureTextEntry = YES;
        [self.view addSubview:_confirmpass];
    }
    
    UIButton *post = [UIButton buttonWithType:UIButtonTypeCustom];
    post.frame = CGRectMake((kScreenWidth-300)/2, CGRectGetMaxY(_confirmpass.frame)+80, 300, 40);
    post.backgroundColor = ThemeColor;
    post.layer.cornerRadius = 4;
    post.layer.masksToBounds = YES;
    [post setTitle:@"提交" forState:UIControlStateNormal];
    post.titleLabel.font = LSYUIFont(17);
    post.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [post setTitleColor:WhiteColor forState:UIControlStateNormal];
    [post addTarget:self action:@selector(post) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:post];
}

//提交
-(void)post {
    
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:_name.tf_text.text,@"account",_number.tf_text.text,@"phone",_newpass.tf_text.text,@"newPass",_confirmpass.tf_text.text,@"conPass", nil];
    [HttpRoadData postUpdateInfoInViewNo:self.view withVersionCode:[NSString stringWithFormat:@"%@%@",BaseURL,@"back/api/lossPass.do"] NSMutableDictionary:dict successBlock:^(NSURLSessionDataTask *task, id responseObject) {
        
        [SVProgressHUD dismiss];
        NSDictionary *parm = responseObject;
        if ([[NSString stringWithFormat:@"%@",parm[@"success"]] isEqualToString:@"1"] && [[NSString stringWithFormat:@"%@",parm[@"errcode"]] isEqualToString:@"0"]) {
            
            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
            [user removeObjectForKey:@"passw"];
            [SVProgressHUD showSuccessWithStatus:parm[@"message"]];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (self.loadBlock) {
                    self.loadBlock();
                }
                [self.navigationController popViewControllerAnimated:YES];
            });
            
        } else {
            [SVProgressHUD showErrorWithStatus:parm[@"message"]];
        }
        
    } failureBlock:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error:%@",error);
        [SVProgressHUD dismiss];
    }];
    
}



@end
