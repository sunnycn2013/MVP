//
//  TemplateCategorySubItemModel.h
//  MVP
//
//  Created by sunnyvale on 15/12/12.
//  Copyright © 2015年 sunnyvale. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TemplateCategorySubItemModel : NSObject

@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSNumber *type;
@property (nonatomic,strong) NSString *functionId;
@property (nonatomic,strong) NSNumber *businessType;
@property (nonatomic,strong) NSDictionary *params;
@property (nonatomic,strong) NSString *srv;


@end
