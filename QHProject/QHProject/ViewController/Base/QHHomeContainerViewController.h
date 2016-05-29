//
//  QHHomeContainerViewController.h
//  QHProject
//
//  Created by Chie Li on 16/5/29.
//  Copyright © 2016年 ChieLi. All rights reserved.
//

#import "QHBaseViewController.h"

typedef NS_ENUM(NSInteger, QHHomeContainerViewControllerStatus) {
    QHHomeContainerViewControllerStatusLogin,
    QHHomeContainerViewControllerStatusHome
};

@interface QHHomeContainerViewController : QHBaseViewController

- (instancetype)initWithSatus:(QHHomeContainerViewControllerStatus)status;

- (void)transitionToLoginViewController;
- (void)transitionToHomeTabBarController;

@end
