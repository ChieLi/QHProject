//
//  UIColor+HexColor.h
//  QHProject
//
//  Created by Chie Li on 16/6/4.
//  Copyright © 2016年 ChieLi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HexColor)

+ (UIColor *) colorWithHex:(NSInteger)rgbHexValue;

+ (UIColor *) colorWithHex:(NSInteger)rgbHexValue alpha:(CGFloat)alpha;

+ (UIColor *)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;
@end
