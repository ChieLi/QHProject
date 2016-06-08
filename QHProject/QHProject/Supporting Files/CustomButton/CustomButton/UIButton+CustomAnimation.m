//
//  UIButton+CustomAnimation.m
//  CustomButton
//
//  Created by Chie Li on 16/6/6.
//  Copyright © 2016年 ChieLi. All rights reserved.
//

#import "UIButton+CustomAnimation.h"
#import <objc/runtime.h>

static const char *UIButton_isClicked = "UIButton_isClicked";

@implementation UIButton (CustomAnimation)

+(void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        [self methodSWizzlingWithOrigin:@selector(sendAction:to:forEvent:) new:@selector(wp_sendAction:to:forEvent:)];
        [self methodSWizzlingWithOrigin:@selector(touchesBegan:withEvent:) new:@selector(wp_touchesBegans:withEvent:)];
//        [self methodSWizzlingWithOrigin:@selector(touchesEnded:withEvent:) new:@selector(wp_touchesEnded:withEvent:)];
    });
    
    
}

- (void)wp_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event
{
    [self wp_sendAction:action to:target forEvent:event];
    
    self.alpha = 0.5;
    
    
}

- (void)wp_touchesBegans:(NSSet<UITouch *> *)set withEvent:(UIEvent *)event
{
    [self wp_touchesBegans:set withEvent:event];

    NSLog(@"isClicked = %d", self.isClicked);
    UIImage *image;
    
    if (self.isClicked) {
        image = [self imageForState:(UIControlStateNormal)];
    } else {
        image = [self imageForState:(UIControlStateSelected)];
    }
    
    [UIView transitionWithView:self duration:0.5 options:(UIViewAnimationOptionTransitionCrossDissolve) animations:^{
        self.imageView.image = image;
        [self setBackgroundImage:image forState:(UIControlStateNormal)];
        
    } completion:^(BOOL finished) {
        self.imageView.image = image;
    }];
    
    self.isClicked = !self.isClicked;
    
    
}

- (void)wp_touchesEnded:(NSSet<UITouch *> *)set withEvent:(UIEvent *)event
{
//    [self wp_touchesEnded:set withEvent:event];
//    
//    UIImage *image = [self imageForState:(UIControlStateNormal)];
//    [UIView transitionWithView:self duration:0.5 options:(UIViewAnimationOptionTransitionCrossDissolve) animations:^{
//        self.imageView.image = image;
//    } completion:^(BOOL finished) {
//        
//    }];
}


#pragma mark - private

+ (void)methodSWizzlingWithOrigin:(SEL)origin new:(SEL)new
{
    Class class = [self class];
    Method ori_method = class_getInstanceMethod(class, origin);
    Method new_method = class_getInstanceMethod(class, new);
    
    BOOL didAddMethod = class_addMethod(class, origin, method_getImplementation(new_method), method_getTypeEncoding(new_method));
    
    if (didAddMethod) {
        class_replaceMethod(class, new, method_getImplementation(ori_method), method_getTypeEncoding(ori_method));
        
    } else {
        method_exchangeImplementations(ori_method, new_method);
    }
}

#pragma mark - 
- (BOOL)isClicked
{
    return [objc_getAssociatedObject(self, UIButton_isClicked) boolValue];
}

- (void)setIsClicked:(BOOL)isClicked
{
    objc_setAssociatedObject(self, UIButton_isClicked, [NSNumber numberWithBool:isClicked], OBJC_ASSOCIATION_ASSIGN);
}

@end
