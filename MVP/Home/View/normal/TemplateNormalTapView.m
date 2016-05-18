//
//  TemplateNormalTapView.m
//  MVP
//
//  Created by sunnyvale on 15/12/17.
//  Copyright © 2015年 sunnyvale. All rights reserved.
//

#import "TemplateNormalTapView.h"
#import "TemplatePicModel.h"

@implementation TemplateNormalTapView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] init];
        [tapGesture addTarget:self action:@selector(tapAction:)];
        [self addGestureRecognizer:tapGesture];
    }
    return self;
}

- (void)tapAction:(UITapGestureRecognizer *)tap
{
    if (self.tapBlock) {
        self.tapBlock();
    }
}

- (void)processData:(id <TemplateRenderProtocol>)data
{
    TemplatePicModel *picModel = (TemplatePicModel *)data;
    [self setImageWithURL:[NSURL URLWithString:picModel.img]];
}
@end
