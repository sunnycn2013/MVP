//
//  TemplateFHeaderModel.m
//  MVP
//
//  Created by sunnyvale on 15/12/11.
//  Copyright © 2015年 sunnyvale. All rights reserved.
//

#import "TemplateFHeaderModel.h"

@implementation TemplateFHeaderModel

- (BOOL)isValid
{
    return (self.lctitleImg.length > 0);
}

- (NSString *)floorIdentifier
{
    return @"TemplateHeaderCell";
}
@end
