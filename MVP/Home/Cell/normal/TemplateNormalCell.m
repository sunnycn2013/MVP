//
//  TemplateNormalCell.m
//  MVP
//
//  Created by sunnyvale on 15/12/17.
//  Copyright © 2015年 sunnyvale. All rights reserved.
//

#import "TemplateNormalCell.h"
#import "TemplateNormalView.h"

@interface TemplateNormalCell ()
@property (nonatomic,strong) TemplateNormalView *normalView;
@end

@implementation TemplateNormalCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        _normalView = [[TemplateNormalView alloc] init];
//        _normalView.frame = CGRectMake(0, 0, ScreenWidth, 67);
        _normalView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:_normalView];
        
        [_normalView mas_makeConstraints:^(MASConstraintMaker *make){
            make.edges.equalTo(self.contentView).insets(UIEdgeInsetsZero);
        }];
    }
    return self;
}

+ (CGSize)calculateSizeWithData:(id<TemplateRenderProtocol>)data constrainedToSize:(CGSize)size
{
    return [TemplateNormalView calculateSizeWithData:data constrainedToSize:size];
}

- (void)processData:(id <TemplateRenderProtocol>)data
{
    [_normalView processData:data];
}

- (void)tapOnePlace:(TapBlock) block
{
    [_normalView setTapBlock:block];
}

@end
