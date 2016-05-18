//
//  TemplateFloorFocusModel.m
//  MVP
//
//  Created by sunnyvale on 15/12/6.
//  Copyright © 2015年 sunnyvale. All rights reserved.
//

#import "TemplateFloorFocusModel.h"
#import "TemplatePicModel.h"
#import "TemplateJumpAction.h"

@implementation TemplateFloorFocusModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"itemList" : @"picList"
             };
}

+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"itemList" : @"TemplatePicModel"
             };
}

#pragma mark - TemplateContainerProtocol

- (NSInteger)numberOfChildModelsInContainer
{
    NSUInteger rows = 0;
    if (self.margin) rows++;
    if (self.itemList) rows++;
    return rows;
}

- (id <TemplateRenderProtocol>)childFloorModelAtIndex:(NSInteger)index
{
    if ((self.margin)&&(index+1) == [self numberOfChildModelsInContainer])
        return self.margin;  //最后一行
    return self;
}

#pragma mark - TemplateActionProtocol

- (TemplateAction *)jumpFloorModelAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger position = [indexPath indexAtPosition:0];
    if (position < self.itemList.count) {
        
        TemplatePicModel *picModel = self.itemList[position];
        TemplateJumpAction *action = [[TemplateJumpAction alloc] init];
        action.jumpToType = TemplateJumpToActivityM;
        action.jumpToUrl = picModel.jump.url;
        action.eventId = @"GeneralChannel_BannerPic";
        return action;
    }
    return nil;
}

#pragma mark -  TemplateRenderProtocol
- (NSString *)floorIdentifier
{
    return @"TemplateFocusCell";
}

@end
