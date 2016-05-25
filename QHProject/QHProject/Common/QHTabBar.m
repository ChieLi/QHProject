//
//  QHTabBar.m
//  QHProject
//
//  Created by Chie Li on 16/5/24.
//  Copyright © 2016年 ChieLi. All rights reserved.
//

#import "QHTabBar.h"
#import "QHTabBarItem.h"
#import "AppDelegate.h"

static const NSInteger kQHTabBarNormalItemTag = 111;
static const NSInteger kQHTabBarAbnormalItemTag = 222;

@interface QHTabBar ()

@property (nonatomic, strong) QHTabBarItem *currentItem;

@end

@implementation QHTabBar

#pragma mark - event response
- (void)didClickedItem:(QHTabBarItem *)item
{
    if (item.type == QHTabBarItemTypeNormal) {
        self.currentItem.selected = NO;
        item.selected = YES;
        if ([[AppDelegate getAppDelegate].window.rootViewController isKindOfClass:[UITabBarController class]]) {
            UITabBarController *tabBarController = (UITabBarController *)[AppDelegate getAppDelegate].window.rootViewController;
            tabBarController.selectedIndex = item.tag - kQHTabBarNormalItemTag;
        }
        
    } else {
        if ([self.delegate respondsToSelector:@selector(qhTabBarDidClickedAbNormalButton:)]) {
            [self.delegate qhTabBarDidClickedAbNormalButton:item];
        }
    }
    
    self.currentItem = item;
}

#pragma mark - setter
- (void)setTabBarItems:(NSArray *)tabBarItems
{
    _tabBarItems = tabBarItems;
    NSInteger normalItemTag = kQHTabBarNormalItemTag;
    NSInteger abnormalItemTag = kQHTabBarAbnormalItemTag;
    
    for (QHTabBarItem *item in _tabBarItems) {
        [item addTarget:self action:@selector(didClickedItem:) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:item];
        if (item == _tabBarItems.firstObject) {
            item.selected = YES;
        }
        if (item.type == QHTabBarItemTypeNormal) {
            item.tag = normalItemTag;
            normalItemTag ++;
        } else {
            item.tag = abnormalItemTag;
            abnormalItemTag ++;
        }
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
