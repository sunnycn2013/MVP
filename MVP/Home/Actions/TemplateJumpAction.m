//
//  TemplateJumpAction.m
//  MVP
//
//  Created by sunnyvale on 15/12/19.
//  Copyright © 2015年 sunnyvale. All rights reserved.
//

#import "TemplateJumpAction.h"
#import "WebViewController.h"

NSString * const TemplateJumpToProductDetail = @"ProductDetail";
NSString * const TemplateJumpToActivityM     = @"m";

@implementation TemplateJumpAction

- (void)performTaskWithCompletionBlock:(void(^)(void))completion
{
    if ([self.jumpToType isEqualToString:TemplateJumpToActivityM]) {
        WebViewController *webViewController = [[WebViewController alloc] init];
        [NavigateManager pushViewController:webViewController];
    }
}
@end
