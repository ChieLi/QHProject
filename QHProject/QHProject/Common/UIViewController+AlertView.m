//
//  UIViewController+AlertView.m
//  QHProject
//
//  Created by Chie Li on 16/5/17.
//  Copyright © 2016年 ChieLi. All rights reserved.
//

#import "UIViewController+AlertView.h"

@implementation UIViewController (AlertView)

- (void)alertViewWithTitle:(NSString *)title message:(NSString *)message cancelBlock:(QHBlock)cancelBlock
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:(UIAlertControllerStyleAlert)];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        if (cancelBlock != nil) {
            cancelBlock();
        }
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)alertViewWithTiTle:(NSString *)title message:(NSString *)message cancelBlock:(QHBlock)cancelBlock comfirmBlock:(QHBlock)comfirmBlock
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:(UIAlertControllerStyleAlert)];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        if (cancelBlock != nil) {
            cancelBlock();
        }
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }];
    [alertController addAction:cancelAction];
    
    UIAlertAction *comfirmAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        if (comfirmBlock != nil) {
            comfirmBlock();
        }
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }];
    [alertController addAction:comfirmAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}
@end
