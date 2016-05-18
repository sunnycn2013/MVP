//
//  TemplateFloorContainerModel.m
//  MVP
//
//  Created by sunnyvale on 15/12/6.
//  Copyright © 2015年 sunnyvale. All rights reserved.
//

#import "TemplateContainerModel.h"

@implementation TemplateContainerModel

- (void)mj_keyValuesDidFinishConvertingToObject {
    if (self.fheader.isValid == NO) {
        self.fheader = nil;
    }
}

#pragma mark - TemplateContainerProtocol

- (NSInteger)numberOfChildModelsInContainer
{
    return [self.itemList count];
}

- (id <TemplateRenderProtocol>)childFloorModelAtIndex:(NSInteger)index
{
    return nil;
}

#pragma mark - TemplateActionProtocol

- (TemplateAction *)jumpFloorModelAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

#pragma mark -  TemplateRenderProtocol
- (NSString *)floorIdentifier
{
    return nil;
}

@end
