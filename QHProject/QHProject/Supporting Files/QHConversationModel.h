//
//  QHConversationModel.h
//  QHProject
//
//  Created by Chie Li on 16/5/30.
//  Copyright © 2016年 ChieLi. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface QHConversationModel : JSONModel

@property (nonatomic, copy) NSString *objectId;
@property (nonatomic, copy) NSString <Optional> *name;
@property (nonatomic, strong) NSString <Optional> *creatorId;
@property (nonatomic, strong) NSDate <Optional> *lastMessageAt;
@property (nonatomic, strong) NSString <Optional> *lastMessageText;
@property (nonatomic, strong) NSArray <Optional> *membersId;
@property (nonatomic, strong) NSArray <Optional> *mute;
@property (nonatomic, strong) NSDictionary <Optional> *attributes;

- (BOOL)containsAllMembersWithIds:(NSArray *)array;

@end
