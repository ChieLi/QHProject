//
//  NSMutableDictionary+Safe.m
//  QHProject
//
//  Created by Chie Li on 16/5/27.
//  Copyright © 2016年 ChieLi. All rights reserved.
//

#import "NSMutableDictionary+Safe.h"

@implementation NSMutableDictionary (Safe)

- (void)safeSetValue:(id)value forKey:(NSString *)key
{
    id tempValue = value;
    if (!tempValue
        || [tempValue isKindOfClass:[NSNull class]]
        || !key
        || ![key isKindOfClass:[NSString class]]
        ) {
        return;     }
    self[key] = tempValue;
}
@end
