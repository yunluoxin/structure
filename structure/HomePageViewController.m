//
//  HomePageViewController.m
//  structure
//
//  Created by ZhangXiaodong on 16/11/6.
//  Copyright © 2016年 ZhangXiaodong. All rights reserved.
//

#import "HomePageViewController.h"
#import "PersonInfomationViewController.h"

@interface HomePageViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView * tableView ;

@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"主页" ;
//    self.automaticallyAdjustsScrollViewInsets = NO ;
    self.view.backgroundColor = [UIColor purpleColor] ;
    
    [self.view addSubview:self.tableView] ;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated] ;
    NSLog(@"%@",NSStringFromUIEdgeInsets(self.tableView.contentInset)) ;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1 ;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100 ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * ID = @"asdfsdaf" ;
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID] ;
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID] ;
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%ld--%ld",indexPath.section,indexPath.row] ;
    
    return cell ;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.navigationController pushViewController:[PersonInfomationViewController new] animated:YES] ;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"offset--->%@",NSStringFromCGPoint(scrollView.contentOffset)) ;
    NSLog(@"edgeInset--->%@",NSStringFromUIEdgeInsets(scrollView.contentInset)) ;
    NSLog(@"indicatorEdgeInset--->%@",NSStringFromUIEdgeInsets(scrollView.scrollIndicatorInsets)) ;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain] ;
        _tableView.delegate = self ;
        _tableView.dataSource = self ;
        _tableView.rowHeight = 100 ;
    }
    return _tableView ;
}

@end
