//
//  AppDelegate.m
//  XIONGEN
//
//  Created by Ios on 2018/1/16.
//  Copyright © 2018年 Ios. All rights reserved.
//

#import "AppDelegate.h"
#import "XE_TabBarController.h"
#import "XELoginViewController.h"

#import "JPUSHService.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
// 如果需要使用idfa功能所需要引入的头文件（可选）
#import <AdSupport/AdSupport.h>

#define APPKey @"185aa358406401c566bdefe3"

@interface AppDelegate () <JPUSHRegisterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //设置电池颜色白色
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    //键盘回收
    [self keyBoard];
    if (USERID!=nil&&BaseURL!=nil) {
        
        [self loginToHome];
        
    } else {
        XELoginViewController *vc = [[XELoginViewController alloc] init];
        UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:vc];
        self.window.rootViewController = nvc;
    }
    
    return YES;
}

#pragma mark - 判断账号是否已登录过，已登录过直接登录到首页，没有登录过跳转登录页面登录
-(void)loginToHome {
    UserInfoModel *model = [UserInfoModel mj_objectWithKeyValues:UserInfoDict];
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:model.account,@"account",Passw,@"password", nil];
    [HttpRoadData postUpdateInfoInViewNo:nil withVersionCode:[NSString stringWithFormat:@"%@%@",BaseURL,@"back/api/appLogin.do"] NSMutableDictionary:dict successBlock:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *parm = responseObject;
        if ([[NSString stringWithFormat:@"%@",parm[@"success"]] isEqualToString:@"1"] && [[NSString stringWithFormat:@"%@",parm[@"errcode"]] isEqualToString:@"0"]) {
            
            [self gotoHome];
            
            //设置推送标签
//            NSString *subarea = [parm[@"data"][@"subarea"] stringValue];
//            NSMutableSet *set = [[NSMutableSet alloc] initWithObjects:subarea,nil, nil]; // 标签
//            [JPUSHService setTags:set completion:^(NSInteger iResCode, NSSet *iTags, NSInteger seq) {
//                NSLog(@"%tu,%@,%tu",iResCode,iTags,seq);
//            } seq:0];
            
        } else {
            
            XELoginViewController *vc = [[XELoginViewController alloc] init];
            UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:vc];
            self.window.rootViewController = nvc;
        }
        
    } failureBlock:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}


- (void)gotoHome {
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];  // 获得根窗口
    XE_TabBarController *tabar = [[XE_TabBarController alloc] init];//将登录控制器设置为window的根控制器
    tabar.selectedIndex = 2;
    window.rootViewController = tabar;
    
    CATransition *myTransition=[CATransition animation];//创建CATransition
    myTransition.duration=0.35;//持续时长0.35秒
    myTransition.timingFunction=UIViewAnimationCurveEaseInOut;//计时函数，从头到尾的流畅度
    myTransition.type = kCATransitionFade;//子类型
    [window.layer addAnimation:myTransition forKey:nil];
}

#pragma mark - 遮挡处理 -
- (void)keyBoard {
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = NO;
}

#pragma mark - application delegate
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


#pragma mark - setJPushWithLaunch
- (void)setJPushWithLaunch:(NSDictionary *)launchOptions {
    
    [JPUSHService setBadge:0];
    [UIApplication sharedApplication].applicationIconBadgeNumber=0;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
        //iOS10以上
        JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
        if (@available(iOS 10.0, *)) {
            entity.types = UNAuthorizationOptionAlert|UNAuthorizationOptionBadge|UNAuthorizationOptionSound;
        } else {
            // Fallback on earlier versions
        }
        [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
        
    }else if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //iOS8以上可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert) categories:nil];
        
    } else {
        //iOS8以下categories 必须为nil
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert) categories:nil];
        
    }
    BOOL isProduction = NO;// NO为开发环境，YES为生产环境
    // Required
    // init Push
    // notice: 2.1.5版本的SDK新增的注册方法，改成可上报IDFA，如果没有使用IDFA直接传nil
    // 如需继续使用pushConfig.plist文件声明appKey等配置内容，请依旧使用[JPUSHService setupWithOption:launchOptions]方式初始化。
    [JPUSHService setupWithOption:launchOptions appKey:APPKey
                          channel:@"App Store"
                 apsForProduction:isProduction
            advertisingIdentifier:nil];
    
    //2.1.9版本新增获取registration id block接口。可以获取registrationID
    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
        if(resCode == 0){
            NSLog(@"registrationID获取成功：%@",registrationID);
        } else {
            NSLog(@"registrationID获取失败，code：%d",resCode);
        }
    }];
    
}

#pragma mark- JPUSHRegisterDelegate
// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler  API_AVAILABLE(ios(10.0)){
    
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        
        NSLog(@"iOS10 前台收到远程通知:%@", [self logDic:userInfo]);
        [JPUSHService handleRemoteNotification:userInfo];
        if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive) {
            
            //            [self pushMessageDetailVC];
            
        } else {
            //APP没有运行，推送过来消息的处理
            [self pushMessageDetailVC];
        }
        
    } else {
        // 判断为本地通知
        //        NSLog(@"iOS10 前台收到本地通知:{\nbody:%@，\ntitle:%@,\nsubtitle:%@,\nbadge：%@，\nsound：%@，\nuserInfo：%@\n}",body,title,subtitle,badge,sound,userInfo);
    }
    completionHandler(UNNotificationPresentationOptionAlert|UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
    [JPUSHService setBadge:0];
    
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler  API_AVAILABLE(ios(10.0)){
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        
        [JPUSHService handleRemoteNotification:userInfo];
        if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive) {
            [self pushMessageDetailVC];
        } else {
            //APP没有运行，推送过来消息的处理
            [self pushMessageDetailVC];
        }
        
    } else {
        // 判断为本地通知
        //        NSLog(@"iOS10 收到本地通知:{\nbody:%@，\ntitle:%@,\nsubtitle:%@,\nbadge：%@，\nsound：%@，\nuserInfo：%@\n}",body,title,subtitle,badge,sound,userInfo);
    }
    completionHandler();  // 系统要求执行这个方法
    [JPUSHService setBadge:0];
    [UIApplication sharedApplication].applicationIconBadgeNumber=0;
    
}


-(void)pushMessageDetailVC {
    UIViewController *VC = [[UIViewController alloc] init];
    UIViewController *vc = [self topVC:[UIApplication sharedApplication].keyWindow.rootViewController]; //拿到当前页面的VC
    
    if ([vc isKindOfClass:[VC class]]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"MessageViewController" object:self];
        return;
    }
    [vc.navigationController pushViewController:VC animated:YES];
}


- (UIViewController *)topVC:(UIViewController *)rootViewController{
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tab = (UITabBarController *)rootViewController;
        return [self topVC:tab.selectedViewController];
    }else if ([rootViewController isKindOfClass:[UINavigationController class]]){
        UINavigationController *navc = (UINavigationController *)rootViewController;
        return [self topVC:navc.visibleViewController];
    }else if (rootViewController.presentedViewController){
        UIViewController *pre = (UIViewController *)rootViewController.presentedViewController;
        return [self topVC:pre];
    }else{
        return rootViewController;
    }
}


- (NSString *)logDic:(NSDictionary *)dic {
    if (![dic count]) {
        return nil;
    }
    NSString *tempStr1 =
    [[dic description] stringByReplacingOccurrencesOfString:@"\\u"
                                                 withString:@"\\U"];
    NSString *tempStr2 =
    [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 =
    [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *str =
    [NSPropertyListSerialization propertyListFromData:tempData
                                     mutabilityOption:NSPropertyListImmutable
                                               format:NULL
                                     errorDescription:NULL];
    return str;
}


@end
