//
//  TemplateFloorMarginModel.h
//  MVP
//
//  Created by sunnyvale on 15/12/6.
//  Copyright © 2015年 sunnyvale. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TemplateRenderProtocol.h"

@interface TemplateMarginModel : NSObject<TemplateRenderProtocol>
@property (nonatomic,strong) NSNumber *height;
@end
