//
//  XELoginViewController.m
//  XIONGEN
//
//  Created by Ios on 2018/1/20.
//  Copyright © 2018年 Ios. All rights reserved.
//

#import "XELoginViewController.h"
#import "XE_TabBarController.h"
#import "RegistViewController.h"
#import "ForgetPassViewController.h"

@interface XELoginViewController ()

@property (nonatomic,strong) UIImageView *img_logo;
@property (nonatomic,strong) LeftImageTextField *tf_number;
@property (nonatomic,strong) LeftImageTextField *tf_passw;

@property (nonatomic,strong) UIWindow *Window;//加载底图控制器
@property (nonatomic,strong) UIControl *controlWeekday;//设置输入框
@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,strong) UITextField *textfild;

@end

@implementation XELoginViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.navigationBar.hidden = YES;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = WhiteColor;
    if (BaseURL==nil) {
        [self changeServer];
    }
    [self setUIView];
}

-(void)setUIView {
    
    if (!_img_logo) {
        _img_logo = [[UIImageView alloc] init];
        _img_logo.frame = CGRectMake(70, SafeAreaTopHeight+50, kScreenWidth-140, 180*(kScreenWidth-140)/320);
        _img_logo.backgroundColor = [UIColor redColor];
        _img_logo.image = [UIImage imageWithContentsOfFile:ImagePath(@"logo@2x")];
        [self.view addSubview:_img_logo];
    }
    
    if (!_tf_number) {
        _tf_number = [[LeftImageTextField alloc] initWithFrame:CGRectMake(70, CGRectGetMaxY(_img_logo.frame)+50, kScreenWidth-140, 35) Placehold:@"请输入账号" andLeftImageName:@"accout@2x"];
        _tf_number.layer.borderColor = LineColor.CGColor;
        _tf_number.layer.borderWidth = 1.0f;
        _tf_number.textColor = UIColorFromRGB(0x333333);
        _tf_number.font = LSYUIFont(15);
        _tf_number.searchIcon.frame = CGRectMake(0, 0, 25, 25);
        [self.view addSubview:_tf_number];
    }
    
    if (!_tf_passw) {
        _tf_passw = [[LeftImageTextField alloc] initWithFrame:CGRectMake(70, CGRectGetMaxY(_tf_number.frame)+20, kScreenWidth-140, 35) Placehold:@"请输入密码" andLeftImageName:@"psw@2x"];
        _tf_passw.layer.borderColor = LineColor.CGColor;
        _tf_passw.layer.borderWidth = 1.0f;
        _tf_passw.textColor = UIColorFromRGB(0x333333);
        _tf_passw.font = LSYUIFont(15);
        _tf_passw.searchIcon.frame = CGRectMake(0, 0, 25, 25);
        _tf_passw.secureTextEntry = YES;
        [self.view addSubview:_tf_passw];
    }
    
    
    UIButton *forget = [UIButton buttonWithType:UIButtonTypeCustom];
    forget.frame = CGRectMake(CGRectGetMaxX(_tf_number.frame)-100, CGRectGetMaxY(_tf_passw.frame)+30, 100, 30);
    forget.tag = 200;
    [forget setTitle:@"忘记密码" forState:UIControlStateNormal];
    forget.titleLabel.font = LSYUIFont(15);
    forget.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [forget setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateNormal];
    [self.view addSubview:forget];
    
    UIButton *login = [UIButton buttonWithType:UIButtonTypeCustom];
    login.frame = CGRectMake((kScreenWidth-300)/2, CGRectGetMaxY(forget.frame)+30, 300, 40);
    login.tag = 300;
    login.backgroundColor = ThemeColor;
    login.layer.cornerRadius = 4;
    login.layer.masksToBounds = YES;
    [login setTitle:@"登录" forState:UIControlStateNormal];
    login.titleLabel.font = LSYUIFont(17);
    login.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [login setTitleColor:WhiteColor forState:UIControlStateNormal];
    [self.view addSubview:login];
    
    
    [forget addTarget:self action:@selector(btnsAction:) forControlEvents:UIControlEventTouchUpInside];
    [login addTarget:self action:@selector(btnsAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self setViewWithData];
}

-(void)setViewWithData {
    UserInfoModel *model = [UserInfoModel mj_objectWithKeyValues:UserInfoDict];
    if (model.account) {
        _tf_number.text = model.account;
    }
    if (Passw) {
        _tf_passw.text = Passw;
    }
    
}

//点击事件
-(void)btnsAction:(UIButton *)btn {
    switch (btn.tag) {
        case 100:
        {
            RegistViewController *registV = [[RegistViewController alloc] init];
            [self.navigationController pushViewController:registV animated:YES];
        }
            break;
        case 200:
        {
            ForgetPassViewController *forgetpassV = [[ForgetPassViewController alloc] init];
            [forgetpassV setLoadBlock:^{
                [self setViewWithData];
            }];
            [self.navigationController pushViewController:forgetpassV animated:YES];
        }
            break;
        case 300:
        {
            [self login];
        }
            break;
        default:
            break;
    }
}

-(void)login {
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:_tf_number.text,@"account",_tf_passw.text,@"password", nil];
    [HttpRoadData postUpdateInfoInViewNo:self.view withVersionCode:[NSString stringWithFormat:@"%@%@",BaseURL,@"back/api/appLogin.do"] NSMutableDictionary:dict successBlock:^(NSURLSessionDataTask *task, id responseObject) {
        
        [SVProgressHUD dismiss];
        NSDictionary *parm = responseObject;
        if ([[NSString stringWithFormat:@"%@",parm[@"success"]] isEqualToString:@"1"] && [[NSString stringWithFormat:@"%@",parm[@"errcode"]] isEqualToString:@"0"]) {
            
            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
            [user removeObjectForKey:@"userinfo"];
            [user removeObjectForKey:@"passw"];
            [user removeObjectForKey:@"userId"];
            [user removeObjectForKey:@"fid"];
            
            [user setObject:parm[@"data"] forKey:@"userinfo"];
            [user setObject:_tf_passw.text forKey:@"passw"];
            [user setObject:parm[@"data"][@"userId"] forKey:@"userId"];
            [user setObject:parm[@"data"][@"fid"] forKey:@"fid"];
            
            NSLog(@"%@",[user objectForKey:@"userinfo"]);
            [self gotoHome];
            
        } else {
            [SVProgressHUD showErrorWithStatus:parm[@"message"]];
        }
        
    } failureBlock:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error:%@",error);
        [SVProgressHUD dismiss];
    }];
}

//首页
- (void)gotoHome {
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];  // 获得根窗口
    XE_TabBarController *tabar = [[XE_TabBarController alloc] init];//将登录控制器设置为window的根控制器
    tabar.selectedIndex = 0;
    window.rootViewController = tabar;
    
    CATransition *myTransition=[CATransition animation];//创建CATransition
    myTransition.duration=0.35;//持续时长0.35秒
    myTransition.timingFunction=UIViewAnimationCurveEaseInOut;//计时函数，从头到尾的流畅度
    myTransition.type = kCATransitionFade;//子类型
    [window.layer addAnimation:myTransition forKey:nil];
}



#pragma mark - 登录前输入端口号
-(void)changeServer {
    
    _Window = [[UIApplication sharedApplication] windows].firstObject;
    
    _controlWeekday = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _controlWeekday.backgroundColor = UIColorFromRGBWithAlpha(0x000000,0.5);
    _controlWeekday.userInteractionEnabled = YES;
    [_Window addSubview:_controlWeekday];
    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
//    [_controlWeekday addGestureRecognizer:tap];
    
    UIView *bView = [[UIView alloc] initWithFrame:CGRectZero];
    bView.frame = CGRectMake((kScreenWidth-(kScreenHeight-SafeAreaTopHeight-SafeAreaBottomHeight)/2)/2, kScreenHeight, (kScreenHeight-SafeAreaTopHeight-SafeAreaBottomHeight)/2, 150);
    bView.layer.cornerRadius = 4;
    bView.layer.masksToBounds = YES;
    bView.userInteractionEnabled = YES;
    bView.backgroundColor = WhiteColor;
    self.bgView = bView;
    [_controlWeekday addSubview:self.bgView];
    
    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.frame = CGRectMake(mergin_left, 10, self.bgView.frame.size.width-2*mergin_left, 30);
    titleLab.textColor = UIColorFromRGB(0x333333);
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.font = LSYUIFont(15);
    titleLab.text = @"请输入IP地址和端口号，‘.’和‘:’必须用英文符号";
    [titleLab sizeToFit];
    [bView addSubview:titleLab];
    
    UITextField *textFild = [[UITextField alloc] init];
    textFild.frame = CGRectMake(mergin_left, CGRectGetMaxY(titleLab.frame)+15, self.bgView.frame.size.width-2*mergin_left, 40);
    textFild.layer.cornerRadius = 4;
    textFild.layer.masksToBounds = YES;
    textFild.layer.borderColor = LineColor.CGColor;
    textFild.layer.borderWidth = 1.0f;
    textFild.placeholder = @"请输入格式如：192.168.5.6:80";
    textFild.font = LSYUIFont(15);
    textFild.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 6, 0)];
    //设置显示模式为永远显示(默认不显示)
    textFild.leftViewMode = UITextFieldViewModeAlways;
    self.textfild = textFild;
    [bView addSubview:self.textfild];
    
    UIButton *sure = [UIButton buttonWithType:UIButtonTypeCustom];
    sure.frame = CGRectMake(0, bView.frame.size.height-40, self.bgView.frame.size.width, 40);
    [sure setTitle:@"确定" forState:UIControlStateNormal];
    [sure setTitleColor:WhiteColor forState:UIControlStateNormal];
    sure.titleLabel.font = LSYUIFont(15);
    sure.backgroundColor = ThemeColor;
    [sure addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.bgView addSubview:sure];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.bgView.frame = CGRectMake((kScreenWidth-(kScreenHeight-SafeAreaTopHeight-SafeAreaBottomHeight)/2)/2, kScreenHeight/2-80, (kScreenHeight-SafeAreaTopHeight-SafeAreaBottomHeight)/2, 150);
    } completion:^(BOOL finished) {
        
    }];
}


-(void)hide {
    
    if (self.textfild.text.length) {
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"http://%@/auto/",self.textfild.text] forKey:@"server"];
    }
    
    [UIView animateWithDuration:0.5 animations:^{
        _controlWeekday.backgroundColor = [UIColor clearColor];
        self.bgView.frame = CGRectMake((kScreenWidth-(kScreenHeight-SafeAreaTopHeight-SafeAreaBottomHeight)/2)/2, kScreenHeight, (kScreenHeight-SafeAreaTopHeight-SafeAreaBottomHeight)/2, 150);
    } completion:^(BOOL finished) {
        [_controlWeekday removeFromSuperview];
    }];
}

-(void)buttonAction:(UIButton *)sender {
    
    if (self.textfild.text.length) {
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"http://%@/auto/",self.textfild.text] forKey:@"server"];
    }
    [self hide];
}

@end
