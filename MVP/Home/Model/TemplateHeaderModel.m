//
//  TemplateHeaderModel.m
//  MVP
//
//  Created by sunnyvale on 15/12/6.
//  Copyright © 2015年 sunnyvale. All rights reserved.
//

#import "TemplateHeaderModel.h"

@implementation TemplateHeaderModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"headID" : @"id"
             };
}

@end
