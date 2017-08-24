//
//  FileOperation.h
//  XiaomiIOs
//
//  Created by linghang on 15-4-2.
//  Copyright (c) 2015年 wangjian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileOperation : NSObject
//获取某一个文件夹路径
+(NSString *)getDocuments:(NSString *)documentsFile;
//获取文件路径
+(NSString *)getPathFile:(NSString *)fileName andPath:(NSString *)path;
//创建文件
+(NSString *)createFile:(NSString *)fileName andPath:(NSString *)path;
//向文件存数据
+(void)storeDataFile:(NSString *)fileName andPath:(NSString *)path andFileData:(id)storeData;
//从文件里读数据
+(NSData *)readDataFile:(NSString *)fileName andPath:(NSString *)path;
//清空某一个文件
+(void)clearFile:(NSString *)fileName andPath:(NSString *)path;
//清空某一个文件夹
+(void)clearDocumentFile:(NSString *)documentName;
//从文件里读数据
+(NSData *)readDataFile:(NSString *)fileName andPath:(NSString *)path;
//清空某一个文件
+(void)clearFile:(NSString *)fileName andPath:(NSString *)path;
//清空某一个文件夹
+(void)clearDocumentFile:(NSString *)documentName;
//以下为cache的表
//获取某一个Cache文件夹路径
+(NSString *)getCacheDocuments:(NSString *)documentsFile andDocument:(NSString *)document;
//创建Cache文件
+(NSString *)createCacheFile:(NSString *)fileName andPath:(NSString *)path andDocument:(NSString *)document;
//创建一个Cache在Document的下的一个文件
+(NSString *)createDirectory:(NSString *)fileName andDocument:(NSString *)document;
//获取Cache文件路径
+(NSString *)getCachePathFile:(NSString *)fileName andPath:(NSString *)path andDocument:(NSString *)document;
//获取某一个Cache文件夹路径
+(NSString *)getCacheDocuments:(NSString *)documentsFile andDocument:(NSString *)document;
//向Cache文件存数据
+(void)storeCacheDataFile:(NSString *)fileName andPath:(NSString *)path andFileData:(id)storeData andDocument:(NSString *)document;
//从Cache文件里读数据
+(NSData *)readCacheDataFile:(NSString *)fileName andPath:(NSString *)path andDocument:(NSString *)document;
//清空Cache某一个文件
+(void)clearCacheFile:(NSString *)fileName andPath:(NSString *)path andDocument:(NSString *)document;
//清空Cache某一个文件夹
+(void)clearCacheDocumentFile:(NSString *)documentName andDocument:(NSString *)document;
//判断Cache某一个文件存不存在
+(BOOL)jugeFileExist:(NSString *)fileName andPath:(NSString *)path andDocument:(NSString *)document;
//判断Cache某一个文件夹存不存在
+(BOOL)jugeFileExist:(NSString *)documentName andDocument:(NSString *)document;
//向Cache直接下一层文件存数据
+(void)storeDrectoryCacheDataFile:(NSString *)fileName andFileData:(id)storeData andDocument:(NSString *)document;
//从Cache直接下一层文件里读数据
+(NSData *)readDrectoryCacheDataFile:(NSString *)fileName andDocument:(NSString *)document;
//从cache读取直接一个文件路径
+(NSString *)getCacheDreatoryFile:(NSString *)fileName andDocument:(NSString *)document;
//创建一个文件夹
+(NSString *)createCacheDocument:(NSString *)folderPath andDocument:(NSString *)document;
//把沙盒中的路径转化成路径
+(void)tranlateAssertUrl:(NSURL *)imageUrl;

@end
