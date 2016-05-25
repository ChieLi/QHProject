//
//  QHTabBarItem.h
//  QHProject
//
//  Created by Chie Li on 16/5/24.
//  Copyright © 2016年 ChieLi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, QHTabBarItemType) {
    QHTabBarItemTypeNormal,
    QHTabBarItemTypeAbnormal

};

@interface QHTabBarItem : UIButton

@property (nonatomic, assign) QHTabBarItemType type;

+ (instancetype)tabBarItemWithFrame:(CGRect)frame title:(NSString *)title  normalImage:(UIImage *)normalImage selectedImage:(UIImage *)selectedImage type:(QHTabBarItemType)type;

@end
