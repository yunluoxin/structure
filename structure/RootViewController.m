//
//  RootViewController.m
//  structure
//
//  Created by ZhangXiaodong on 16/11/6.
//  Copyright © 2016年 ZhangXiaodong. All rights reserved.
//

#import "RootViewController.h"
#import "DDTabbarController.h"

#import "DDNavigationController.h"
#import "SignInViewController.h"

#import "ADViewController.h"
#import "DDTaskManager.h"
#import "NewFeatureViewController.h"
@interface RootViewController ()
{
    NSDate * _lastTimeShow ;
}


@end

@implementation RootViewController

+ (instancetype)sharedViewController
{
    static id obj = nil ;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        obj = [RootViewController new] ;
        
        //注册APP进入"后台"和"前台"的通知
        [[NSNotificationCenter defaultCenter] addObserver:obj selector:@selector(active:) name:UIApplicationDidBecomeActiveNotification object:nil] ;
        [[NSNotificationCenter defaultCenter] addObserver:obj selector:@selector(resignActive:) name:UIApplicationWillResignActiveNotification object:nil] ;
    
    });
    return obj ;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent ;

    self.view.backgroundColor = [UIColor lightGrayColor] ;
    [self.navigationController setNavigationBarHidden:YES] ;
    
    DDTabbarController * tabbarVC = [DDTabbarController new] ;
    [self addChildViewController:tabbarVC] ;
    [self.view addSubview:tabbarVC.view] ;
    self.tabbarVC = tabbarVC ;
    
    [self registerAllNotifications] ;
    
}

- (void)registerAllNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(network_break) name:DDNotLoginNotification object:nil] ;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkLogin:) name:DDCheckLoginNotification object:nil] ;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkUpdate:) name:DDCheckUpdateNotification object:nil] ;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated] ;
//    NSLog(@"%s",__func__) ;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated] ;
    
}


#pragma mark - 监听通知

- (void)active:(NSNotification *)note
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSString * currentVersion = [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"] ;
        NSString * lastVersionKey = @"lastVersionKey" ;
        NSString * lastValue = [[NSUserDefaults standardUserDefaults] stringForKey:lastVersionKey] ;
        if ([currentVersion isEqualToString:lastValue]) {
            
            
            //刚登录APP 或者 离上一次使用APP超时了，就出现广告
            if (!_lastTimeShow || [[NSDate date] timeIntervalSinceDate:_lastTimeShow] > 8 ) {
                //            [self presentViewController:[ADViewController new] animated:NO completion:NULL] ;
                UIViewController * vc = [ADViewController new] ;
                [self addChildViewController:vc] ;
                [self.view addSubview:vc.view] ;
            }else{
                [DDTaskManager executeAllTasks] ;
            }
            
        }else{
            
            //存储版本
            [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:lastVersionKey] ;
            
            UIViewController * vc = [NewFeatureViewController new] ;
            [self addChildViewController:vc] ;
            [self.view addSubview:vc.view] ;
            
        }

        
    });
}

- (void)resignActive:(NSNotification *)note
{
    _lastTimeShow = [NSDate date] ;
}

#pragma mark 检测登录
- (void)checkLogin:(NSNotification *)note
{
    SignInViewController * vc = [SignInViewController new] ;
    DDNavigationController * nav = [[DDNavigationController alloc]initWithRootViewController:vc] ;
    [self presentViewController:nav animated:NO completion:nil] ;
}

#pragma mark 检测是否有更新
- (void)checkUpdate:(NSNotification *)note
{
    UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"当前有新版本" delegate:self cancelButtonTitle:@"好的" otherButtonTitles:@"buzhid00", nil] ;
    [alertView show] ;
}

- (void)network_break
{
    UIView * view = [UIView new] ;
    view.frame = CGRectMake(0, 0, 200, 200) ;
    view.center = self.view.center ;
    view.backgroundColor = [UIColor greenColor] ;
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(close:) ] ;
    [view addGestureRecognizer:tapGesture] ;
    [self.view addSubview:view] ;
}

- (void)close:(UITapGestureRecognizer *)tap
{
    [tap.view removeFromSuperview] ;
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self] ;
}

@end

NSString * const DDNotLoginNotification = @"DDNotLoginNotification" ;
NSString * const DDCheckLoginNotification = @"DDCheckLoginNotification" ;
NSString * const DDCheckUpdateNotification = @"DDCheckUpdateNotification" ;
