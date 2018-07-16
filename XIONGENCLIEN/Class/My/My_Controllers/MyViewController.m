//
//  MyViewController.m
//  XIONGEN
//
//  Created by Ios on 2018/1/16.
//  Copyright © 2018年 Ios. All rights reserved.
//

#import "MyViewController.h"
#import "MyMessageViewController.h"
#import "ChangePasswViewController.h"
#import "XELoginViewController.h"

@interface MyViewController ()

@property (nonatomic,strong) UIImageView *photoImg;
@property (nonatomic,strong) UILabel *nameLab;
@property (nonatomic,strong) UILabel *departmenLab;
@property (nonatomic,strong) UIImageView *nextImg;
@property (nonatomic,strong) BroughtButton *btnChangePassw;
@property (nonatomic,strong) UserInfoModel *model;

@end

@implementation MyViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.navigationBar.hidden = YES;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColorFromRGB(0xf6f6f6);
    
    
    _model = [UserInfoModel mj_objectWithKeyValues:UserInfoDict];
    [self setNavigationView];
    [self CreateUIView];
    [self loadMessageView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changePhoto:) name:@"changePhoto" object:nil];
}

-(void)changePhoto:(NSNotification *)notification {
    
    NSLog(@"%@",notification);
    if (notification.userInfo) {
        [_photoImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseURL,notification.userInfo]] placeholderImage:nil];
    }
}

-(void)setNavigationView {
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, SafeAreaTopHeight)];
    titleView.backgroundColor = ThemeColor;
    [self.view addSubview:titleView];
    
    UIImageView *btnBack = [[UIImageView alloc] initWithFrame:CGRectMake(15, StatubarHeight+(NavigtionHeight-20)/2, 11, 20)];
    btnBack.image = [UIImage imageNamed:@"home_icon_return@2x"];
    [titleView addSubview:btnBack];
    
    UIView *BackView = [[UIView alloc] initWithFrame:CGRectMake(0, StatubarHeight, 50, 44)];
    BackView.userInteractionEnabled = YES;
    [titleView addSubview:BackView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backButtonBar)];
    [BackView addGestureRecognizer:tap];
    
    UILabel *lb_title = [[UILabel alloc] init];
    lb_title.frame = CGRectMake(0, StatubarHeight, kScreenWidth, NavigtionHeight);
    lb_title.textColor = WhiteColor;
    lb_title.textAlignment = NSTextAlignmentCenter;
    lb_title.font = LSYUIFont(17);
    lb_title.text = @"个人中心";
    [titleView addSubview:lb_title];
}

-(void)CreateUIView {
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight, kScreenWidth, 110)];
    bgView.backgroundColor = ThemeColor;
    bgView.userInteractionEnabled = YES;
    [self.view addSubview:bgView];
    
    UILabel *line = [[UILabel alloc] init];
    line.backgroundColor = LineColor;
    line.frame = CGRectMake(0, CGRectGetMaxY(bgView.frame), kScreenWidth, 1);
    [self.view addSubview:line];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(messageInfo)];
    [bgView addGestureRecognizer:tap];
    
    if (!_photoImg) {
        _photoImg = [[UIImageView alloc] initWithFrame:CGRectMake(15, 20, 70, 70)];
        _photoImg.layer.cornerRadius = 35;
        _photoImg.layer.masksToBounds = YES;
        _photoImg.image = [UIImage imageNamed:@"my_man@2x"];
        _photoImg.contentMode = UIViewContentModeScaleToFill;
        _photoImg.backgroundColor = [UIColor redColor];
        [bgView addSubview:_photoImg];
    }
    
    if (!_nameLab) {
        _nameLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_photoImg.frame)+15, CGRectGetMinY(_photoImg.frame)+5, kScreenWidth, 20)];
        _nameLab.textColor = WhiteColor;
        _nameLab.textAlignment = NSTextAlignmentLeft;
        _nameLab.font = [UIFont systemFontOfSize:15];
        _nameLab.text = _model.username;
        [bgView addSubview:_nameLab];
    }
    
    if (!_departmenLab) {
        _departmenLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_photoImg.frame)+15, CGRectGetMaxY(_photoImg.frame)-25, kScreenWidth, 20)];
        _departmenLab.textColor = WhiteColor;
        _departmenLab.textAlignment = NSTextAlignmentLeft;
        _departmenLab.font = [UIFont systemFontOfSize:15];
        _departmenLab.text = _model.deptName;
        [bgView addSubview:_departmenLab];
    }
    
    if (!_nextImg) {
        _nextImg = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth-23, 48, 8, 14)];
        _nextImg.image = [UIImage imageNamed:@"my_icon_nexts@2x"];
        _nextImg.contentMode = UIViewContentModeScaleToFill;
        [bgView addSubview:_nextImg];
    }
    
    _btnChangePassw = [[BroughtButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(bgView.frame)+20, kScreenWidth, 45)];
    _btnChangePassw.left_imgV.hidden = YES;
    _btnChangePassw.right_lab.hidden = YES;
    _btnChangePassw.left_lab.frame = CGRectMake(15, 0, 100, 45);
    _btnChangePassw.left_lab.text = @"修改密码";
    [_btnChangePassw addTarget:self action:@selector(changePasswAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btnChangePassw];
    
    
    UIButton *post = [UIButton buttonWithType:UIButtonTypeCustom];
    post.frame = CGRectMake((kScreenWidth-300)/2, kScreenHeight-TabbarHeight-80, 300, 40);
    post.backgroundColor = ThemeColor;
    post.layer.cornerRadius = 4;
    post.layer.masksToBounds = YES;
    [post setTitle:@"退出登录" forState:UIControlStateNormal];
    post.titleLabel.font = LSYUIFont(17);
    post.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [post setTitleColor:WhiteColor forState:UIControlStateNormal];
    [post addTarget:self action:@selector(quitAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:post];
}

-(void)loadMessageView {
    [_photoImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseURL,_model.img]] placeholderImage:nil];
    _nameLab.text = _model.username;
    _departmenLab.text = _model.deptName;
}

#pragma mark -- 个人信息
-(void)messageInfo {
    MyMessageViewController *v = [[MyMessageViewController alloc]init];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [v loadViewWithData:_model];
    });
    [self.navigationController pushViewController:v animated:YES];
}

//退出登录
-(void)quitAction {
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user removeObjectForKey:@"userinfo"];
    [user removeObjectForKey:@"passw"];
    [user removeObjectForKey:@"userId"];
    [user removeObjectForKey:@"fid"];
//    [JPUSHService setTags:nil completion:^(NSInteger iResCode, NSSet *iTags, NSInteger seq) {
//    } seq:0];
    
    XELoginViewController *login = [[XELoginViewController alloc] init];
    [self.navigationController pushViewController:login animated:YES];

}

//修改密码
-(void)changePasswAction {
    ChangePasswViewController *passw = [[ChangePasswViewController alloc] init];
    [self.navigationController pushViewController:passw animated:YES];
}

-(void)backButtonBar{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
