//
//  TemplateNormalSubModel.h
//  MVP
//
//  Created by sunnyvale on 15/12/17.
//  Copyright © 2015年 sunnyvale. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TemplateRenderProtocol.h"
#import "TemplateValidationProtocol.h"

typedef NS_ENUM(NSInteger,TemplateNormalStyle)
{
    TemplateNormalStyle001 = 1,
    TemplateNormalStyle002,
    TemplateNormalStyle003,
    TemplateNormalStyle004,
    TemplateNormalStyle005,
    TemplateNormalStyle006,
    TemplateNormalStyle007,
    TemplateNormalStyle008,
    TemplateNormalStyle009,
};

@interface TemplateNormalSubModel : NSObject<TemplateRenderProtocol,TemplateValidationProtocol>
@property (nonatomic,strong) NSString * pattern;
@property (nonatomic,strong) NSArray  * picList;
@property (nonatomic,strong) NSNumber * identityId;
@end
