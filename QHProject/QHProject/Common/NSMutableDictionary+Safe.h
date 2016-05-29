//
//  NSMutableDictionary+Safe.h
//  QHProject
//
//  Created by Chie Li on 16/5/27.
//  Copyright © 2016年 ChieLi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (Safe)

- (void)safeSetValue:(id)value forKey:(NSString *)key;

@end
