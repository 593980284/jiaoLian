//
//  AppDelegate.m
//  LXCoach
//
//  Created by tanghaiyang on 2018/9/2.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "AppDelegate.h"
#import "LXNavigationController.h"
#import "LXLoginController.h"
#import <QQ_XGPush/XGPush.h>
#import "LXMineModel.h"
#import "LXTabBarController.h"

#import "LXMessageDataController.h"
#import "LXFindSingleCoachMsgSessionTask.h"
#import "LXFindSingleCoachMsgModel.h"
#import "LXCourseDetailController.h"
#import "LXNavigationManager.h"
#import "LXMessgeDetaileController.h"

@interface AppDelegate ()<XGPushDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.window setBackgroundColor:[UIColor whiteColor]];
    // debug
    [[XGPush defaultManager] setEnableDebug:YES];
    XGNotificationAction *action1 = [XGNotificationAction actionWithIdentifier:@"xgaction001" title:@"xgAction1" options:XGNotificationActionOptionNone];
    XGNotificationAction *action2 = [XGNotificationAction actionWithIdentifier:@"xgaction002" title:@"xgAction2" options:XGNotificationActionOptionDestructive];
    if (action1 && action2) {
        XGNotificationCategory *category = [XGNotificationCategory categoryWithIdentifier:@"xgCategory" actions:@[action1, action2] intentIdentifiers:@[] options:XGNotificationCategoryOptionNone];
        
        XGNotificationConfigure *configure = [XGNotificationConfigure configureNotificationWithCategories:[NSSet setWithObject:category] types:XGUserNotificationTypeAlert|XGUserNotificationTypeBadge|XGUserNotificationTypeSound];
        if (configure) {
            [[XGPush defaultManager] setNotificationConfigure:configure];
        }
    }
    //调用信鸽的初始化方法
    [[XGPush defaultManager] startXGWithAppID:2200312050 appKey:@"IHFU54S128VR" delegate:self];
    [[XGPush defaultManager] setXgApplicationBadgeNumber:0];
    [[XGPush defaultManager] reportXGNotificationInfo:launchOptions];
    
    LXMineModel *mineModel = [LXCacheManager objectForKey:@"LXMineModel"];
    if (mineModel == nil) {
        LXLoginController *login = [[LXLoginController alloc] init];
        LXNavigationController *navc = [[LXNavigationController alloc] initWithRootViewController:login];
        self.window.rootViewController = navc;
    }else {
        LXTabBarController *tabBarController = [[LXTabBarController alloc] init];
        self.window.rootViewController = tabBarController;
    }
    
    [self.window makeKeyAndVisible];
    return YES;
}

/**
 收到推送的回调
 @param application  UIApplication 实例
 @param userInfo 推送时指定的参数
 @param completionHandler 完成回调
 */
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    [[XGPush defaultManager] reportXGNotificationInfo:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}


// iOS 10 新增回调 API
// App 用户点击通知
// App 用户选择通知中的行为
// App 用户在通知中心清除消息
// 无论本地推送还是远程推送都会走这个回调
#if __IPHONE_OS_VERSION_MAX_ALLOWED >=     __IPHONE_10_0
- (void)xgPushUserNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler
{
    //1. 获取msgId参数
    NSString *msgId = [response.notification.request.content.userInfo valueForKey:@"msgId"];
    //2. 根据msgId来获取详细
    LXMessageDataController *mesDataController= [[LXMessageDataController alloc] init];
    [mesDataController lxReuqestFindSingleCoachMsgWithMsgId:msgId completionBlock:^(LXFindSingleCoachMsgResponseObject *responseModel) {
        if (responseModel.flg == 1) {
            if (responseModel.data.msgType == 1) {
                LXMessgeDetaileController *detaileVC = [[LXMessgeDetaileController alloc] init];
                detaileVC.msgId = [msgId integerValue];
                [[LXNavigationManager lx_currentNavigationController] pushViewController:detaileVC animated:YES];
            }else if (responseModel.data.msgType == 2) {
                //3. 跳转课程详情页面
                LXCourseDetailController *detaileVC = [[LXCourseDetailController alloc] init];
                detaileVC.appointmentId = responseModel.data.appointmentId;
                [[LXNavigationManager lx_currentNavigationController] pushViewController:detaileVC animated:YES];
            }
        }
    }];
    [[XGPush defaultManager] reportXGNotificationResponse:response];
    completionHandler();
}

// App 在前台弹通知需要调用这个接口
- (void)xgPushUserNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler
{
    [[XGPush defaultManager] reportXGNotificationInfo:notification.request.content.userInfo];
    completionHandler(UNNotificationPresentationOptionBadge | UNNotificationPresentationOptionSound | UNNotificationPresentationOptionAlert);
    
    
}
#endif


#pragma mark - XGPushDelegate

/**
 @brief 监控信鸽推送服务地启动情况
 
 @param isSuccess 信鸽推送是否启动成功
 @param error 信鸽推送启动错误的信息
 */
- (void)xgPushDidFinishStart:(BOOL)isSuccess error:(nullable NSError *)error {
    NSLog(@"%s, result %@, error %@", __FUNCTION__, isSuccess?@"OK":@"NO", error);
    LXMineModel *mineModel = [LXCacheManager objectForKey:@"LXMineModel"];
    if (mineModel.certNo.length > 0) {
        [[XGPushTokenManager defaultTokenManager] bindWithIdentifier:mineModel.certNo type:XGPushTokenBindTypeAccount];
    }else {
        [[XGPushTokenManager defaultTokenManager] bindWithIdentifier:@"" type:XGPushTokenBindTypeAccount];
    }
}

/**
 @brief 向信鸽服务器注册设备token的回调
 
 @param deviceToken 当前设备的token
 @param error 错误信息
 @note 当前的token已经注册过之后，将不会再调用此方法
 */
- (void)xgPushDidRegisteredDeviceToken:(nullable NSString *)deviceToken error:(nullable NSError *)error {
    
}

- (void)xgPushDidFinishStop:(BOOL)isSuccess error:(NSError *)error {
    
}



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


@end
