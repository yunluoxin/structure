//
//  UrlRounter.h
//  kachemama
//
//  Created by dadong on 16/12/3.
//  Copyright © 2016年 dadong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UrlRounter : NSObject

+ (void)openUrl:(NSString * )url ;

+ (void)registerController:(Class)viewController withMappingUrl:(NSString *)mappingUrl ;
@end
