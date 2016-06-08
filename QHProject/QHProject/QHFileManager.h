//
//  QHFileManager.h
//  QHProject
//
//  Created by Chie Li on 16/5/30.
//  Copyright © 2016年 ChieLi. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kQHFileManagerConversationPath [NSString stringWithFormat:@"conversation_%@",[QHUserManager currentUser].objectId]
#define kQHFileManagerContactsPath [NSString stringWithFormat:@"contacts_%@",[QHUserManager currentUser].objectId]

typedef NS_ENUM(NSInteger, QHFileManagerType) {
    QHFileManagerTypeCache,
    QHFileManagerTypeOffline,
    QHFileManagerTypeTmp
};

@interface QHFileManager : NSObject

+ (instancetype)shareCacheFileInstance;
+ (instancetype)shareOfflineFileInstance;
+ (instancetype)shareTmpFileInstance;

- (instancetype)initWithType:(QHFileManagerType)type;

- (BOOL)createParentDirectoriesAtPath:(NSString *)path;
- (BOOL)parentDirectoriesExistAtPath:(NSString *)path;

///---------------------------------------------
/// @name Delete Files Method
///---------------------------------------------
- (BOOL)deleteFileAtPath:(NSString *)path;

///---------------------------------------------
/// @name Pares Parent Directory Of The Path Mehtod
///---------------------------------------------
- (NSString *)parseParentDirectoryAtPath:(NSString *)path;

///---------------------------------------------
/// @name Fetch Files Name
///---------------------------------------------
- (NSArray *)fileNamesInParentDirectory:(NSString *)path;

///---------------------------------------------
/// @name Sync Write File Method
///---------------------------------------------

- (BOOL)writeString:(NSString *)string atPath:(NSString *)path;
- (BOOL)writeString:(NSString *)string atPath:(NSString *)path expire:(NSTimeInterval)expire;

- (BOOL)writeData:(NSData *)data atPath:(NSString *)path;
- (BOOL)writeData:(NSData *)data atPath:(NSString *)path expire:(NSTimeInterval)expire;

- (BOOL)writeDictionary:(NSDictionary *)dictionary atPath:(NSString *)path;
- (BOOL)writeDictionary:(NSDictionary *)dictionary atPath:(NSString *)path expire:(NSTimeInterval)expire;

- (BOOL)writeArray:(NSArray *)array atPath:(NSString *)path;
- (BOOL)writeArray:(NSArray *)array atPath:(NSString *)path expire:(NSTimeInterval)expire;

- (BOOL)writeContent:(NSObject *)content atPath:(NSString *)path;
- (BOOL)writeContent:(NSObject *)content atPath:(NSString *)path expire:(NSTimeInterval)expire;

///---------------------------------------------
/// @name Sync Read File Method
///---------------------------------------------
- (NSString *)readStringAtPath:(NSString *)path;

- (NSDictionary *)readDictionaryAtPath:(NSString *)path;

- (NSData *)readDataAtPath:(NSString *)path;

- (NSArray *)readArrayAtPath:(NSString *)path;

- (NSObject *)readContentAtPath:(NSString *)path;

///---------------------------------------------
/// @name File Expire Method
///---------------------------------------------
- (void)setExpireTimeInterval:(NSTimeInterval)expireTimeInterval forFilePath:(NSString *)filePath;

- (BOOL)cleanExpireFile;

///-----------------------------------------------
/// @name Vaild File
///-----------------------------------------------
- (BOOL)fileExpiredAtFilePath:(NSString *)filePath;

- (BOOL)fileExistsAtFilePath:(NSString *)filePath;

- (BOOL)fileVaildAtFilePath:(NSString *)filePath;
@end
