//
//  NavigateManager.m
//  MVP
//
//  Created by sunnyvale on 15/12/8.
//  Copyright © 2015年 sunnyvale. All rights reserved.
//

#import "NavigateManager.h"

@implementation NavigateManager

+ (UIViewController *)getCurrentViewController
{
    UINavigationController *currentNavigateController = nil;
    UIViewController *viewController  = [[[UIApplication sharedApplication].delegate window] rootViewController];
    if (![viewController isKindOfClass:[UINavigationController class]]) {
        return nil;
    }
    
    currentNavigateController = (UINavigationController *)viewController;
    return [currentNavigateController visibleViewController];
}

+ (void)pushViewController:(__kindof UIViewController *)viewController
{
    UIViewController *curViewController = [self getCurrentViewController];
    [curViewController.navigationController pushViewController:viewController animated:YES];
}

+ (void)popViewController:(__kindof UIViewController *)viewController
{
    UIViewController *curViewController = [self getCurrentViewController];
    [curViewController.navigationController popToViewController:viewController animated:YES];
}
@end
