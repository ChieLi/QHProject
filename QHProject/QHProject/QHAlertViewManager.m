//
//  QHAlertViewManager.m
//  QHProject
//
//  Created by Chie Li on 16/5/12.
//  Copyright © 2016年 ChieLi. All rights reserved.
//

#import "QHAlertViewManager.h"

@implementation QHAlertViewManager

+ (void)alertViewWithTitle:(NSString *)title message:(NSString *)message onViewController:(UIViewController *)viewContrller block:(QHBlock)block
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:(UIAlertControllerStyleAlert)];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        if (block) {
            block();
        }
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [alertController addAction:cancelAction];
    
    [viewContrller presentViewController:alertController animated:YES completion:nil];
}

@end
