//
//  UrlRounter.m
//  kachemama
//
//  Created by dadong on 16/12/3.
//  Copyright © 2016年 dadong. All rights reserved.
//

#import "UrlRounter.h"
#import "RootViewController.h"
NSString * const kUrlRounterScheme =    @"kachemama"   ;
NSString * const kUrlHostActivity  =    @"act"         ;
NSString * const kUrlHostDetail    =    @"detail"      ;

@interface UrlRounter ()

@property (nonatomic, strong) NSMutableDictionary * urlMappings ;

@end

@implementation UrlRounter

+ (instancetype)rounter
{
    static UrlRounter * rounter ;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        rounter = [[self alloc]init] ;
        rounter.urlMappings = @{}.mutableCopy ;
    });
    return rounter ;
}

+ (void)openUrl:(NSString *)urlString
{
    if (!urlString) {
        return ;
    }
    
    NSURL * url = [NSURL URLWithString:urlString] ;
    NSString * scheme = url.scheme ;
    NSString * host = url.host ;
    NSString * params = url.query ;
    
    if ([kUrlRounterScheme isEqualToString:scheme]) {
        
        NSString * mappingUrl = url.host ;
        NSString * className = [UrlRounter rounter].urlMappings[mappingUrl] ;
        if (className) {
            Class clazz = NSClassFromString(className) ;
            if (clazz && [clazz isSubclassOfClass:[UIViewController class]]) {
                UIViewController * class_vc = (UIViewController *)clazz ;
                UIViewController * viewController = [clazz new] ;
                
                //injected the viewcontroller's property values by params
                if ([class_vc respondsToSelector:@selector(dd_replaceKeyFromPropertyName)]) {
                    NSDictionary * replaces = [class_vc performSelector:@selector(dd_replaceKeyFromPropertyName)] ;
                    NSMutableDictionary * dicM = [self convertParamsToMap:params].mutableCopy ;
                    for (NSString * originKey in replaces) {
                        
                        if ([dicM.allKeys containsObject:originKey]) {
                            //replace the key from network with local property name
                            dicM[replaces[originKey]] = dicM[originKey] ;
                            
                            //remove the property name from network, this step can be ignored
                            [dicM removeObjectForKey:originKey] ;
                        }
                    }
                    [viewController setValuesForKeysWithDictionary:dicM] ;
                }
                
                [self dd_showViewController:viewController] ;
                return ;
            }
        }
        
    }
    
    //错误的page
    [self openUrl:@"kachemama://error"] ;
    return ;
}


+ (void)dd_showViewController:(UIViewController *)viewController
{
    UIViewController *rootVC = [[RootViewController sharedViewController].childViewControllers firstObject] ;
    if (rootVC.presentedViewController) {
        UIViewController * temp = rootVC.presentedViewController ;
        if ([temp isKindOfClass:[UINavigationController class]]) {
            UINavigationController * nav = (UINavigationController *)temp ;
            [nav pushViewController:viewController animated:YES] ;
        }else{
            [temp presentViewController:viewController animated:YES completion:nil] ;
        }
    }else{
        UINavigationController * nav ;
        if ([rootVC isKindOfClass:[UITabBarController class]]) {
            UITabBarController *tabVC = (UITabBarController *)rootVC ;
            rootVC = tabVC.selectedViewController ;
        }
        
        if ([rootVC isKindOfClass:[UINavigationController class]]){
            nav = (UINavigationController *)rootVC ;
        }
        
        if (nav) {
            [nav pushViewController:viewController animated:YES] ;
        }else{
            [rootVC presentViewController:viewController animated:YES completion:nil] ;
        }
    }
}


/**
    将参数串转换成map
    @param params 参数串，如a=b&c=d&e=f
    @return 字典
 */
+ (NSDictionary *)convertParamsToMap:(NSString *)params
{
    if (params == nil) {
        return nil ;
    }
    
    NSMutableDictionary * dicM = @{}.mutableCopy ;
    NSArray * array = [params componentsSeparatedByString:@"&"] ;
    for (NSString * entry in array) {
        NSArray * temp = [entry componentsSeparatedByString:@"="] ;
        if (temp.count < 2) {
            continue ;
        }
        dicM[temp[0]] = temp[1] ;
    }
    
    return dicM.copy ;
}

+ (void)registerController:(Class)viewController withMappingUrl:(NSString *)mappingUrl
{
    if (viewController == nil || !mappingUrl) {
        @throw [NSException exceptionWithName:@"RegisterControllerError" reason:@"注册urlMapping出错" userInfo:nil] ;
        return ;
    }
    
    NSString * className = NSStringFromClass(viewController) ;
    NSLog(@"%@",className) ;
    
    //use custom mapping url for key, and class name of ViewController for value, make a inter map which can't be updated outside.
    [[UrlRounter rounter].urlMappings setObject:className forKey:mappingUrl] ;
}

@end
