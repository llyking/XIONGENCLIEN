//
//  OrderViewController.m
//  XIONGEN
//
//  Created by Ios on 2018/1/16.
//  Copyright © 2018年 Ios. All rights reserved.
//

#import "OrderViewController.h"
#import "XEHeadTitleView.h"
#import "XE_HomeMiddleView.h"
#import "PlaceOrderViewController.h"
#import "MyOrdersViewController.h"

@interface OrderViewController ()

@property (nonatomic,strong) XEHeadTitleView *headTitleView;
@property (nonatomic,strong) XEMoreButton *saleOrder;
@property (nonatomic,strong) XEMoreButton *myOrder;

@end

@implementation OrderViewController

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
    
    [self setNavigtion];
    [self setui];
}

//导航
-(void)setNavigtion {
    if (!_headTitleView) {
        _headTitleView = [[XEHeadTitleView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, SafeAreaTopHeight)];
        _headTitleView.lb_title.text = @"订单";
        _headTitleView.btn_right.hidden = YES;
        [self.view addSubview:_headTitleView];
    }
}

-(void)setui {
    UIView *buttonView = [[UIView alloc] init];
    buttonView.frame = CGRectMake(0, SafeAreaTopHeight+10, kScreenWidth, 90);
    buttonView.backgroundColor = WhiteColor;
    [self.view addSubview:buttonView];
    
    _saleOrder = [[XEMoreButton alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 45)];
    _saleOrder.lb_title.text = @"客户下单";
    _saleOrder.lb_more.text = @"添加";
    _saleOrder.img_left.frame = CGRectMake(mergin_left, 10, 25, 25);
    _saleOrder.img_left.image = [UIImage imageWithContentsOfFile:ImagePath(@"order_billing@2x")];
    _saleOrder.tag = 100;
    [_saleOrder addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [buttonView addSubview:_saleOrder];
    
    _myOrder = [[XEMoreButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_saleOrder.frame), kScreenWidth, 45)];
    _myOrder.lb_title.text = @"我的订单";
    _myOrder.lb_more.text = @"查看";
    _myOrder.img_left.frame = CGRectMake(mergin_left, 10, 25, 25);
    _myOrder.img_left.image = [UIImage imageWithContentsOfFile:ImagePath(@"order_my@2x")];
    _myOrder.line.hidden = YES;
    _myOrder.tag = 200;
    [_myOrder addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [buttonView addSubview:_myOrder];
}

-(void)btnAction:(UIButton *)btn {
    switch (btn.tag) {
        case 100:
        {
            PlaceOrderViewController *place = [[PlaceOrderViewController alloc] init];
            [self.navigationController pushViewController:place animated:YES];
        }
            break;
        case 200:
        {
            MyOrdersViewController *myorder = [[MyOrdersViewController alloc] init];
            [self.navigationController pushViewController:myorder animated:YES];
        }
            break;
        default:
            break;
    }
}




@end
