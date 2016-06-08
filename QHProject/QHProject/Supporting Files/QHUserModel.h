//
//  QHUserModel.h
//  QHProject
//
//  Created by Chie Li on 16/5/12.
//  Copyright © 2016年 ChieLi. All rights reserved.
//

#import <JSONModel.h>

@interface QHUserModel : JSONModel

@property (nonatomic, copy) NSString *objectId;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *phoneNumber;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *pictureURL;

@end
