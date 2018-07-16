//
//  XE_NavigationController.m
//  XIONGEN
//
//  Created by Ios on 2018/1/15.
//  Copyright © 2018年 Ios. All rights reserved.
//

#import "XE_NavigationController.h"
#import "UINavigationBar+Awesome.h"

@interface XE_NavigationController ()

@end

@implementation XE_NavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

//初始化方法，在这里设置导航栏主题
+ (void)initialize
{
    [self setupBar];
}

+ (void)setupBar
{
    //设置背景图片
    UINavigationBar *bar = [UINavigationBar appearance];
    [bar lt_setBackgroundColor:ThemeColor];
    
    //设置标题格式
    NSDictionary *titleDic = @{NSFontAttributeName : [UIFont systemFontOfSize:18],NSForegroundColorAttributeName : [UIColor whiteColor]};
    
    [bar setTitleTextAttributes:titleDic];
    [bar setTintColor:[UIColor whiteColor]];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIDeviceOrientationPortrait);
}

//拦截push
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if ([UIDevice currentDevice].systemVersion.floatValue >= 7) {
        viewController.edgesForExtendedLayout = UIRectEdgeNone;
    }
    if (self.viewControllers.count >0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
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
