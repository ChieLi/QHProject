//
//  QHTabBar.h
//  QHProject
//
//  Created by Chie Li on 16/5/24.
//  Copyright © 2016年 ChieLi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QHTabBarItem;
@protocol QHTabBarDelegate <NSObject>

- (void)qhTabBarDidClickedAbNormalButton:(QHTabBarItem *)tabBarItem;

@end

@interface QHTabBar : UIView

@property (nonatomic, strong) NSArray *tabBarItems;
@property (nonatomic, weak) id<QHTabBarDelegate> delegate;


@end
