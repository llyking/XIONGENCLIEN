//
//  PublicViewController.m
//  TianCi
//
//  Created by Ios on 17/3/14.
//  Copyright © 2017年 Ios. All rights reserved.
//

#import "PublicViewController.h"

@interface PublicViewController ()

@property (nonatomic, copy) void(^rightButtonClickHandle)(NSInteger tag);

@end

@implementation PublicViewController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    self.navigationController.navigationBar.hidden = YES;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

-(void)viewDidAppear:(BOOL)animated{
}


-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor = WhiteColor;
    [self setView];
}

-(void)setView {
    
    _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, SafeAreaTopHeight)];
    _topView.backgroundColor = ThemeColor;
    [self.view addSubview:_topView];
    
    _Namelab = [[UILabel alloc] initWithFrame:CGRectMake(30, StatubarHeight, kScreenWidth-45, 44)];
    _Namelab.font = [UIFont systemFontOfSize:18];
    _Namelab.textColor = WhiteColor;
    _Namelab.textAlignment = NSTextAlignmentCenter;
    _Namelab.adjustsFontSizeToFitWidth = YES;
    [_topView addSubview:_Namelab];
    
    UIImageView *btnBack = [[UIImageView alloc] initWithFrame:CGRectMake(15, StatubarHeight+(NavigtionHeight-20)/2, 11, 20)];
    btnBack.image = [UIImage imageNamed:@"home_icon_return@2x"];
    [_topView addSubview:btnBack];
    
    UIView *BackView = [[UIView alloc] initWithFrame:CGRectMake(0, StatubarHeight, 50, 44)];
    BackView.userInteractionEnabled = YES;
    [_topView addSubview:BackView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backButtonBar)];
    [BackView addGestureRecognizer:tap];
    
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_topView.frame)-0.5, kScreenWidth, 0.5)];
    line.backgroundColor = UIColorFromRGB(0xdedede);
//    [_topView addSubview:line];
    
    _topScrollerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_topView.frame), kScreenWidth, kScreenHeight)];
    _topScrollerView.backgroundColor = WhiteColor;
    _topScrollerView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_topScrollerView];
}

-(void)backButtonBar{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Meth
- (void)createRightBtnWithImageArray:(NSArray *)images handle:(void(^)(NSInteger tag)) handle{
    self.rightButtonClickHandle = [handle copy];
    [self createRightBtnWithImageArray:images];
}

- (void)createRightBtnWithImageArray:(NSArray *)images{
    WS(weakSelf)
    CGFloat btnWidth = 30;
    CGFloat btnHeigth = 50;
    [images enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *tempButon = [UIButton buttonWithType:UIButtonTypeCustom];
        [tempButon setImage:HKFastImage(obj) forState:UIControlStateNormal];
        [tempButon setTag:idx + 1000];
        [tempButon addTarget:self action:@selector(rightBtnsClicked:) forControlEvents:UIControlEventTouchUpInside];
        tempButon.adjustsImageWhenHighlighted = NO;
        [weakSelf.topView addSubview:tempButon];
        
        [tempButon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf.topView).offset(- ((btnWidth + 5) *idx + 10));
            make.bottom.equalTo(weakSelf.topView);
            make.width.equalTo(@(btnWidth));
            make.height.equalTo(@(btnHeigth));
        }];
    }];
}

- (void)superPushLoginView{
//    Login_VC *push = [[Login_VC alloc] init];
//    [self.navigationController pushViewController:push animated:YES];
}

- (void)rightBtnsClicked:(UIButton *)sender{
    if(self.rightButtonClickHandle){
        self.rightButtonClickHandle(sender.tag);
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
