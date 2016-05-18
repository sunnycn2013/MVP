//
//  TemplateSingleView.m
//  MVP
//
//  Created by sunnyvale on 15/12/8.
//  Copyright © 2015年 sunnyvale. All rights reserved.
//

#import "TemplateSingleView.h"
#import "TemplateSingleModel.h"
#import "TemplatePicModel.h"
#import "TemplateSingleSubView.h"

@interface TemplateSingleView ()<iCarouselDelegate,iCarouselDataSource>{
     iCarousel *_scrollView;
}

@property (nonatomic,strong) TemplateSingleModel *singleModel;
@end

@implementation TemplateSingleView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //
        _scrollView = [[iCarousel alloc] init];
        _scrollView.delegate = self;
        _scrollView.dataSource = self;
        _scrollView.type = iCarouselTypeLinear;
        _scrollView.pagingEnabled = YES;
        _scrollView.bounceDistance = 0.5;
        _scrollView.decelerationRate = 0.5;
        _scrollView.clipsToBounds = YES;
        _scrollView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_scrollView];

        [_scrollView mas_makeConstraints:^(MASConstraintMaker *make){
            make.edges.equalTo(self).insets(UIEdgeInsetsZero);
        }];
    }
    return self;
}

+ (CGSize)calculateSizeWithData:(id<NSObject>)data constrainedToSize:(CGSize)size
{
    return CGSizeMake(ScreenWidth, 100);
}

- (void)processData:(id <TemplateRenderProtocol>)data
{
    self.singleModel = (TemplateSingleModel *)data;
    [_scrollView reloadData];
}

#pragma mark -
- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return _singleModel.itemList.count;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    TemplateSingleSubView  *imageView = nil;
    if (!view) {
        imageView = [[TemplateSingleSubView alloc] initWithFrame:CGRectMake(0, 0, 80, 100)];
    }else{
        imageView = (TemplateSingleSubView *)view;
    }
    
    TemplatePicModel *model = self.singleModel.itemList[index];
    [imageView processData:model];
    return imageView;
}

- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    if (option == iCarouselOptionWrap)
    {
        return YES;
    }
    return value;
}

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index
{
    NSIndexPath *indexPath = [NSIndexPath indexPathWithIndex:index];
    if (_tapBlock) {
        _tapBlock(indexPath);
    }
}
@end
