//
//  TemplateNormalTapView.h
//  MVP
//
//  Created by sunnyvale on 15/12/17.
//  Copyright © 2015年 sunnyvale. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TemplateCellProtocol.h"

@interface TemplateNormalTapView : UIImageView<TemplateCellProtocol>

@property (nonatomic,copy) void (^tapBlock)(void);

@end
