//
//  TemplateSkuModel.h
//  MVP
//
//  Created by sunnyvale on 15/12/8.
//  Copyright © 2015年 sunnyvale. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TemplateRenderProtocol.h"

@interface TemplateSkuModel : NSObject<TemplateRenderProtocol>

@property (nonatomic, strong) NSString *skuId;
@property (nonatomic, strong) NSString *img;
@property (nonatomic, strong) NSString *pprice;
@property (nonatomic, strong) NSString *wprice;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) BOOL top;
@property (nonatomic, assign) BOOL onSell;

@end
