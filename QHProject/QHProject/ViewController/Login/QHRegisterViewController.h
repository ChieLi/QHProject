//
//  QHRegisterViewController.h
//  QHProject
//
//  Created by Chie Li on 16/5/12.
//  Copyright © 2016年 ChieLi. All rights reserved.
//

#import "QHBaseViewController.h"

typedef NS_ENUM(NSInteger, QHRegisterViewControllerType) {
    QHRegisterViewControllerTypeEmail,
    QHRegisterViewControllerTypePhoneNumber
};

@interface QHRegisterViewController : QHBaseViewController

- (instancetype)initWithType:(QHRegisterViewControllerType)type;

@end
