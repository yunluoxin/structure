//
//  MyHomeViewController.m
//  structure
//
//  Created by ZhangXiaodong on 16/11/6.
//  Copyright © 2016年 ZhangXiaodong. All rights reserved.
//

#import "MyHomeViewController.h"

@interface MyHomeViewController ()

@end

@implementation MyHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"个人中心" ;
    NSLog(@"个人中心") ;
    self.view.backgroundColor = [UIColor greenColor] ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
