//
//  QHConversationModel.m
//  QHProject
//
//  Created by Chie Li on 16/5/30.
//  Copyright © 2016年 ChieLi. All rights reserved.
//

#import "QHConversationModel.h"

@implementation QHConversationModel

#pragma mark - JSON Model
+ (JSONKeyMapper *)keyMapper
{
    return  [[JSONKeyMapper alloc] initWithDictionary:@{@"objectId":@"objectId",
                                                        @"c":@"creatorId",
                                                        @"Im":@"lastMessageAt",
                                                        @"m":@"menbersId",
                                                        @"mu":@"mute",
                                                        @"lastMessageText":@"lastMessageText",
                                                        @"attr":@"attributes"
                                                        }];
}

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}

#pragma mark - public method
- (BOOL)containsAllMembersWithIds:(NSArray *)array
{
    if (self.membersId.count == array.count) {
        NSUInteger sameNumber = 0;
        for (NSString *currentId in array) {
            if ([self.membersId containsObject:currentId]) {
                sameNumber++;
            }
        }
        if (sameNumber == array.count) {
            return YES;
        }
    }
    return NO;
}


@end
