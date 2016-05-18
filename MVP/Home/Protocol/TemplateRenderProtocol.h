//
//  TemplateRenderProtocol.h
//  MVP
//
//  Created by sunnyvale on 15/12/12.
//  Copyright © 2015年 sunnyvale. All rights reserved.
//
#import "TemplateActionProtocol.h"

@protocol TemplateRenderProtocol <NSObject,TemplateActionProtocol>

@required
- (NSString *)floorIdentifier;

@end
