//
//  QHAlertViewManager.h
//  QHProject
//
//  Created by Chie Li on 16/5/12.
//  Copyright © 2016年 ChieLi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface QHAlertViewManager : NSObject

+ (void)alertViewWithTitle:(NSString *)title message:(NSString *)message onViewController:(UIViewController *)viewContrller block:(QHBlock)block;

@end
