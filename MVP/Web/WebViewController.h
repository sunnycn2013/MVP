//
//  WebViewController.h
//  MVP
//
//  Created by sunnyvale on 15/12/8.
//  Copyright © 2015年 sunnyvale. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController

@property (strong, nonatomic) UIWebView *webView;

- (instancetype)initWithUrl:(NSURL *)url;

@end
