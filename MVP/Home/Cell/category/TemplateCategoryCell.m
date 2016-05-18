//
//  TemplateCategoryCell.m
//  MVP
//
//  Created by sunnyvale on 15/12/13.
//  Copyright © 2015年 sunnyvale. All rights reserved.
//

#import "TemplateCategoryCell.h"

@implementation TemplateCategoryCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.contentView.backgroundColor = [UIColor yellowColor];
    }
    return self;
}

+ (CGSize)calculateSizeWithData:(id<TemplateRenderProtocol>)data constrainedToSize:(CGSize)size
{
    return CGSizeMake(ScreenWidth, 60);
}

- (void)processData:(id <TemplateRenderProtocol>)data
{
    self.textLabel.text = [NSString stringWithFormat:@"cell"];
}

- (void)tapOnePlace:(TapBlock) block
{
    
}
@end
