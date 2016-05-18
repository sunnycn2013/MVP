//
//  TemplateMarginCell.m
//  MVP
//
//  Created by sunnyvale on 15/12/17.
//  Copyright © 2015年 sunnyvale. All rights reserved.
//

#import "TemplateMarginCell.h"

@implementation TemplateMarginCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

+ (CGSize)calculateSizeWithData:(id<NSObject>)data constrainedToSize:(CGSize)size
{
    return CGSizeMake(ScreenWidth, 10);
}

- (void)processData:(id <TemplateRenderProtocol>)data
{
    
}

- (void)tapOnePlace:(TapBlock) block
{
    
}
@end
