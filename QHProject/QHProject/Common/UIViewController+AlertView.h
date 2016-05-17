//
//  UIViewController+AlertView.h
//  QHProject
//
//  Created by Chie Li on 16/5/17.
//  Copyright © 2016年 ChieLi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (AlertView)

- (void)alertViewWithTitle:(NSString *)title message:(NSString *)message cancelBlock:(QHBlock)cancelBlock;
- (void)alertViewWithTiTle:(NSString *)title message:(NSString *)message cancelBlock:(QHBlock)cancelBlock comfirmBlock:(QHBlock)comfirmBlock;
@end
