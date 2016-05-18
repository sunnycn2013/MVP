//
//  TemplateSingleCell.m
//  MVP
//
//  Created by sunnyvale on 15/12/8.
//  Copyright © 2015年 sunnyvale. All rights reserved.
//

#import "TemplateSingleCell.h"
#import "TemplateSingleView.h"

@interface TemplateSingleCell ()

@property (nonatomic,strong) TemplateSingleView *singleView;

@end

@implementation TemplateSingleCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _singleView = [[TemplateSingleView alloc] init];
        _singleView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:_singleView];
        [_singleView mas_makeConstraints:^(MASConstraintMaker *make){
            make.edges.equalTo(self.contentView).insets(UIEdgeInsetsZero);
        }];
    }
    return self;
}

+ (CGSize)calculateSizeWithData:(id<TemplateRenderProtocol>)data constrainedToSize:(CGSize)size
{
    return [TemplateSingleView calculateSizeWithData:data constrainedToSize:size];
}

- (void)processData:(id <TemplateRenderProtocol>)data
{
    self.contentView.backgroundColor = [UIColor whiteColor];

    [_singleView processData:data];
}

- (void)tapOnePlace:(TapBlock) block
{
    
}
@end
