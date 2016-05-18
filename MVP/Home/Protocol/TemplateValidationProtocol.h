//
//  TemplateValidationProtocol.h
//  MVP
//
//  Created by sunnyvale on 15/12/18.
//  Copyright © 2015年 sunnyvale. All rights reserved.
//

@protocol TemplateValidationProtocol <NSObject>

@required
@property (nonatomic, readonly, getter=isValid) BOOL valid;

@end

