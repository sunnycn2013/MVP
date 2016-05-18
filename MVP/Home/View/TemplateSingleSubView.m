//
//  TemplateSingleSubView.m
//  MVP
//
//  Created by sunnyvale on 15/12/18.
//  Copyright © 2015年 sunnyvale. All rights reserved.
//

#import "TemplateSingleSubView.h"
#import "TemplateSkuModel.h"

@interface TemplateSingleSubView ()
{
    UIImageView *_imageView;
    UILabel     *_pPriceLabel;
    UILabel     *_wPriceLabel;
    UILabel     *_titleLabel;
    
    UIView      *_lineView;
}
@end

@implementation TemplateSingleSubView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        _imageView = [[UIImageView alloc] init];
        _imageView.frame = CGRectMake(2, 2, 76, 76);
        [self addSubview:_imageView];
        
        _pPriceLabel = [[UILabel alloc] init];
        _pPriceLabel.frame = CGRectMake(0, 76, 80, 15);
        _pPriceLabel.textAlignment = NSTextAlignmentCenter;
        _pPriceLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:_pPriceLabel];
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.numberOfLines = 0;
    }
    return self;
}

+ (CGSize)calculateSizeWithData:(id<NSObject>)data constrainedToSize:(CGSize)size
{
    return size;
}

- (void)processData:(id <TemplateRenderProtocol>)data
{
    TemplateSkuModel<TemplateRenderProtocol> *skuModel = (TemplateSkuModel *)data;
    
    [_imageView setImageWithURL:[NSURL URLWithString:skuModel.img]];
    [_titleLabel setText:skuModel.title];
    _pPriceLabel.text = skuModel.pprice;
    _wPriceLabel.text = skuModel.wprice;
}

- (void)tapOnePlace:(TapBlock) block
{
}
@end
