//
//  QHUserManager+Contacts.m
//  QHProject
//
//  Created by Chie Li on 16/5/25.
//  Copyright © 2016年 ChieLi. All rights reserved.
//

#import "QHUserManager.h"
#import "NSString+PinYin.h"

@implementation QHUserManager (Contacts)

+ (NSMutableDictionary *)sortedContactsWithAVUserArray:(NSArray *)avUserArray
{
    NSMutableDictionary *sortedContacts = [[NSMutableDictionary alloc]init];
    
    for (AVUser *currentUser in avUserArray) {
        @autoreleasepool {
            NSString *firstLetter = [currentUser.username getFirstLetter];
            NSMutableArray *tempArray = [sortedContacts objectForKey:firstLetter];
            QHUserModel *qhUser = [[QHUserModel alloc] init];
            [self transferAVUser:currentUser toQHUser:qhUser];
            
            if (tempArray) {
                [tempArray addObject:qhUser];
            } else {
                tempArray = [[NSMutableArray alloc] initWithObjects:qhUser, nil];
                [sortedContacts setValue:tempArray forKey:firstLetter];
            }
        }
    }
    return sortedContacts;
}

@end
