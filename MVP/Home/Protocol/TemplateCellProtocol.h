//
//  TemplateCellProtocol.h
//  MVP
//
//  Created by sunnyvale on 15/12/6.
//  Copyright © 2015年 sunnyvale. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TemplateRenderProtocol.h"

@protocol TemplateBaseProtocol;

typedef void (^TapBlock) (NSIndexPath* index);

@protocol TemplateCellProtocol <NSObject>

@optional
+ (CGSize)calculateSizeWithData:(id<TemplateRenderProtocol>)data constrainedToSize:(CGSize)size;

- (void)processData:(id <TemplateRenderProtocol>)data;

- (void)tapOnePlace:(TapBlock) block;

@end
