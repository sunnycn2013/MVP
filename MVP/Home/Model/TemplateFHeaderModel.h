//
//  TemplateFHeaderModel.h
//  MVP
//
//  Created by sunnyvale on 15/12/11.
//  Copyright © 2015年 sunnyvale. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TemplateJumpModel.h"
#import "TemplateRenderProtocol.h"
#import "TemplateValidationProtocol.h"

@interface TemplateFHeaderModel : NSObject<TemplateRenderProtocol,TemplateValidationProtocol>

@property (nonatomic,strong) NSString           *lctitle;
@property (nonatomic,strong) NSString           *lctitleImg;
@property (nonatomic,strong) NSString           *rctitle;
@property (nonatomic,strong) TemplateJumpModel  *jump;

@end
