//
//  TemplateActionProtocol.h
//  MVP
//
//  Created by sunnyvale on 15/12/6.
//  Copyright © 2015年 sunnyvale. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TemplateAction.h"

@protocol TemplateActionProtocol <NSObject>

@optional

- (TemplateAction *)jumpFloorModelAtIndexPath:(NSIndexPath *)indexPath;

@end

