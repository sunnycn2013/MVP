//
//  ViewController+Template.m
//  MVP
//
//  Created by sunnyvale on 15/12/20.
//  Copyright © 2015年 sunnyvale. All rights reserved.
//

#import "ViewController+Template.h"

@implementation UIViewController (Template)

- (void)addShareBarButtonItemWihtModel:(NSObject *)model
{
    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareButton setFrame:CGRectMake(0, 0, 45, 35)];
    [shareButton setTitle:@"分享" forState:UIControlStateNormal];
    [shareButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:shareButton];
    self.navigationItem.rightBarButtonItem = barButtonItem;
}

@end
