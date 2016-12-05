//
//  NewFeatureViewController.m
//  structure
//
//  Created by dadong on 16/12/1.
//  Copyright © 2016年 ZhangXiaodong. All rights reserved.
//

#import "NewFeatureViewController.h"

@interface NewFeatureViewController ()
{
    //状态栏原始状态
    BOOL statusBarOriginStatus ;
}
@end

@implementation NewFeatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor] ;
    
    UILabel * label = [[UILabel alloc] initWithFrame:self.view.bounds] ;
    label.backgroundColor = [UIColor blackColor] ;
    [self.view addSubview:label] ;
    label.text = @" 这是新特性页面 " ;
    label.font = [UIFont systemFontOfSize:20] ;
    label.textColor = [UIColor greenColor] ;
    label.textAlignment = NSTextAlignmentCenter ;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated] ;
    statusBarOriginStatus = [UIApplication sharedApplication].isStatusBarHidden ;
    [UIApplication sharedApplication].statusBarHidden = YES ;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [UIApplication sharedApplication].statusBarHidden = statusBarOriginStatus ;
    [super viewWillDisappear:animated] ;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self removeFromParentViewController] ;
    [self.view removeFromSuperview] ;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:DDCheckLoginNotification object:nil] ;
}
@end
