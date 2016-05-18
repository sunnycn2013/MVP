//
//  TemplateNormalView.h
//  MVP
//
//  Created by sunnyvale on 15/12/17.
//  Copyright © 2015年 sunnyvale. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TemplateCellProtocol.h"

@interface TemplateNormalView : UIView<TemplateCellProtocol>
@property (nonatomic,copy)TapBlock tapBlock;
@end
