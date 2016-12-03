//
//  AppDelegate.m
//  structure
//
//  Created by ZhangXiaodong on 16/11/6.
//  Copyright © 2016年 ZhangXiaodong. All rights reserved.
//

#import "AppDelegate.h"
#import "DDNavigationController.h"
#import "RootViewController.h"
#import "WebViewController.h"
#import "DDTaskManager.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame: [UIScreen mainScreen].bounds] ;
    
    DDNavigationController * nav = [[DDNavigationController alloc]initWithRootViewController:[RootViewController sharedViewController] ] ;
    
    self.window.rootViewController = nav ;
    
    [self.window makeKeyAndVisible] ;
    
    
    UIUserNotificationSettings * settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeSound | UIUserNotificationTypeBadge categories:nil] ;
    [application registerUserNotificationSettings:settings] ;
    [application registerForRemoteNotifications] ;
    
    NSLog(@"%s",__func__) ;
    
    application.applicationIconBadgeNumber = 0 ;
    UILocalNotification * note = [[UILocalNotification alloc] init]  ;
    note.applicationIconBadgeNumber = 2 ;
    note.alertTitle = @"测试本地通知" ;
    note.alertBody = @"消息来了" ;
    note.userInfo = @{
                      @"test":@"333"
                      } ;
    note.fireDate = [NSDate dateWithTimeIntervalSinceNow:5] ;
    [application scheduleLocalNotification:note] ;
    return YES;
}


- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    if (application.applicationState == UIApplicationStateActive) {
        UIViewController * vc = [self cycleFindMainVC:[RootViewController sharedViewController] ] ;
        NSLog(@"local--notification%@",vc) ;
        [vc.navigationController pushViewController:[WebViewController new] animated:YES] ;
    }else{
        NSLog(@"通知任务加入到队列中") ;
        DDTask * task = [DDTask new ];
        task.type = DDTaskNewPageType ;
        task.pageUrl = @"kachemama://info?ad=34&bc=12" ;
        [DDTaskManager addTask:task] ;
    }

}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    NSLog(@"%s",__func__) ;
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     NSLog(@"%s",__func__) ;
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     NSLog(@"%s",__func__) ;
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     NSLog(@"%s",__func__) ;
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
     NSLog(@"%s",__func__) ;
}

- (UIViewController *)cycleFindMainVC:(UIViewController *)rootVC
{
    if (rootVC.presentedViewController) {
        rootVC = rootVC.presentedViewController ;
        return [self cycleFindMainVC:rootVC] ;
    }
    
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        UITabBarController * tab = (UITabBarController *)rootVC ;
        rootVC = tab.selectedViewController ;
        return [self cycleFindMainVC:rootVC] ;
    }
    
    if ([rootVC isKindOfClass:[UINavigationController class]]) {
        UINavigationController * nav = (UINavigationController *)rootVC ;
        rootVC = nav.topViewController ;
        return [self cycleFindMainVC:rootVC] ;
    }
    
    if (rootVC.childViewControllers.count > 0) {
        rootVC = [rootVC.childViewControllers lastObject] ;
        return [self cycleFindMainVC:rootVC] ;
    }
    
    return rootVC ;
    
}
@end
