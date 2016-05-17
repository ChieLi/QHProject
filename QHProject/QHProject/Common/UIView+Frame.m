//
//  UIView+Frame.m
//  QHProject
//
//  Created by Chie Li on 16/5/16.
//  Copyright © 2016年 ChieLi. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

- (void)removeAllSubViews
{
    while (self.subviews.count) {
        UIView *childView = self.subviews.lastObject;
        [childView removeFromSuperview];
    }
}

@end
