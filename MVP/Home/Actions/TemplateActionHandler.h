//
//  TemplateActionHandler.h
//  MVP
//
//  Created by sunnyvale on 15/12/18.
//  Copyright © 2015年 sunnyvale. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TemplateAction;
@class TemplateActionHandler;
@protocol TemplateActionHandlerDelegate <NSObject>

@optional
- (void)actionHandler:(TemplateActionHandler *)handler willHandlerAction:(TemplateAction *)action;
- (void)actionHandler:(TemplateActionHandler *)handler didHandlerAction:(TemplateAction *)action;

@end

@interface TemplateActionHandler : NSObject

@property (nonatomic,strong,readonly) TemplateAction *action;
//拦截器
//Result

@property (nonatomic,assign) id<TemplateActionHandlerDelegate> delegate;

- (BOOL)handlerAction:(TemplateAction *)action;

@end
