//
//  UIView+Template.m
//  MVP
//
//  Created by sunnyvale on 15/12/18.
//  Copyright © 2015年 sunnyvale. All rights reserved.
//

#import "UIView+Template.h"

@implementation UIView (Template)
- (void)setCenterX:(CGFloat)x
{
    CGFloat y = self.center.y;
    CGPoint point = CGPointMake(x, y);
    self.center = point;
}

- (void)setCenterY:(CGFloat)y
{
    CGFloat x = self.center.x;
    CGPoint point = CGPointMake(x, y);
    self.center = point;
}
@end
