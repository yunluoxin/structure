//
//  DDTabbarController.m
//  structure
//
//  Created by ZhangXiaodong on 16/11/6.
//  Copyright © 2016年 ZhangXiaodong. All rights reserved.
//

#import "DDTabbarController.h"
#import "DDNavigationController.h"
#import "MyHomeViewController.h"
#import "HomePageViewController.h"


@interface DDTabbarController ()

@end

@implementation DDTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor] ;

    [self initViewControllers] ;
    
}


- (void)initViewControllers
{
    MyHomeViewController * myHome = [MyHomeViewController new] ;
    DDNavigationController *  nav = [[DDNavigationController alloc] initWithRootViewController:myHome] ;
    HomePageViewController * homePage = [HomePageViewController new] ;
    DDNavigationController *  nav2 = [[DDNavigationController alloc] initWithRootViewController:homePage] ;
    self.viewControllers = @[nav, nav2] ;
}

- (void)viewDidDisappear:(BOOL)animated
{
    NSLog(@"viewDidDisappear--%@",self.presentedViewController) ;
    [super viewDidDisappear:animated] ;
}
@end
