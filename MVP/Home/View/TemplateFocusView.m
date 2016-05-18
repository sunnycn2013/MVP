//
//  TemplateFocusView.m
//  MVP
//
//  Created by sunnyvale on 15/12/6.
//  Copyright © 2015年 sunnyvale. All rights reserved.
//

#import "TemplateFocusView.h"
#import <iCarousel/iCarousel.h>
#import "TemplateFloorFocusModel.h"
#import "TemplatePicModel.h"

@interface TemplateFocusView ()<iCarouselDataSource,iCarouselDelegate>
{
    UIPageControl *_pageControl;
    iCarousel     *_scrollView;
}

@property (nonatomic,strong) TemplateFloorFocusModel *focusModel;
@end

@implementation TemplateFocusView

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
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
        
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_pageControl];
            
        [_scrollView mas_makeConstraints:^(MASConstraintMaker *make){
            make.edges.equalTo(self).insets(UIEdgeInsetsZero);
        }];
        
        [_pageControl mas_makeConstraints:^(MASConstraintMaker *make){
            make.bottom.mas_equalTo(@(5));
            make.centerX.equalTo(self);
        }];
    }
    return self;
}

+ (CGSize)calculateSizeWithData:(id<TemplateRenderProtocol>)data constrainedToSize:(CGSize)size
{
    return size;
}

- (void)processData:(id <TemplateRenderProtocol>)data
{
    self.focusModel = (TemplateFloorFocusModel *)data;
    _pageControl.numberOfPages = self.focusModel.itemList.count;
    [_scrollView reloadData];
    
    [self layoutIfNeeded];
}

#pragma mark -
- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return _focusModel.itemList.count;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    UIImageView *imageView = nil;
    if (!view) {
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth/2)];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        }else{
        imageView = (UIImageView *)view;
    }
   
    TemplatePicModel *model = self.focusModel.itemList[index];
    [imageView setImageWithURL:[NSURL URLWithString:model.img]];
    return imageView;
}

- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    if (option == iCarouselOptionWrap)
    {
        return NO;
    }
    return value;
}

- (void)carouselDidEndScrollingAnimation:(iCarousel *)carousel
{
    NSInteger index = _scrollView.scrollOffset;
    
    [_pageControl setCurrentPage:index];
}

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index
{
    NSIndexPath *indexPath = [NSIndexPath indexPathWithIndex:index];
    if (_tapBlock) {
        _tapBlock(indexPath);
    }
}
@end
