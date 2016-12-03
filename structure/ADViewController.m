//
//  ADViewController.m
//  structure
//
//  Created by ZhangXiaodong on 16/11/8.
//  Copyright © 2016年 ZhangXiaodong. All rights reserved.
//

#import "ADViewController.h"
#import "DDTaskManager.h"
@interface ADViewController ()
{
    NSTimer *_timer ;
    
    //状态栏原始状态
    BOOL statusBarOriginStatus ;
}

//计数的label
@property (nonatomic, strong) UILabel * countLabel ;

@end

@implementation ADViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel * label = [[UILabel alloc] initWithFrame:self.view.bounds] ;
    label.backgroundColor = [UIColor blackColor] ;
    [self.view addSubview:label] ;
    label.text = @" 这是一个广告 " ;
    label.font = [UIFont systemFontOfSize:20] ;
    label.textColor = [UIColor greenColor] ;
    label.textAlignment = NSTextAlignmentCenter ;
    
    UIButton * stepBtn = [UIButton buttonWithType:UIButtonTypeCustom] ;
    stepBtn.frame = CGRectMake(0, 300, 100, 50) ;
    [stepBtn setTitle:@"跳过" forState:UIControlStateNormal] ;
    [stepBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal] ;
    [stepBtn addTarget:self action:@selector(step:) forControlEvents:UIControlEventTouchUpInside] ;
    [self.view addSubview:stepBtn] ;
    
    
    self.countLabel.text = [NSString stringWithFormat:@"%d",count] ;
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countTime) userInfo:nil repeats:YES] ;
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

static int count = 3 ;      //倒计时3s

- (void)countTime
{
    count -- ;
    
    self.countLabel.text = [NSString stringWithFormat:@"%d",count] ;
    
    if (count <= 0) {
        [self step:nil] ;
    }
    
    
    
}

- (void)step:(id)sender
{
    [_timer invalidate] ;
    _timer = nil ;
    count = 3 ;
    [self dismissViewControllerAnimated:NO completion:^{
        [DDTaskManager executeAllTasks] ;
    }] ;
}



- (UILabel *)countLabel
{
    if (!_countLabel) {
        _countLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 50 , 100 , 25, 25)] ;
        _countLabel.textAlignment = NSTextAlignmentCenter ;
        _countLabel.textColor = [UIColor blueColor] ;
        _countLabel.font = [UIFont systemFontOfSize:18] ;
        _countLabel.layer.cornerRadius = 3 ;
        _countLabel.layer.borderColor = [UIColor redColor].CGColor ;
        _countLabel.layer.borderWidth = 1 ;
        [self.view addSubview:_countLabel] ;
    }
    return _countLabel ;
}
@end
