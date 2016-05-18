//
//  TemplateCategoryHeaderCell.m
//  MVP
//
//  Created by sunnyvale on 15/12/12.
//  Copyright © 2015年 sunnyvale. All rights reserved.
//

#import "TemplateCategoryHeaderCell.h"
#import "TemplateCategoryItemModel.h"
#import "TemplateContainerModel.h"

@interface TemplateCategoryHeaderCell ()<UIScrollViewDelegate>
{
    UIScrollView *_scrollView;
    UIButton *_switchButton;
    UIView *_itemView;
}

@property (nonatomic,assign) BOOL isShowing;

@end

@implementation TemplateCategoryHeaderCell

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor greenColor];
        
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.delegate = self;
        [self.contentView addSubview:_scrollView];
        
        _switchButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _switchButton.frame = CGRectMake(ScreenWidth-40, 0, 44, 44);
        _switchButton.backgroundColor = [UIColor whiteColor];
        [_switchButton setImage:[UIImage imageNamed:@"back_bt_7h"] forState:UIControlStateNormal];
        [_switchButton addTarget:self action:@selector(swithCategory:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_switchButton];
        
        _itemView = [[UIView alloc] init];
        _itemView.frame = CGRectMake(0, 44, ScreenWidth, 0);
        _itemView.backgroundColor = [UIColor purpleColor];
        [self.contentView addSubview:_itemView];
        
        [_scrollView mas_makeConstraints:^(MASConstraintMaker *make){
            make.edges.equalTo(self.contentView).insets(UIEdgeInsetsZero);
        }];
        
//        [_switchButton mas_makeConstraints:^(MASConstraintMaker *make){
//            make.top.equalTo(0);
//            make.left.mas_equalTo(@(ScreenWidth - 60));
//            make.width.equalTo(@(60));
//            make.height.equalTo(@(44));
//        }];
    }
    
    return self;
}

+ (CGSize)calculateSizeWithData:(id<TemplateRenderProtocol>)data constrainedToSize:(CGSize)size
{
    return CGSizeMake(ScreenWidth, 44);
}

- (void)processData:(id <TemplateRenderProtocol>)data
{
    NSArray <TemplateCategoryItemModel *> *list = [(TemplateContainerModel *)data itemList];
    
    
    CGFloat width = 80;
    CGFloat height = 40;
    for (int i = 0; i < list.count ; i++) {
        TemplateCategoryItemModel *obj = list[i];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(width * i, 2, width, height);
        [button setTitle:obj.title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_scrollView addSubview:button];
    }
    
    _scrollView.contentSize = CGSizeMake(width * list.count, height);
}

- (void)tapOnePlace:(TapBlock) block
{
    
}

- (void)swithCategory:(UIButton *)button
{
    _switchButton.transform = CGAffineTransformMakeRotation(M_PI_2);
    [UIView animateWithDuration:0.5
                     animations:^{
                         CGAffineTransform transform = CGAffineTransformRotate(_switchButton.transform, M_PI_2);
                         _switchButton.transform = transform;
                     }
                     completion:^(BOOL finish){
    
    }];

    if (!_isShowing) {
        [UIView animateWithDuration:0.5 animations:^{
            _itemView.mj_size = CGSizeMake(ScreenWidth, 100);
        }];
        _isShowing = YES;
    }else{
        [UIView animateWithDuration:0.5 animations:^{
            _itemView.mj_size = CGSizeMake(ScreenWidth, 0);
        }];
        _isShowing = NO;
    }
    
}
@end
