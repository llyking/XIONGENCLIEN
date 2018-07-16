//
//  XE_TabBarController.m
//  XIONGEN
//
//  Created by Ios on 2018/1/15.
//  Copyright © 2018年 Ios. All rights reserved.
//

#import "XE_TabBarController.h"
#import "XE_NavigationController.h"
#import "QueryViewController.h"
#import "OrderViewController.h"
#import "HomeViewController.h"
#import "FollowOrderViewController.h"
#import "BusinessViewController.h"

@interface XE_TabBarController ()

@end

@implementation XE_TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBar.tintColor = ThemeColor;
    self.tabBar.barTintColor = WhiteColor;
    [self setupAllChildViewController];
}

#pragma mark - 初始化所有controller
- (void)setupAllChildViewController {
    
    //首页
    HomeViewController *homeVC = [[HomeViewController alloc] init];
    [self creatChildViewContorller:homeVC title:@"首页" image:@"home@2x" selecedImage:@"home_theme@2x"];
    
    //订单
    OrderViewController *orderVC = [[OrderViewController alloc] init];
    [self creatChildViewContorller:orderVC title:@"订单" image:@"order@2x" selecedImage:@"order_them@2x"];
    
    //查询
    QueryViewController *hp = [[QueryViewController alloc] init];
    [self creatChildViewContorller:hp title:@"查询" image:@"search_nor@2x" selecedImage:@"search_them@2x"];
    
    //收货
    FollowOrderViewController *followVC = [[FollowOrderViewController alloc] init];
    [self creatChildViewContorller:followVC title:@"收货" image:@"follow@2x" selecedImage:@"follow_theme@2x"];
    
    //消息
    BusinessViewController *businessVC = [[BusinessViewController alloc] init];
    [self creatChildViewContorller:businessVC title:@"消息" image:@"bussies@2x" selecedImage:@"bussies_theme@2x"];
    
}

#pragma mark - 创建子控制器方法
- (void)creatChildViewContorller:(UIViewController*)controller title:(NSString *)title image:(NSString*)image selecedImage:(NSString *)selecedImage {
    
    controller.title = title;
    controller.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    controller.tabBarItem.selectedImage = [[UIImage imageNamed:selecedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //设置tabar文字大小
//    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:12], NSFontAttributeName, nil] forState:(UIControlStateNormal)];
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    attrs[NSForegroundColorAttributeName] = UIColorFromRGB(0xcccccc);
    
    NSMutableDictionary *attrSelected = [NSMutableDictionary dictionary];
    attrSelected[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    attrSelected[NSForegroundColorAttributeName] = ThemeColor;
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:attrSelected forState:UIControlStateSelected];
    
    //设置导航控制器
    XE_NavigationController *nav = [[XE_NavigationController alloc] initWithRootViewController:controller];
    [self  addChildViewController:nav];
    
}





@end
