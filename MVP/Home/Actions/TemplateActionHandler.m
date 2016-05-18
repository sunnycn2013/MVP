//
//  TemplateActionHandler.m
//  MVP
//
//  Created by sunnyvale on 15/12/18.
//  Copyright © 2015年 sunnyvale. All rights reserved.
//

#import "TemplateActionHandler.h"
#import "TemplateAction.h"

@interface TemplateActionHandler (){
    NSInvocation *_invocation;
}
@end

@implementation TemplateActionHandler

- (instancetype)init{
    self = [super init];
    if (self) {
        _invocation = [[NSInvocation alloc] init];
        [_invocation setTarget:self];
    }
    return self;
}

- (BOOL)handlerAction:(TemplateAction *)action
{
    _action = action;
    return [self invokeAction:_action];
}

- (BOOL)invokeAction:(TemplateAction *)action
{
    if (!action) return NO;
    
    __weak typeof(self) weakself = self;
    if ([self.delegate respondsToSelector:@selector(actionHandler:willHandlerAction:)]) {
        [self.delegate actionHandler:weakself willHandlerAction:action];
    }
    
    [action performTaskWithCompletionBlock:nil];
    
    if ([self.delegate respondsToSelector:@selector(actionHandler:didHandlerAction:)]) {
        [self.delegate actionHandler:weakself didHandlerAction:action];
    }
    return YES;
}

//SEL selector = @selector(myMethod:withParam2:);
//NSMethodSignature *methodSingnature = [[self class] instanceMethodSignatureForSelector:selector];
//NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSingnature];
//
//NSString *res = nil;
//NSString *str1 = @"1111";
//NSNumber *str2 = @(4);
//
//[invocation setTarget:self];
//[invocation setSelector:selector];
//[invocation setArgument:&str1 atIndex:2];
//[invocation setArgument:&str2 atIndex:3];
//[invocation retainArguments];
//[invocation invoke];
//
//[invocation getReturnValue:&res];

@end
