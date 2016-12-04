//
//  NewFeatureViewController.m
//  structure
//
//  Created by dadong on 16/12/1.
//  Copyright © 2016年 ZhangXiaodong. All rights reserved.
//

#import "NewFeatureViewController.h"

@interface NewFeatureViewController ()

@end

@implementation NewFeatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [UIApplication sharedApplication].statusBarHidden = YES ;
    self.view.backgroundColor = [UIColor whiteColor] ;
    
    UILabel * label = [[UILabel alloc] initWithFrame:self.view.bounds] ;
    label.backgroundColor = [UIColor blackColor] ;
    [self.view addSubview:label] ;
    label.text = @" 这是新特性页面 " ;
    label.font = [UIFont systemFontOfSize:20] ;
    label.textColor = [UIColor greenColor] ;
    label.textAlignment = NSTextAlignmentCenter ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self removeFromParentViewController] ;
    [self.view removeFromSuperview] ;
}
@end
