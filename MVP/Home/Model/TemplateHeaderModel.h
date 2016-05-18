//
//  TemplateHeaderModel.h
//  MVP
//
//  Created by sunnyvale on 15/12/6.
//  Copyright © 2015年 sunnyvale. All rights reserved.
//

#import <Foundation/Foundation.h>

//整个频道页面header Model
@interface TemplateHeaderModel : NSObject

@property (nonatomic,strong) NSNumber *headID;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *titleImg;
@property (nonatomic,assign) BOOL     isShare;
@property (nonatomic,strong) NSNumber *withCart;
@property (nonatomic,strong) NSString *cartSrv;

@end
