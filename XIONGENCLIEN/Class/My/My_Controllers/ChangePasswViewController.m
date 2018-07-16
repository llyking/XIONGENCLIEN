//
//  ChangePasswViewController.m
//  XIONGEN
//
//  Created by Ios on 2018/1/23.
//  Copyright © 2018年 Ios. All rights reserved.
//

#import "ChangePasswViewController.h"
#import "XELoginViewController.h"
#import "XEInputBoxView.h"

@interface ChangePasswViewController ()

@property (nonatomic,strong) XEInputBoxView *account;
@property (nonatomic,strong) XEInputBoxView *oldpass;
@property (nonatomic,strong) XEInputBoxView *nepass;
@property (nonatomic,strong) XEInputBoxView *checkpassw;

@end

@implementation ChangePasswViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.Namelab.text = @"修改密码";
    [self createUIView];
}

-(void)createUIView {
    
    if (!_account) {
        _account = [[XEInputBoxView alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight+50, kScreenWidth, 30)];
        _account.lb_name.text = @"账号:";
        _account.tf_text.placeholder = @"请输入账号";
        [self.view addSubview:_account];
    }
    
    if (!_oldpass) {
        _oldpass = [[XEInputBoxView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_account.frame)+30, kScreenWidth, 30)];
        _oldpass.lb_name.text = @"旧密码:";
        _oldpass.tf_text.placeholder = @"请输入旧密码";
        _oldpass.tf_text.secureTextEntry = YES;
        [self.view addSubview:_oldpass];
    }
    
    if (!_nepass) {
        _nepass = [[XEInputBoxView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_oldpass.frame)+30, kScreenWidth, 30)];
        _nepass.lb_name.text = @"新密码:";
        _nepass.tf_text.placeholder = @"请输入新密码";
        _nepass.tf_text.secureTextEntry = YES;
        [self.view addSubview:_nepass];
    }
    
    if (!_checkpassw) {
        _checkpassw = [[XEInputBoxView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_nepass.frame)+30, kScreenWidth, 30)];
        _checkpassw.lb_name.text = @"确认密码:";
        _checkpassw.tf_text.placeholder = @"请确认密码";
        _checkpassw.tf_text.secureTextEntry = YES;
        [self.view addSubview:_checkpassw];
    }
    
    UIButton *changePassw = [UIButton buttonWithType:UIButtonTypeCustom];
    changePassw.frame = CGRectMake((kScreenWidth-300)/2, CGRectGetMaxY(_checkpassw.frame)+80, 300, 40);
    changePassw.backgroundColor = ThemeColor;
    changePassw.layer.cornerRadius = 4;
    changePassw.layer.masksToBounds = YES;
    [changePassw setTitle:@"修改密码" forState:UIControlStateNormal];
    changePassw.titleLabel.font = LSYUIFont(17);
    changePassw.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [changePassw setTitleColor:WhiteColor forState:UIControlStateNormal];
    [changePassw addTarget:self action:@selector(changePassw) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:changePassw];
}

//修改密码
-(void)changePassw {
    
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:_account.tf_text.text,@"account",_oldpass.tf_text.text,@"oldpass",_nepass.tf_text.text,@"newpass",_checkpassw.tf_text.text,@"conpass", nil];
    [HttpRoadData postUpdateInfoInViewNo:self.view withVersionCode:[NSString stringWithFormat:@"%@%@",BaseURL,@"back/api/changePass.do"] NSMutableDictionary:dict successBlock:^(NSURLSessionDataTask *task, id responseObject) {
        
        [SVProgressHUD dismiss];
        NSDictionary *parm = responseObject;
        if ([[NSString stringWithFormat:@"%@",parm[@"success"]] isEqualToString:@"1"] && [[NSString stringWithFormat:@"%@",parm[@"errcode"]] isEqualToString:@"0"]) {
            
            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
            [user removeObjectForKey:@"passw"];
            [SVProgressHUD showSuccessWithStatus:parm[@"message"]];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                XELoginViewController *login = [[XELoginViewController alloc] init];
                [self.navigationController pushViewController:login animated:YES];
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
