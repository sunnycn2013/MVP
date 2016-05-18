//
//  UIButton+Action.h
//  MVP
//
//  Created by sunnyvale on 15/12/20.
//  Copyright © 2015年 sunnyvale. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIButton (Template)

- (void)tp_addActionsUsingBlock:(void(^)(void))actionBlock;

@end
