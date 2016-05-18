//
//  TemplateCategoryModel.m
//  MVP
//
//  Created by sunnyvale on 15/12/12.
//  Copyright © 2015年 sunnyvale. All rights reserved.
//

#import "TemplateCategoryModel.h"

@implementation TemplateCategoryModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"itemList" : @"categoryList"
             };
}

+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"itemList" : @"TemplateCategoryItemModel"
             };
}

#pragma mark - TemplateContainerProtocol

- (NSInteger)numberOfChildModelsInContainer
{
    NSUInteger rows = 0;
    if (self.margin) rows++;
    if (self.itemList) rows+=self.itemList.count;
//    return rows;
    return 20;
}

- (id <TemplateRenderProtocol>)childFloorModelAtIndex:(NSInteger)index
{
//    if ((self.margin)&&(index+1) == [self numberOfChildModelsInContainer])
//        return self.margin;  //最后一行
    return self;
}

#pragma mark - TemplateActionProtocol

- (TemplateAction *)jumpFloorModelAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

#pragma mark -  TemplateRenderProtocol
- (NSString *)floorIdentifier
{
    return @"TemplateCategoryCell";
}

- (NSString *)headerFloorIdentifier
{
    return @"TemplateCategoryHeaderCell";
}

- (id <TemplateSorbRenderProtocol>)headerFloorModelAtIndex:(NSInteger)index
{
    return self;
}


@end
