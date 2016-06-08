//
//  QHAppSkinManager.h
//  QHProject
//
//  Created by Chie Li on 16/5/24.
//  Copyright © 2016年 ChieLi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QHAppSkinManager : NSObject

+ (instancetype)defaultAppSkinManager;

@end

@interface QHAppSkinManager (Color)

- (UIColor *)contentColorBlue1;
- (UIColor *)contentColorBlue2;
- (UIColor *)contentColorBlue3;
- (UIColor *)contentColorBlue4;
- (UIColor *)contentColorBlue5;
- (UIColor *)contentColorBlue6;

- (UIColor *)contentColorYellow1;
- (UIColor *)contentColorYellow2;


@end
