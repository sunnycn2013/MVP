//
//  TemplateJumpAction.h
//  MVP
//
//  Created by sunnyvale on 15/12/19.
//  Copyright © 2015年 sunnyvale. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TemplateAction.h"

extern NSString *const TemplateJumpToProductDetail;
extern NSString *const TemplateJumpToActivityM;

@interface TemplateJumpAction : TemplateAction

@property (nonatomic,strong) NSString *jumpToType;
@property (nonatomic,strong) NSString *jumpToUrl;

@end
