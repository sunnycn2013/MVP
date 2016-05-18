//
//  UITableView+Template.m
//  MVP
//
//  Created by sunnyvale on 15/12/17.
//  Copyright © 2015年 sunnyvale. All rights reserved.
//

#import "UITableView+Template.h"
#import "TemplateCellProtocol.h"

@implementation UITableView (Template)

- (void)registTableViewCell
{
    NSArray *cellIdentifier = @[
                       @"TemplateFocusCell",
                       @"TemplateSingleCell",
                       @"TemplateHeaderCell",
                       @"TemplateCategoryCell",
                       @"TemplateMarginCell",
                       @"TemplateNormalCell"
                       ];
    
    for (NSString * cell in cellIdentifier) {
        [self registerClass:NSClassFromString(cell) forCellReuseIdentifier:cell];
    }
    
    NSArray *headerIdentifier = @[
                                  @"TemplateCategoryHeaderCell"
                                  ];
    
    for (NSString * cell in headerIdentifier) {
        [self registerClass:NSClassFromString(cell) forHeaderFooterViewReuseIdentifier:cell];
    }

}

@end