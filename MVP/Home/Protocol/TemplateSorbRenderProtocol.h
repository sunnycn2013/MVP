//
//  TemplateSpecialRenderProtocol.h
//  MVP
//
//  Created by sunnyvale on 15/12/13.
//  Copyright © 2015年 sunnyvale. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TemplateRenderProtocol.h"

@protocol TemplateSorbRenderProtocol <NSObject>

- (NSString *)headerFloorIdentifier;
- (id <TemplateSorbRenderProtocol>)headerFloorModelAtIndex:(NSInteger)index;

@end
