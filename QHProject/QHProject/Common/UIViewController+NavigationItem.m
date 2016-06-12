//
//  UIViewController+NavigationItem.m
//  QHProject
//
//  Created by Chie Li on 16/6/8.
//  Copyright © 2016年 ChieLi. All rights reserved.
//

#import "UIViewController+NavigationItem.h"

static CGFloat const kNaviSpaceWidth = -1.0f;

@implementation UIViewController (NavigationItem)

- (NSArray *)barItemsWithCustomView:(UIView *)customView
{
    CGFloat space = kNaviSpaceWidth;
    return [self barItemsWithCustomView:customView space:space];
}

- (NSArray *)barItemsWithCustomView:(UIView *)customView space:(CGFloat)space
{
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:customView];
    if (space == 0) {
        return @[barButtonItem];
    }
    
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                               target:nil
                                                                               action:nil];
    [spaceItem setWidth:space];
    
    return @[spaceItem, barButtonItem];
}

- (NSArray *)barItemsWithCustomViews:(NSArray *)customViews
{
    CGFloat space = kNaviSpaceWidth;
    return [self barItemsWithCustomViews:customViews space:space];
}

- (NSArray *)barItemsWithCustomViews:(NSArray *)customViews space:(CGFloat)space
{
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                               target:nil
                                                                               action:nil];
    [spaceItem setWidth:space];
    NSMutableArray *tmpArray = [@[spaceItem] mutableCopy];
    
    for (UIView *customView in customViews) {
        UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:customView];
        [tmpArray addObject:barButtonItem];
    }
    return [tmpArray copy];
}

@end
