//
//  UIViewController+NavigationItem.h
//  QHProject
//
//  Created by Chie Li on 16/6/8.
//  Copyright © 2016年 ChieLi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (NavigationItem)

- (NSArray *)barItemsWithCustomView:(UIView *)customView;
- (NSArray *)barItemsWithCustomView:(UIView *)customView space:(CGFloat)space;
- (NSArray *)barItemsWithCustomViews:(NSArray *)customViews;
- (NSArray *)barItemsWithCustomViews:(NSArray *)customViews space:(CGFloat)space;

@end
