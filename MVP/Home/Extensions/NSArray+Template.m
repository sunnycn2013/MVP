//
//  NSArray+Template.m
//  MVP
//
//  Created by sunnyvale on 15/12/18.
//  Copyright © 2015年 sunnyvale. All rights reserved.
//

#import "NSArray+Template.h"

@implementation NSArray (Template)

- (id)tp_firstObject
{
    return (self.count >= 1) ? self[0] : nil;
}

- (id)tp_secondObject
{
    return (self.count >= 2) ? self[1] : nil;
}

- (id)tp_thirdObject
{
    return (self.count >= 3) ? self[2] : nil;
}

- (id)tp_fourthObject
{
    return (self.count >= 4) ? self[3] : nil;
}

- (id)tp_fifthObject
{
    return (self.count >= 5) ? self[4] : nil;
}
@end
