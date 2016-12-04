//
//  SignInViewController.m
//  structure
//
//  Created by ZhangXiaodong on 16/11/6.
//  Copyright © 2016年 ZhangXiaodong. All rights reserved.
//

#import "SignInViewController.h"
#import "DDTaskManager.h"
@interface SignInViewController ()

@end

@implementation SignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"登录" ;
    
    self.view.backgroundColor = [ UIColor yellowColor] ;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStyleDone target:self action:@selector(close:)] ;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"登录" style:UIBarButtonItemStyleDone target:self action:@selector(signIn:)] ;
}

- (void)close:(id)sender
{
//    [self.navigationController.view removeFromSuperview] ;
//    [self.navigationController removeFromParentViewController] ;

    [self dismissViewControllerAnimated:NO completion:^{
        [DDTaskManager executeAllTasks] ;
    }] ;
}

- (void)signIn:(id)sender
{
    typeof(self) __weak wself = self ;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"%@",wself) ;
        [wself dismissViewControllerAnimated:YES completion:nil] ;
    });
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent ;
}

- (void)dealloc
{
    NSLog(@"%s",__func__) ;
}

@end
