//
//  UIViewController+Keyboard.h
//  QHProject
//
//  Created by Chie Li on 16/6/8.
//  Copyright © 2016年 ChieLi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^QHKeyboardShowBlock) (NSTimeInterval animationDuration, CGFloat keyboardHeight);
typedef void(^QHKeyboardHideBlock) (NSTimeInterval animationDuration, CGFloat keyboardHeight);
@interface UIViewController (Keyboard)

@property (nonatomic, copy) QHKeyboardShowBlock showBlock;
@property (nonatomic, copy) QHKeyboardHideBlock hideBlock;

- (void)registerKeyboardNotificationWithShowBlock:(QHKeyboardShowBlock)showBlock hideBlock:(QHKeyboardHideBlock)hideBlock;
- (void)removeKeyboardNotification;
@end
