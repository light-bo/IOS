//
//  AppDelegate.m
//
//  Created by light_bo on 2017/12/21.
//

#import "AppDelegate.h"
#import <UserNotifications/UserNotifications.h>


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self registerForRemoteNotification];
    
    return YES;
}

#pragma mark - 注册系统消息通知
- (void)registerForRemoteNotification {
    // iOS 10 兼容
    if (@available(iOS 10.0, *)) {
        // 使用 UNUserNotificationCenter 来管理通知
        UNUserNotificationCenter *uncenter = [UNUserNotificationCenter currentNotificationCenter];
        // 监听回调事件
        [uncenter setDelegate:self];
        
        //iOS 10 使用以下方法注册，才能得到授权
        [uncenter requestAuthorizationWithOptions:(UNAuthorizationOptionAlert+UNAuthorizationOptionBadge+UNAuthorizationOptionSound)
                                completionHandler:^(BOOL granted, NSError * _Nullable error) {
                                    dispatch_async(dispatch_get_main_queue(), ^{
                                        if (_registerRemoteNotificationsDoneBlock) {
                                            _registerRemoteNotificationsDoneBlock();
                                            _registerRemoteNotificationsDoneBlock = nil;
                                        }
                                        
                                        [[UIApplication sharedApplication] registerForRemoteNotifications];
                                    });
                                    //TODO:授权状态改变
                                    NSLog(@"%@" , granted ? @"授权成功" : @"授权失败");
                                }];
        
        // 获取当前的通知授权状态, UNNotificationSettings
        [uncenter getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
            NSLog(@"%s\nline:%@\n-----\n%@\n\n", __func__, @(__LINE__), settings);
            /*
             UNAuthorizationStatusNotDetermined : 没有做出选择
             UNAuthorizationStatusDenied : 用户未授权
             UNAuthorizationStatusAuthorized ：用户已授权
             */
            if (settings.authorizationStatus == UNAuthorizationStatusNotDetermined) {
                PDLog(@"用户未选择系统通知");
            } else if (settings.authorizationStatus == UNAuthorizationStatusDenied) {
                PDLog(@"用户未授权系统消息通知");
            } else if (settings.authorizationStatus == UNAuthorizationStatusAuthorized) {
                PDLog(@"用户已授权系统消息通知");
            }
        }];
    } else if (@available(iOS 8.0, *)) {
        UIUserNotificationType types = UIUserNotificationTypeAlert |
        UIUserNotificationTypeBadge |
        UIUserNotificationTypeSound;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
}

#pragma mark - UNUserNotificationCenterDelegate
/**
 * Required for iOS 10+
 * 在前台收到推送内容, 执行的方法
 */
- (void)userNotificationCenter:(UNUserNotificationCenter *)center
       willPresentNotification:(UNNotification *)notification
         withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler NS_AVAILABLE_IOS(10.0) {
    NSDictionary *userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //TODO:处理远程推送内容
        NSLog(@"%@", userInfo);
    }
    
    // 需要执行这个方法，选择是否提醒用户，有 Badge、Sound、Alert 三种类型可以选择设置
    //   completionHandler(UNNotificationPresentationOptionAlert);
}


/**
 * Required for iOS 10+
 * 在后台和启动之前收到推送内容, 点击推送后执行的方法
 */
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler NS_AVAILABLE_IOS(10.0) {
    NSDictionary *userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]])  {
        //TODO:处理远程推送内容
        NSLog(@"%@", userInfo);
        [self handlePushMsg:userInfo isCurrentForeground:NO];
    }
    
    completionHandler();
}


- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    NSLog(@"%@", userInfo);
    //应用在前台，标记数据已读
    if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive) {
        [self clearAppBadges];
    }

    [self handlePushMsg:userInfo isCurrentForeground:[UIApplication sharedApplication].applicationState == UIApplicationStateActive];
    
    // Must be called when finished
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    if (deviceToken) {
        if (_registerRemoteNotificationsDoneBlock) {
            _registerRemoteNotificationsDoneBlock();
            _registerRemoteNotificationsDoneBlock = nil;
        }
        
        NSString *deviceTokenString = [self deviceTokenString:[deviceToken description]];
        NSLog(@"注册 Apns 系统通知成功 DeviceToken:%@", deviceTokenString);
    }
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"%s\n[无法注册远程系统通知, 错误信息]\nline:%@\n-----\n%@\n\n", __func__, @(__LINE__), error);
    if (_registerRemoteNotificationsDoneBlock) {
        _registerRemoteNotificationsDoneBlock();
        _registerRemoteNotificationsDoneBlock = nil;
    }
}

- (NSString *)deviceTokenHexString:(NSString *)dataString {
    return [[dataString stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]] stringByReplacingOccurrencesOfString:@" " withString:@""];
}

#pragma mark - 处理消息推送
- (void)handlePushMsg:(NSDictionary *)userInfo isCurrentForeground:(BOOL)isForeground {
    //handle push msg clicked
    
}


@end
