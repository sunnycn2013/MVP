//
//  TemplateFloorPicModel.h
//  MVP
//
//  Created by sunnyvale on 15/12/6.
//  Copyright © 2015年 sunnyvale. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TemplateJumpModel.h"
#import "TemplateShareModel.h"
#import "TemplateRenderProtocol.h"

@interface TemplatePicModel : NSObject<TemplateRenderProtocol>

@property (nonatomic,strong) NSString           *identityId;
@property (nonatomic,strong) NSString           *img;
@property (nonatomic,assign) BOOL               isShare;
@property (nonatomic,strong) TemplateJumpModel  *jump;
@property (nonatomic,strong) TemplateShareModel  *share;
@property (nonatomic,strong) NSNumber           *height;
@property (nonatomic,strong) NSNumber           *width;

@end
