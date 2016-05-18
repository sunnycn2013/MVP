//
//  TemplateContainerModel.h
//  MVP
//
//  Created by sunnyvale on 15/12/6.
//  Copyright © 2015年 sunnyvale. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TemplateFHeaderModel.h"
#import "TemplateMarginModel.h"
#import "TemplateActionProtocol.h"

/**
 *  容器概念
 */
@protocol TemplateContainerProtocol <NSObject>

@required

- (NSInteger)numberOfChildModelsInContainer;

- (id <TemplateRenderProtocol>)childFloorModelAtIndex:(NSInteger)index;

@end

@class TemplateChannelModel;
@interface TemplateContainerModel : NSObject<TemplateContainerProtocol,TemplateActionProtocol,TemplateRenderProtocol>

//netList
@property (nonatomic,strong) NSNumber                 *identityId;
@property (nonatomic,strong) NSString                 *pattern;
@property (nonatomic,strong) TemplateFHeaderModel     *fheader;
@property (nonatomic,strong) NSArray                  *itemList;
@property (nonatomic,strong) TemplateJumpModel        *jump;
@property (nonatomic,strong) TemplateMarginModel      *margin;
//other add
@property (nonatomic,assign) TemplateChannelModel     *channelModel;
@end
