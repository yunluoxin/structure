//
//  PersonInfomationViewController.m
//  structure
//
//  Created by ZhangXiaodong on 16/11/6.
//  Copyright © 2016年 ZhangXiaodong. All rights reserved.
//

#import "PersonInfomationViewController.h"

@interface PersonInfomationViewController ()

@end

@implementation PersonInfomationViewController

+ (void)load
{
    [UrlRounter registerController:self withMappingUrl:@"info" ];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"个人信息" ;
    
    self.view.backgroundColor = [UIColor whiteColor] ;
    
    self.tabBarItem.badgeValue =  @"1" ;
    
    
    NSLog(@"name-------->%@",self.name) ;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated] ;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault ;
    [UIApplication sharedApplication].statusBarHidden = YES ;
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated] ;

}

- (void)viewWillDisappear:(BOOL)animated
{
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent ;
    [UIApplication sharedApplication].statusBarHidden = NO ;
    [super viewWillDisappear:animated] ;
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [[NSNotificationCenter defaultCenter ]postNotificationName:@"DDNotLoginNotification" object:nil] ;

    
//    NSLog(@"%@",[self cycleFindMainVC:[UIApplication sharedApplication].keyWindow.rootViewController]) ;
}

//+ (NSDictionary *)dd_replaceKeyFromPropertyName
//{
//    return @{
//             @"ad":@"name"
//             };
//}
@end
