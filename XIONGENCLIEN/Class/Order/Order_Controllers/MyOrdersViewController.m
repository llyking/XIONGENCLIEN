//
//  MyOrdersViewController.m
//  XIONGEN
//
//  Created by Ios on 2018/1/23.
//  Copyright © 2018年 Ios. All rights reserved.
//

#import "MyOrdersViewController.h"

#import "MyOrderAllViewController.h"
#import "MyOrderFinishedViewController.h"
#import "MyOrderReturnViewController.h"
#import "RecivedViewController.h"

@interface MyOrdersViewController () <UIScrollViewDelegate>

@property (nonatomic,strong) UIButton *button;
@property (nonatomic,strong) NSMutableArray *btnArray;
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIView *lineView;
@property (nonatomic,strong) UIView *barView;

@end

@implementation MyOrdersViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.navigationBar.hidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigation];
    
}

#pragma mark -- NavigationBar
-(void)setNavigation {
    
    self.view.backgroundColor = UIColorFromRGB(0xf6f6f6);
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, SafeAreaTopHeight)];
    bgView.backgroundColor = ThemeColor;
    [self.view addSubview:bgView];
    
    UILabel *Namelab = [[UILabel alloc] initWithFrame:CGRectMake(0, StatubarHeight, kScreenWidth, 44)];
    Namelab.font = [UIFont systemFontOfSize:18];
    Namelab.textColor = WhiteColor;
    Namelab.textAlignment = NSTextAlignmentCenter;
    Namelab.text = @"我的订单";
    [bgView addSubview:Namelab];
    
    UIImageView *btnBack = [[UIImageView alloc] initWithFrame:CGRectMake(15, StatubarHeight+(NavigtionHeight-20)/2, 11, 20)];
    btnBack.image = [UIImage imageNamed:@"home_icon_return@2x"];
    [bgView addSubview:btnBack];
    
    UIView *BackView = [[UIView alloc] initWithFrame:CGRectMake(0, StatubarHeight, 50, 44)];
    [bgView addSubview:BackView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backButton)];
    [BackView addGestureRecognizer:tap];
    
    [self setTopAndScrollView];
}


-(void)setTopAndScrollView {
    
    _btnArray = [[NSMutableArray alloc] init];
    _barView = [[UIView alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight, kScreenWidth, 50)];
    _barView.backgroundColor = UIColorFromRGB(0xffffff);
    [self.view addSubview:_barView];
    
    NSArray * array = @[@"全部",@"待确定",@"待收货",@"已收货"];
    for (int i = 0; i < array.count; i ++) {
        _button = [[UIButton alloc] init];
        _button.frame = CGRectMake(i*kScreenWidth/4, SafeAreaTopHeight, kScreenWidth/4, 50);
        [_button setTitle:array[i] forState:UIControlStateNormal];
        [_button setTitleColor:UIColorFromRGB(0x666666) forState:UIControlStateNormal];
        [_button setTitleColor:ThemeColor forState:UIControlStateSelected];
        _button.titleLabel.textAlignment = NSTextAlignmentCenter;
        _button.titleLabel.font = [UIFont systemFontOfSize:15];
        _button.tag = 99+i;
        [_button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_button];
        
        [_btnArray addObject:_button];
        
        if (i == 0) {
            _button.selected = YES;
        }else{
            _button.selected = NO;
        }
        
//        if (i>0) {
//            UILabel *line = [[UILabel alloc] init];
//            line.frame = CGRectMake(i*kScreenWidth/4, 0, 1, 50);
//            line.backgroundColor = LineColor;
//            [_barView addSubview:line];
//        }
    }
    
    _lineView = [[UIView alloc] init];
    _lineView.frame = CGRectMake(0, CGRectGetMaxY(_barView.frame)-2, kScreenWidth/4, 2);
    _lineView.backgroundColor = ThemeColor;
    [self.view addSubview:_lineView];
    
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_barView.frame), kScreenWidth, 1.0)];
    line.backgroundColor = LineColor;
    [self.view addSubview:line];
    
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.frame = CGRectMake(0, CGRectGetMaxY(line.frame), kScreenWidth, kScreenHeight-SafeAreaTopHeight-SafeAreaBottomHeight-50);
    _scrollView.delegate = self;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = NO;
    _scrollView.backgroundColor = UIColorFromRGB(0xf6f6f6);
    [self.view addSubview:_scrollView];
    
    CGFloat View_W = _scrollView.frame.size.width;
    CGFloat View_H = _scrollView.frame.size.height;
    _scrollView.contentSize = CGSizeMake(View_W*4, View_H);
    
    //全部
    MyOrderAllViewController *allVC = [[MyOrderAllViewController alloc] init];
    allVC.view.frame = CGRectMake(0*View_W, 0, View_W, View_H);
    [_scrollView addSubview:allVC.view];
    [self addChildViewController:allVC];
    
    //待确定
    MyOrderFinishedViewController *finishVC = [[MyOrderFinishedViewController alloc] init];
    finishVC.view.frame = CGRectMake(1*View_W, 0, View_W, View_H);
    [_scrollView addSubview:finishVC.view];
    [self addChildViewController:finishVC];
    
    //待收货
    MyOrderReturnViewController *returnVC = [[MyOrderReturnViewController alloc] init];
    returnVC.view.frame = CGRectMake(2*View_W, 0, View_W, View_H);
    [_scrollView addSubview:returnVC.view];
    [self addChildViewController:returnVC];
    
    //已收货
    RecivedViewController *receivedVC = [[RecivedViewController alloc] init];
    receivedVC.view.frame = CGRectMake(3*View_W, 0, View_W, View_H);
    [_scrollView addSubview:receivedVC.view];
    [self addChildViewController:receivedVC];
}

- (void)buttonClick:(UIButton *)button {
    UIButton * btn = (UIButton *)[self.view viewWithTag:button.tag];
    NSInteger index = btn.tag-99;
    [UIView animateWithDuration:0.3 animations:^{
        _scrollView.contentOffset = CGPointMake(index*_scrollView.frame.size.width, 0);
        
        if (index==0) {
            _lineView.frame = CGRectMake(0, CGRectGetMaxY(_barView.frame)-2, kScreenWidth/4, 2);
        } else {
            _lineView.frame = CGRectMake(index*kScreenWidth/4, CGRectGetMaxY(_barView.frame)-2, kScreenWidth/4, 2);
        }
    }];
    
    for (int i = 0; i < _btnArray.count; i ++) {
        UIButton * button = _btnArray[i];
        if (i == index) {
            button.selected = YES;
        }else{
            button.selected = NO;
        }
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger index = scrollView.contentOffset.x/kScreenWidth;
    [UIView animateWithDuration:0.3 animations:^{
        if (index==0) {
            _lineView.frame = CGRectMake(0, CGRectGetMaxY(_barView.frame)-2, kScreenWidth/4, 2);
        } else {
            _lineView.frame = CGRectMake(index*kScreenWidth/4, CGRectGetMaxY(_barView.frame)-2, kScreenWidth/4, 2);
        }
    }];
    for (int i = 0; i < _btnArray.count; i ++) {
        UIButton * button = _btnArray[i];
        if (i == index) {
            button.selected = YES;
        }else{
            button.selected = NO;
        }
    }
}

-(void)backButton {
    
    [self.navigationController popViewControllerAnimated:YES];
}



@end
