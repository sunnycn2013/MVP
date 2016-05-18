//
//  TemplateFloorFocusModel.h
//  MVP
//
//  Created by sunnyvale on 15/12/6.
//  Copyright © 2015年 sunnyvale. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TemplateContainerModel.h"

@interface TemplateFloorFocusModel : TemplateContainerModel<TemplateRenderProtocol>

@property (nonatomic,assign) NSNumber *width;
@property (nonatomic,assign) NSNumber *height;

@end
