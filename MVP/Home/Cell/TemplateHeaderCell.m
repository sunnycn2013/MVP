//
//  TemplateHeaderCell.m
//  MVP
//
//  Created by sunnyvale on 15/12/8.
//  Copyright © 2015年 sunnyvale. All rights reserved.
//

#import "TemplateHeaderCell.h"
#import "TemplateFHeaderModel.h"

@interface TemplateHeaderCell ()
@property (nonatomic,strong) UIImageView *titleImageView;
@property (nonatomic,strong) UILabel     *label;
@end

@implementation TemplateHeaderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSeparatorStyleNone;

        self.backgroundColor = [UIColor whiteColor];
        
        _titleImageView = [[UIImageView alloc] init];
        _titleImageView.contentMode = UIViewContentModeScaleAspectFill;
        _titleImageView.frame = CGRectMake(10, 5, 125, 20);
        [self.contentView addSubview:_titleImageView];
        
        _label = [[UILabel alloc] init];
        _label.text = @"更多爆款";
        _label.textAlignment = NSTextAlignmentRight;
        _label.frame = CGRectMake(ScreenWidth - 75, 5, 70, 20);
        [self.contentView addSubview:_label];
    }
    return self;
}

+ (CGSize)calculateSizeWithData:(id<NSObject>)data constrainedToSize:(CGSize)size
{
    return CGSizeMake(ScreenWidth, 31);
}

- (void)processData:(id <TemplateRenderProtocol>)data
{
    TemplateFHeaderModel *model = (TemplateFHeaderModel *)data;
    
    [_titleImageView setImageWithURL:[NSURL URLWithString:model.lctitleImg]];
}

- (void)tapOnePlace:(TapBlock) block
{
    
}
@end
