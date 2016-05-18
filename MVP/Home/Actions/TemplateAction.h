//
//  TemplateAction.h
//  MVP
//
//  Created by sunnyvale on 15/12/18.
//  Copyright © 2015年 sunnyvale. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,TemplateActionType)
{
    TemplateActionJump = 1,
    TemplateActionReloadData,
    TemplateActionAddCart,
    TemplateActionShare,
};

@class TemplateJumpModel;

@interface TemplateAction : NSObject

@property (nonatomic,copy)  NSString *actionID;
@property (nonatomic,assign)TemplateActionType actionType;
@property (nonatomic,    )  SEL      actionSelector;
@property (nonatomic,copy)  NSString *actionClass;
@property (nonatomic,copy)  NSDictionary *actionParams;
//MTA
@property (nonatomic, copy) NSString *eventId;
@property (nonatomic, copy) NSString *pageName;
@property (nonatomic, copy) NSString *pageParam;

- (instancetype)initWithJumpModel:(TemplateJumpModel *)jumpModel;
- (void)performTaskWithCompletionBlock:(void(^)(void))completion;
@end
