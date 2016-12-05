//
//  DDNotifications.h
//  structure
//
//  Created by dadong on 16/12/2.
//  Copyright © 2016年 ZhangXiaodong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDNotifications : NSObject

@end

FOUNDATION_EXPORT NSString * const DDNotLoginNotification ;
FOUNDATION_EXPORT NSString * const DDCheckLoginNotification ;
FOUNDATION_EXPORT NSString * const DDCheckUpdateNotification ;

extern NSString * const DDLogOutNotification ;
extern NSString * const DDKickOutNotification ;

extern NSString * const DDNetworkBrokenNotification ;
