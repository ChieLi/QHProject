//
//  UIViewController+Keyboard.m
//  QHProject
//
//  Created by Chie Li on 16/6/8.
//  Copyright © 2016年 ChieLi. All rights reserved.
//

#import "UIViewController+Keyboard.h"
#import <objc/runtime.h>

static const void *KeyboardShowBlockKey = &KeyboardShowBlockKey;
static const void *KeyboardHideBlockKey = &KeyboardHideBlockKey;

@implementation UIViewController (Keyboard)

- (void)registerKeyboardNotificationWithShowBlock:(QHKeyboardShowBlock)showBlock hideBlock:(QHKeyboardHideBlock)hideBlock
{
    self.showBlock = showBlock;
    self.hideBlock = hideBlock;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)removeKeyboardNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:self];
}


#pragma mark - event -response
- (void)keyboardWillShow:(NSNotification *)notification
{
    NSTimeInterval animationDuration = [[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    CGRect keyboardFrame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    !self.showBlock?:self.showBlock(animationDuration, keyboardFrame.size.height);
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    NSTimeInterval animationDuration = [[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    CGRect keyboardFrame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    !self.hideBlock?:self.hideBlock(animationDuration, keyboardFrame.size.height);
}

#pragma mark - setter and getter
- (QHKeyboardShowBlock)showBlock
{
    return objc_getAssociatedObject(self, KeyboardShowBlockKey);
}

- (void)setShowBlock:(QHKeyboardShowBlock)showBlock
{
    objc_setAssociatedObject(self, KeyboardShowBlockKey, showBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (QHKeyboardHideBlock)hideBlock
{
    return objc_getAssociatedObject(self, KeyboardHideBlockKey);
}

- (void)setHideBlock:(QHKeyboardHideBlock)hideBlock
{
    objc_setAssociatedObject(self, KeyboardHideBlockKey, hideBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
@end
