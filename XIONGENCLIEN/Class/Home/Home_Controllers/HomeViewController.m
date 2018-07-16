//
//  HomeViewController.m
//  XIONGEN
//
//  Created by Ios on 2018/1/16.
//  Copyright © 2018年 Ios. All rights reserved.
//

#import "HomeViewController.h"
#import "XE_HomeHeadTitleView.h"
#import "XE_HomeChartView.h"
#import "XE_HomeMiddleView.h"
#import "XE_HomeBtnView.h"

#import "ScanViewController.h"
#import "MyViewController.h"
#import "MessageViewController.h"
#import "AddressBookViewController.h"
#import "PendViewController.h"
#import "MMScanViewController.h"

@interface HomeViewController () <SDCycleScrollViewDelegate,UITabBarControllerDelegate>

@property (nonatomic,strong) UIScrollView *mainScrollView;
@property (nonatomic,strong) XE_HomeHeadTitleView *homeTitleView;
@property (nonatomic,strong) SDCycleScrollView *homeCycleView;

@end

@implementation HomeViewController

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
    self.view.backgroundColor = WhiteColor;
    self.tabBarController.delegate = self;
    [self setHeadTitleView];
    [self setHomeMainScrollView];
    [self setTopChartView];
}

-(void)setHomeMainScrollView {
    if (!_mainScrollView) {
        _mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_homeTitleView.frame), kScreenWidth, kScreenHeight-SafeAreaTopHeight-TabbarHeight)];
        _mainScrollView.backgroundColor = WhiteColor;
        _mainScrollView.showsVerticalScrollIndicator = NO;
        [self.view addSubview:_mainScrollView];
    }
}

-(void)setHeadTitleView {
    if (!_homeTitleView) {
        _homeTitleView = [[XE_HomeHeadTitleView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, SafeAreaTopHeight)];
        _homeTitleView.lb_title.text = @"雄恩贸易";
        _homeTitleView.backgroundColor = ThemeColor;
        [_homeTitleView.btn_scan setImage:[UIImage imageWithContentsOfFile:ImagePath(@"home_icon_cord@2x")] forState:UIControlStateNormal];
        [_homeTitleView.btn_my setImage:[UIImage imageWithContentsOfFile:ImagePath(@"home_mine@2x")] forState:UIControlStateNormal];
        [self.view addSubview:_homeTitleView];
        
        WS(weakSelf)
        [_homeTitleView setXeHomeHeadViewBtnCallBack:^(XEBtnType type) {
            switch (type) {
                case XEHomeTopScanBtnType:
                {
                    //扫描
                    MMScanViewController *scanVc = [[MMScanViewController alloc] initWithQrType:MMScanTypeQrCode onFinish:^(NSString *result, NSError *error) {
                        if (error) {
                            NSLog(@"error: %@",error);
                        } else {
                            NSLog(@"扫描结果：%@",result);
                            [weakSelf showInfo:result];
                        }
                    }];
                    [weakSelf.navigationController pushViewController:scanVc animated:YES];
                }
                    break;
                case XEHomeTopMyBtnType:
                {
                    //我的
                    MyViewController *my = [[MyViewController alloc] init];
                    [weakSelf.navigationController pushViewController:my animated:YES];
                }
                    break;
                default:
                    break;
            }
        }];
    }
}

#pragma mark - 轮播图
-(void)setTopChartView {
    
    if (!_homeCycleView) {
        
        NSArray *imagesURLStrings = @[@"home-01.jpeg",@"home-02.jpeg",@"home-03.jpeg",@"home-04.jpeg"];
        // >>>>>>>>>>>>>>>>>>>>>>>>> demo轮播图2 >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
        _homeCycleView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreenWidth, 200) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
        _homeCycleView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        _homeCycleView.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
        [_mainScrollView addSubview:_homeCycleView];
//         --- 模拟加载延迟
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            _homeCycleView.localizationImageNamesGroup = imagesURLStrings;
        });
        
        /*
         block监听点击方式
         cycleScrollView2.clickItemOperationBlock = ^(NSInteger index) {
         NSLog(@">>>>>  %ld", (long)index);
         };
         */
        CGFloat contentY = _homeCycleView.frame.size.height;
        [_mainScrollView setContentSize:CGSizeMake(0, contentY)];
    }
}

#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    
    NSLog(@"---点击了第%ld张图片", (long)index);
//    [self.navigationController pushViewController:[NSClassFromString(@"DemoVCWithXib") new] animated:YES];
}

#pragma mark - Error handle 扫描错误提示
- (void)showInfo:(NSString*)str {
    [self showInfo:str andTitle:@"提示"];
    ScanViewController *scan = [[ScanViewController alloc] init];
    [self.navigationController pushViewController:scan animated:YES];
}

- (void)showInfo:(NSString*)str andTitle:(NSString *)title {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:str preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action1 = ({
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:NULL];
        action;
    });
    [alert addAction:action1];
    [self presentViewController:alert animated:YES completion:NULL];
}

//点击的时候触发的方法
-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    
    switch (self.tabBarController.selectedIndex) {
        case 0://首页
        {
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"SelectMyPage" object:nil];
        }
            break;
        case 2://查询
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"SelectGood" object:nil];
        }
            break;
        case 3://收货
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"RecivedGood" object:nil];
        }
            break;
        case 4://消息
        {
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"SelectMyPage" object:nil];
        }
            break;
        default:
            break;
    }
}

//防止这个页面一直点击tabbar 的方法
-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    UIViewController *tbselect=tabBarController.selectedViewController;
    if([tbselect isEqual:viewController]){
        return NO;
    }
    return YES;
}

/*
-(void)setHomeButtonsView {
    if (!_btnView) {
        _btnView = [[XE_HomeBtnView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_middleTitleView.frame), kScreenWidth, 200)];
        [_btnView reloadViewWithData:@[@"消息",@"通讯录",@"待审批"]];
        [_mainScrollView addSubview:_btnView];
        
        CGFloat contentY = _btnView.frame.size.height;
        [_mainScrollView setContentSize:CGSizeMake(0, contentY)];
        
        WS(weakSelf)
        [_btnView setXeHomeBtnCallBack:^(XEBtnType type) {
            switch (type) {
                case XEHomeMessageBtnType:
                {
                    //消息
                    MessageViewController *message = [[MessageViewController alloc] init];
                    [weakSelf.navigationController pushViewController:message animated:YES];
                }
                    break;
                case XEHomeAddressBookBtnType:
                {
                    //通讯录
                    AddressBookViewController *addressbook = [[AddressBookViewController alloc] init];
                    [weakSelf.navigationController pushViewController:addressbook animated:YES];
                }
                    break;
                case XEHomePendingBtnType:
                {
                    //待审批
                    PendViewController *pend = [[PendViewController alloc] init];
                    [weakSelf.navigationController pushViewController:pend animated:YES];
                }
                    break;
                default:
                    break;
            }
        }];
    }
}
*/







@end
