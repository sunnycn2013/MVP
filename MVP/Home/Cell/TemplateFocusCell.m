//
//  TemplateFocusCell.m
//  MVP
//
//  Created by sunnyvale on 15/12/6.
//  Copyright © 2015年 sunnyvale. All rights reserved.
//

#import "TemplateFocusCell.h"
#import "TemplateFocusView.h"
#import "TemplateFloorFocusModel.h"

@interface TemplateFocusCell (){
    TemplateFocusView *_focusView;
}

@property (nonatomic,strong) id <TemplateRenderProtocol> data;

@end
@implementation TemplateFocusCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _focusView = [[TemplateFocusView alloc] init];
        _focusView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:_focusView];
        
        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make){
            make.edges.equalTo(self).insets(UIEdgeInsetsZero);

        }];
        [_focusView mas_makeConstraints:^(MASConstraintMaker *make){
            make.edges.equalTo(self).insets(UIEdgeInsetsZero);
        }];
    }
    return self;
}

- (void)processData:(id <TemplateRenderProtocol>)data
{
    if([data isKindOfClass:[TemplateFloorFocusModel class]])
    {
        self.data = data;
        [_focusView processData:(id <TemplateRenderProtocol>)data];
    }
}

+ (CGSize)calculateSizeWithData:(id<NSObject>)data constrainedToSize:(CGSize)size
{
    CGSize curSize = CGSizeMake(ScreenWidth, 110);
    return curSize;
}

- (void)tapOnePlace:(TapBlock) block
{
    [_focusView setTapBlock:block];
}

@end
