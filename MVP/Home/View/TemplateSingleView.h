//
//  TemplateSingleView.h
//  MVP
//
//  Created by sunnyvale on 15/12/8.
//  Copyright © 2015年 sunnyvale. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TemplateCellProtocol.h"
#import <iCarousel/iCarousel.h>

@interface TemplateSingleView : UIView<TemplateCellProtocol>
@property (nonatomic,copy)TapBlock tapBlock;
@end
