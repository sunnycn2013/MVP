//
//  TemplateBaseModel.m
//  MVP
//
//  Created by sunnyvale on 15/12/6.
//  Copyright © 2015年 sunnyvale. All rights reserved.
//

#import "TemplateChannelModel.h"
#import "TemplateContainerModel.h"
#import "TemplateFloorFocusModel.h"


#import "TemplateNormalModel.h"

NSString *const TemplateChannelPatternFocus          = @"Focus";
NSString *const TemplateChannelPatternSingle         = @"SingleGoods";
NSString *const TemplateChannelPatternNormal         = @"NormalFloor";

NSString *const TemplateChannelPatternCategory       = @"Category";


@implementation TemplateChannelModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"tempFloors" : @"floors"
             };
}

- (void)mj_keyValuesDidFinishConvertingToObject
{
    NSMutableArray * modelArray = [NSMutableArray array];
    for (NSDictionary *floorDict in self.tempFloors) {
        NSString* modelType = [self getModelWithPattern:floorDict[@"pattern"]];
        if (modelType)
        {
            Class aclass = NSClassFromString(modelType);
            if (aclass)
            {
                TemplateContainerModel *floorModel = [aclass mj_objectWithKeyValues:floorDict];
                floorModel.channelModel = self;
                if (floorModel) {
                    [modelArray addObject:floorModel];
                }
            }
        }
    }
        
    self.tempFloors = nil;
    self.floors = modelArray;
}

- (id <TemplateRenderProtocol>)rowModelAtIndexPath:(NSIndexPath *)indexPath
{
    TemplateContainerModel *floorModel = [self.floors objectAtIndex:indexPath.section];
    id<TemplateRenderProtocol> rowModel = [floorModel childFloorModelAtIndex:indexPath.row];
    return rowModel;
}

- (NSString *)getModelWithPattern:(NSString *)pattern
{
    if ([pattern isEqualToString:TemplateChannelPatternFocus]) {
        return @"TemplateFloorFocusModel";
    }
    if ([pattern isEqualToString:TemplateChannelPatternNormal]) {
        return @"TemplateNormalModel";
    }
    if ([pattern isEqualToString:TemplateChannelPatternSingle]) {
        return @"TemplateSingleModel";
    }
    if ([pattern isEqualToString:TemplateChannelPatternCategory]) {
        return @"TemplateCategoryModel";
    }
    
    return nil;
}
@end

