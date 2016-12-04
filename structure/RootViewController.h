//
//  RootViewController.h
//  structure
//
//  Created by ZhangXiaodong on 16/11/6.
//  Copyright © 2016年 ZhangXiaodong. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "DDTabbarController.h"
@interface RootViewController : UIViewController
@property(nonatomic, weak) DDTabbarController * tabbarVC ;
+ (instancetype)sharedViewController ;

@end

FOUNDATION_EXPORT NSString * const DDNotLoginNotification ;
FOUNDATION_EXPORT NSString * const DDCheckLoginNotification ;
FOUNDATION_EXPORT NSString * const DDCheckUpdateNotification ;
