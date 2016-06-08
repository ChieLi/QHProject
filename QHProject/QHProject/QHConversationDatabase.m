//
//  QHConversationDatabase.m
//  QHProject
//
//  Created by Chie Li on 16/6/5.
//  Copyright © 2016年 ChieLi. All rights reserved.
//

#import "QHConversationDatabase.h"
#import <sqlite3.h>

#import "FMDB.h"


@interface QHConversationDatabase ()

@property (nonatomic, copy) NSString *conversationsDatabasePath;
@property (nonatomic, strong) FMDatabaseQueue *conversationsQueue;

@property (nonatomic, copy) NSString *messagesDatabasePath;
@property (nonatomic, strong) FMDatabaseQueue *messagesQueue;


@end

@interface QHConversationDatabase ()

@property (nonatomic, strong) NSDateFormatter *dateFormatter;

@end

@implementation QHConversationDatabase

//static sqlite3 *conversationsDatabase = nil;
//static sqlite3 *messagesDatabase = nil;

+ (instancetype)sharedInstance
{
    static QHConversationDatabase *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[QHConversationDatabase alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init
{
    if (self = [super init]) {
        self.conversationsQueue = [FMDatabaseQueue databaseQueueWithPath:self.conversationsDatabasePath];
        self.messagesQueue = [FMDatabaseQueue databaseQueueWithPath:self.messagesDatabasePath];
    }
    return self;
}

#pragma mark - public method

- (void)addMessageIntoDatabase:(QHMessageModel *)message
{
    [self.messagesQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        BOOL result = YES;
            BOOL creatResult = [self messages:db createTableWithConversationId:message.conversationId];
            if (creatResult) {
                result = [self messages:db insertMessageWithType:message.type time:message.time fromId:message.fromId text:message.text imageURL:message.imageURL conversationId:message.conversationId];
            }
        
        if (!result) {
            *rollback = YES;
        }
    }];
    
}

- (void)getMessagesWithConversationId:(NSString *)conversationId skip:(NSInteger)skip limit:(NSInteger)limit block:(QHArrayBlock)block
{
    [self.messagesQueue inDatabase:^(FMDatabase *db) {

        FMResultSet *resultSet = [self messages:db getMessagesWithConversationId:conversationId skip:skip limit:limit];
        NSMutableArray *array = [NSMutableArray array];
        while ([resultSet next]) {
            int c_id = [resultSet intForColumn:@"c_id"];
            int c_type = [resultSet intForColumn:@"c_type"];
            NSString *c_time = [resultSet stringForColumn:@"c_time"];
            NSString *c_fromId = [resultSet stringForColumn:@"c_fromId"];
            NSString *c_text = [resultSet stringForColumn:@"c_text"];
            NSString *c_imageURL = [resultSet stringForColumn:@"imageURL"];
            QHMessageModel *model = [[QHMessageModel alloc] init];
            model.type = c_type;
            model.time = [self.dateFormatter dateFromString:c_time];
            model.fromId = c_fromId;
            model.text = c_text;
            model.imageURL = c_imageURL;
            
            [array addObject:model];
        }
        block(array, nil);

    }];
}

#pragma mark - messages

- (FMDatabase *)messagesDatabase
{
    return [FMDatabase databaseWithPath:self.messagesDatabasePath];
}

- (BOOL)messages:(FMDatabase *)db createTableWithConversationId:(NSString *)conversationId
{
    NSString *sqlString = [NSString stringWithFormat:@"create table if not exists conversation_%@ (c_id integer primary key autoincrement not null, c_type integer, c_time text, c_fromId text, c_text text, c_imageURL text)", conversationId];
    return [db executeUpdate:sqlString];
}

- (BOOL)messages:(FMDatabase *)db deleteTableWithConversationId:(NSString *)conversationId
{
    NSString *sqlString =[NSString stringWithFormat:@"delete table conversation_%@", conversationId];
    return [db executeUpdate:sqlString];
}

- (BOOL)messages:(FMDatabase *)db insertMessageWithType:(QHMessageType)type time:(NSDate *)time fromId:(NSString *)fromId text:(NSString *)text imageURL:(NSString *)imageURL conversationId:(NSString *)conversationId
{
    NSString *sqlString = [NSString stringWithFormat:@"insert into conversation_%@ (c_type,c_time,c_fromId,c_text) values(?,?,?,?)", conversationId];
    NSString *timeString = [self.dateFormatter stringFromDate:time];
    return [db executeUpdate:sqlString, @(type), timeString, fromId, text];
}

- (FMResultSet *)messages:(FMDatabase *)db getMessagesWithConversationId:(NSString *)conversationId skip:(NSInteger)skip limit:(NSInteger)limit
{
    NSString *sqlString = [NSString stringWithFormat:@"select from conversation_%@ order by c_id desc limit(?,?)", conversationId];
    return [db executeQuery:sqlString, @(skip), @(limit)];
}

//- (NSMutableArray *)messagesfindMessagesSkip:(NSInteger)skip limit:(NSInteger)limit fromConversation:(NSString *)conversationId
//{
//    NSString *sqlString = [NSString stringWithFormat:@"select * from %@ order by c_id desc limit(%ld,%ld)", conversationId, skip, limit];
//    sqlite3_stmt *stmt = NULL;
//    int result = sqlite3_prepare(messagesDatabase, sqlString.UTF8String, -1, &stmt, NULL);
//    if (result == SQLITE_OK) {
//        
//        NSMutableArray *array = [[NSMutableArray alloc] init];
//        
//        while (sqlite3_step(stmt) == SQLITE_ROW) {
//            int c_id = sqlite3_column_int(stmt, 0);
//            int c_type = sqlite3_column_int(stmt, 1);
//            NSString *c_time = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 2)];
//            NSString *c_fromId = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 3)];
//            NSString *c_text = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 4)];
//            NSString *c_imageURL = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 5)];
//#warning -test
//        }
//        return array;
//        
//    } else {
//        return nil;
//    }
//}




#pragma mark - property getter

- (NSString *)conversationsDatabasePath
{
    if (!_conversationsDatabasePath) {
        NSString *documents = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
        _conversationsDatabasePath = [documents stringByAppendingString:@"/conversations.sqlite"];
    }
    return _conversationsDatabasePath;
}

- (NSString *)messagesDatabasePath
{
    if (!_messagesDatabasePath) {
       NSString *documents = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
        _messagesDatabasePath = [documents stringByAppendingString:@"/messages.sqlite"];
    }
    return _messagesDatabasePath;
}

- (NSDateFormatter *)dateFormatter
{
    if (!_dateFormatter) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        [_dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
    }
    return _dateFormatter;
}


@end
