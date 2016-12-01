//
//  DDNavigationController.m
//  structure
//
//  Created by ZhangXiaodong on 16/11/6.
//  Copyright © 2016年 ZhangXiaodong. All rights reserved.
//

#import "DDNavigationController.h"

@interface DDNavigationController ()

@end

@implementation DDNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationBar.barTintColor = [UIColor redColor]  ;
    
//    [self.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault] ;
    
    
    self.navigationBar.tintColor = [UIColor whiteColor] ;
    
    self.navigationBar.titleTextAttributes = @{
                                               NSForegroundColorAttributeName: [UIColor greenColor]
                                               } ;
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES ;
    }
    [super pushViewController:viewController animated:animated] ;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    NSLog(@"navigationController---.%s",__func__) ;
}
@end
