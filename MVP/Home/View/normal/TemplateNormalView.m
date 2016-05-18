//
//  TemplateNormalView.m
//  MVP
//
//  Created by sunnyvale on 15/12/17.
//  Copyright © 2015年 sunnyvale. All rights reserved.
//

#import "TemplateNormalView.h"
#import "TemplateNormalTapView.h"
#import "TemplateNormalSubModel.h"
#import "NSArray+Template.h"

const CGFloat HomePageChannelNormalViewInset       = 10.0;
const CGFloat HomePageChannelNormalViewNarrowInset = 2.0; //add 5.0
const CGFloat HomePageChannelNormalViewPattern02AspectRatio = 710.0 / 180.0;
const CGFloat HomePageChannelNormalViewPattern03AspectRatio = 345.0 / 360.0;
const CGFloat HomePageChannelNormalViewPattern04AspectRatio = 345.0 / 170.0;
const CGFloat HomePageChannelNormalViewPattern05AspectRatio = 345.0 / 360.0;
const CGFloat HomePageChannelNormalViewPattern06AspectRatio = 710.0 / 180.0;
const CGFloat HomePageChannelNormalViewPattern07AspectRatio = 223.0 / 250.0;
const CGFloat HomePageChannelNormalViewPattern08AspectRatio = 355.0 / 225.0; //add 5.0
const CGFloat HomePageChannelNormalViewPattern09AspectRatio = 353.0 / 342.0;

@class TemplateNormalSubModel;
@interface TemplateNormalView ()
@property (nonatomic,assign) TemplateNormalStyle normalStyle;
@end

@implementation TemplateNormalView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

+ (CGSize)calculateSizeWithData:(id<TemplateRenderProtocol>)data constrainedToSize:(CGSize)size
{
    CGFloat normalFloorHeight = 0;
    CGFloat width  = [UIScreen mainScreen].bounds.size.width;
    
    TemplateNormalStyle style = [[(TemplateNormalSubModel *)data pattern] integerValue];
    switch (style)
    {
        case TemplateNormalStyle001:
        case TemplateNormalStyle002:
        {
            normalFloorHeight = 70 + 10;
        }
            break;
            
        case TemplateNormalStyle003:
        {
            CGFloat style003Width  = (width - 30)/2;
            CGFloat style003Height = style003Width * (270/259);
            normalFloorHeight = style003Height +20;
        }
            break;
        case TemplateNormalStyle004:
        {
            CGFloat style004Width  = (width - 30)/2;
            CGFloat style004Height = (128.0/260.0) * style004Width;

            normalFloorHeight = style004Height +20;
        }
            break;
        case TemplateNormalStyle007:
        {
            CGFloat style007Width  = (width - 40)/4;
            CGFloat style007Height = (187.0/167.0) * style007Width;
            normalFloorHeight = style007Height + 50;
        }
            break;
            
        default:
            break;
    }
    return CGSizeMake(ScreenWidth, normalFloorHeight);
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat width  = self.bounds.size.width;
    
    switch (self.normalStyle) {
        case TemplateNormalStyle001:
        case TemplateNormalStyle002:
        {
            UIView *firstView = [self.subviews tp_firstObject];
            firstView.frame = CGRectMake(10, 0, width - 20, 70);
            [firstView setCenterX:width/2];
        }
            break;
            
        case TemplateNormalStyle003:
        {
            UIView *firstView = [self.subviews tp_firstObject];
            UIView *secondView = [self.subviews tp_secondObject];
            
            CGFloat style003Width  = (width - 30)/2;
            CGFloat style003Height = style003Width * (270/259);
            
            firstView.frame = CGRectMake(10, 0, style003Width, style003Height);
            secondView.frame = CGRectMake(10 + CGRectGetMaxX(firstView.frame), 0, style003Width, style003Height);
        }
            break;
        case TemplateNormalStyle004:
        {
            UIView *firstView = [self.subviews tp_firstObject];
            UIView *secondView = [self.subviews tp_secondObject];
            
            CGFloat style004Width  = (width - 30)/2;
            CGFloat style004Height = (128.0/260.0) * style004Width;
            
            firstView.frame = CGRectMake(10, 0, style004Width, style004Height);
            secondView.frame = CGRectMake(10 + CGRectGetMaxX(firstView.frame), 0, style004Width, style004Height);
        }
            break;
        case TemplateNormalStyle007:
        {
            UIView *firstView = [self.subviews tp_firstObject];
            UIView *secondView = [self.subviews tp_secondObject];
            UIView *thirdView = [self.subviews tp_thirdObject];

            CGFloat style007Width  = (width - 40) / 3;
            CGFloat style007Height = (187.0/167.0) * style007Width;
            
            firstView.frame = CGRectMake(10, 0, style007Width, style007Height);
            secondView.frame = CGRectMake(10 + CGRectGetMaxX(firstView.frame), 0, style007Width, style007Height);
            thirdView.frame = CGRectMake(10 + CGRectGetMaxX(secondView.frame), 0, style007Width, style007Height);

        }
            break;

            
        default:
            break;
    }
}

- (void)processData:(id <TemplateRenderProtocol>)data
{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];

    TemplateNormalSubModel *subModel = (TemplateNormalSubModel *)data;
    NSArray *picList = subModel.picList;
    self.normalStyle = [subModel.pattern integerValue];
    switch (self.normalStyle) {
        case TemplateNormalStyle001:
            [self addNormalTapViewWithCount:1 picList:picList];
            break;
        case TemplateNormalStyle002:
            [self addNormalTapViewWithCount:1 picList:picList];
            break;
        case TemplateNormalStyle003:
            [self addNormalTapViewWithCount:2 picList:picList];
            break;
        case TemplateNormalStyle004:
            [self addNormalTapViewWithCount:2 picList:picList];
            break;
        case TemplateNormalStyle005:
            [self addNormalTapViewWithCount:3 picList:picList];
            break;
        case TemplateNormalStyle006:
            [self addNormalTapViewWithCount:3 picList:picList];
            break;
        case TemplateNormalStyle007:
            [self addNormalTapViewWithCount:3 picList:picList];
            break;
        case TemplateNormalStyle008:
            [self addNormalTapViewWithCount:4 picList:picList];
            break;
        case TemplateNormalStyle009:
            [self addNormalTapViewWithCount:4 picList:picList];
            break;
        default:
            break;
    }
    [self setNeedsLayout];

}

- (void)addNormalTapViewWithCount:(NSInteger)count picList:(NSArray *)picList
{
    __weak typeof(self) weakSelf = self;
    for (int i = 0; i < count; i++) {
        TemplateNormalSubModel *subModel = picList[i];
        TemplateNormalTapView *tapView = [[TemplateNormalTapView alloc] init];
        [tapView processData:subModel];
        NSIndexPath *indexPath = [NSIndexPath indexPathWithIndex:i];
        [tapView setTapBlock:^{
            if (weakSelf.tapBlock) {
                weakSelf.tapBlock(indexPath);
            }
        }];
        [self addSubview:tapView];
    }
}

@end
