//
//  TemplateFloorNormalModel.m
//  MVP
//
//  Created by sunnyvale on 15/12/6.
//  Copyright © 2015年 sunnyvale. All rights reserved.
//

#import "TemplateNormalModel.h"
#import "TemplateNormalSubModel.h"

@implementation TemplateNormalModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"itemList" : @"hybridList"
             };
}

+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"itemList" : @"TemplateNormalSubModel"
             };
}

- (void)mj_keyValuesDidFinishConvertingToObject
{
    [super mj_keyValuesDidFinishConvertingToObject];
    
    NSMutableArray *array = [NSMutableArray array];
    for (TemplateNormalSubModel * obj in self.itemList) {
        if (obj.isValid) {
            [array addObject:obj];
        }
    }
    self.itemList = array;
}

#pragma mark - TemplateContainerProtocol

- (NSInteger)numberOfChildModelsInContainer
{
    NSUInteger rows = 1;
//    if (self.fheader.isValid) rows ++;
    if (self.itemList.count) rows += self.itemList.count;
    if (self.margin) rows++;
    return rows;
}

- (id <TemplateRenderProtocol>)childFloorModelAtIndex:(NSInteger)index
{
    if (self.fheader && (index == 0)) return self.fheader;
    
    if ((index > 0) && self.itemList.count > (index-1))
        return self.itemList[index - 1];
    
    if ((self.margin)&&(index+1) == [self numberOfChildModelsInContainer])
        return self.margin;  //最后一行
    return nil;
}

@end
