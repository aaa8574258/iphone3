//
//  FileOperation.m
//  XiaomiIOs
//
//  Created by linghang on 15-4-2.
//  Copyright (c) 2015年 wangjian. All rights reserved.
//

#import "FileOperation.h"
#import <AssetsLibrary/AssetsLibrary.h>
@implementation FileOperation
//获取某一个文件夹路径
+(NSString *)getDocuments:(NSString *)documentsFile{
    NSString *documentPath = [NSHomeDirectory() stringByAppendingString:@"/Documents"];
    NSString *filePath = [NSString stringWithFormat:@"%@/%@",documentPath,documentsFile];
    NSFileManager *manger = [NSFileManager defaultManager];
    if (![manger fileExistsAtPath:filePath]) {
        return nil;
    }
    return filePath;
}
//获取文件路径
+(NSString *)getPathFile:(NSString *)fileName andPath:(NSString *)path{
    NSString *documentPath = [NSHomeDirectory() stringByAppendingString:@"/Documents"];
    NSString *filePath = [NSString stringWithFormat:@"%@/%@",documentPath,path];
    NSString *finalPath = [NSString stringWithFormat:@"%@/%@",filePath,fileName];
    NSFileManager *manger = [NSFileManager defaultManager];
    if (![manger fileExistsAtPath:finalPath]) {
        return nil;
    }
    return finalPath;
}
//创建文件
+(NSString *)createFile:(NSString *)fileName andPath:(NSString *)path{
    NSString *documentPath = [NSHomeDirectory() stringByAppendingString:@"/Documents"];
#warning message documents
    NSLog(@"%@",documentPath);
    NSFileManager *manager = [NSFileManager defaultManager];
    BOOL isFileExist = [manager fileExistsAtPath:[NSString stringWithFormat:@"%@/%@",documentPath,path]];
    if (!isFileExist) {
        BOOL isFileCreateSuccessFile = [manager createDirectoryAtPath:[NSString stringWithFormat:@"%@/%@",documentPath,path] withIntermediateDirectories:YES attributes:nil error:nil];
        if (isFileCreateSuccessFile) {
            NSLog(@"Yes");
        }else{
            [manager createDirectoryAtPath:[NSString stringWithFormat:@"%@/%@",documentPath,path] withIntermediateDirectories:YES attributes:nil error:nil];
            NSLog(@"NO");
        }
    }
    NSString *filePath = [NSString stringWithFormat:@"%@/%@",documentPath,path];
    BOOL isFileNameExist = [manager fileExistsAtPath:[NSString stringWithFormat:@"%@/%@",filePath,fileName]];
    if (!isFileNameExist) {
        BOOL isFileNameSuccessFile = [manager createFileAtPath:[NSString stringWithFormat:@"%@/%@",filePath,fileName] contents:nil attributes:nil];
        if (!isFileNameSuccessFile) {
            [manager createFileAtPath:[NSString stringWithFormat:@"%@/%@",filePath,fileName] contents:nil attributes:nil];
        }
    }
    return [NSString stringWithFormat:@"%@/%@",filePath,fileName];
}
//向文件里存数据
+(void)storeDataFile:(NSString *)fileName andPath:(NSString *)path andFileData:(id)storeData{
    NSString *pathFile = [FileOperation createFile:fileName andPath:path];
#warning message pathFile
    NSLog(@"%@",pathFile);
    NSFileHandle *fileManger = [NSFileHandle fileHandleForUpdatingAtPath:pathFile];
    [fileManger writeData:storeData];
}
//从文件里读取数据
+(NSData *)readDataFile:(NSString *)fileName andPath:(NSString *)path{
    NSString *filePath = [FileOperation getPathFile:fileName andPath:path];
    if (filePath.length == 0) {
        return nil;
    }
    else{
        NSFileHandle *fileHanger = [NSFileHandle fileHandleForUpdatingAtPath:filePath];
        [fileHanger seekToFileOffset:0];
        NSData *data = [fileHanger readDataToEndOfFile];
        return data;
    }
}
//清空某一个文件
+(void)clearFile:(NSString *)fileName andPath:(NSString *)path{
    NSString *filePath = [FileOperation getPathFile:fileName andPath:path];
    if (filePath.length == 0) {
        return ;
    }
    NSFileManager *manger = [NSFileManager defaultManager];
    [manger removeItemAtPath:filePath error:nil];
}
//清空某一个文件夹
+(void)clearDocumentFile:(NSString *)documentName{
    NSString *documents = [FileOperation getDocuments:documentName];
    if (documents.length == 0) {
        return;
    }
    NSFileManager *manger = [NSFileManager defaultManager];
    NSArray *deepFileArr = [manger subpathsOfDirectoryAtPath:documents error:nil];
    for (NSInteger i = 0; i < deepFileArr.count; i++) {
        [manger removeItemAtPath:deepFileArr[i] error:nil];
    }
    [manger removeItemAtPath:documents error:nil];
}
#pragma mark 下边是通用的

//创建Cache文件
+(NSString *)createCacheFile:(NSString *)fileName andPath:(NSString *)path andDocument:(NSString *)document{
    NSFileManager *manager = [NSFileManager defaultManager];
    BOOL isFileExist = [manager fileExistsAtPath:[NSString stringWithFormat:@"%@/%@",document,path]];
    if (!isFileExist) {
        BOOL isFileCreateSuccessFile = [manager createDirectoryAtPath:[NSString stringWithFormat:@"%@/%@",document,path] withIntermediateDirectories:YES attributes:nil error:nil];
        if (isFileCreateSuccessFile) {
            NSLog(@"Yes");
        }else{
            [manager createDirectoryAtPath:[NSString stringWithFormat:@"%@/%@",document,path] withIntermediateDirectories:YES attributes:nil error:nil];
            NSLog(@"NO");
        }
    }
    NSString *filePath = [NSString stringWithFormat:@"%@/%@",document,path];
    BOOL isFileNameExist = [manager fileExistsAtPath:[NSString stringWithFormat:@"%@/%@",filePath,fileName]];
    if (!isFileNameExist) {
        BOOL isFileNameSuccessFile = [manager createFileAtPath:[NSString stringWithFormat:@"%@/%@",filePath,fileName] contents:nil attributes:nil];
        if (!isFileNameSuccessFile) {
            [manager createFileAtPath:[NSString stringWithFormat:@"%@/%@",filePath,fileName] contents:nil attributes:nil];
        }
    }
    return [NSString stringWithFormat:@"%@/%@",filePath,fileName];
}
//创建一个Cache在Document的下的一个文件
+(NSString *)createDirectory:(NSString *)fileName andDocument:(NSString *)document{
    NSFileManager *manager = [NSFileManager defaultManager];
    NSString *filePath = [NSString stringWithFormat:@"%@/%@",document,fileName];
    BOOL isFileNameExist = [manager fileExistsAtPath:[NSString stringWithFormat:@"%@/%@",document,filePath]];
    if (!isFileNameExist) {
        BOOL isFileNameSuccessFile = [manager createFileAtPath:[NSString stringWithFormat:@"%@/%@",document,filePath] contents:nil attributes:nil];
        if (!isFileNameSuccessFile) {
            [manager createFileAtPath:[NSString stringWithFormat:@"%@/%@",document,filePath] contents:nil attributes:nil];
        }
    }
    return [NSString stringWithFormat:@"%@/%@",document,filePath];
}

//获取Cache文件路径
+(NSString *)getCachePathFile:(NSString *)fileName andPath:(NSString *)path andDocument:(NSString *)document{
    NSString *filePath = [NSString stringWithFormat:@"%@/%@",document,path];
    NSString *finalPath = [NSString stringWithFormat:@"%@/%@",filePath,fileName];
    NSFileManager *manger = [NSFileManager defaultManager];
    if (![manger fileExistsAtPath:finalPath]) {
        return nil;
    }
    return finalPath;
}
//获取某一个Cache文件夹路径
+(NSString *)getCacheDocuments:(NSString *)documentsFile andDocument:(NSString *)document{
    NSString *filePath = [NSString stringWithFormat:@"%@/%@",document,documentsFile];
    NSFileManager *manger = [NSFileManager defaultManager];
    if (![manger fileExistsAtPath:filePath]) {
        return nil;
    }
    return filePath;
}
//向Cache文件存数据
+(void)storeCacheDataFile:(NSString *)fileName andPath:(NSString *)path andFileData:(id)storeData andDocument:(NSString *)document{
    NSString *pathFile = [FileOperation createCacheFile:fileName andPath:path andDocument:document];
#warning message pathFile
    NSLog(@"%@",pathFile);
    NSFileHandle *fileManger = [NSFileHandle fileHandleForUpdatingAtPath:pathFile];
    [fileManger writeData:storeData];
}
//从Cache文件里读数据
+(NSData *)readCacheDataFile:(NSString *)fileName andPath:(NSString *)path andDocument:(NSString *)document{
    NSString *filePath = [FileOperation getCachePathFile:fileName andPath:path andDocument:document];
    if (filePath.length == 0) {
        return nil;
    }
    else{
        NSFileHandle *fileHanger = [NSFileHandle fileHandleForUpdatingAtPath:filePath];
        [fileHanger seekToFileOffset:0];
        NSData *data = [fileHanger readDataToEndOfFile];
        return data;
    }
    
}
//清空Cache某一个文件
+(void)clearCacheFile:(NSString *)fileName andPath:(NSString *)path andDocument:(NSString *)document{
    NSString *filePath = [FileOperation getCachePathFile:fileName andPath:path andDocument:document];
    if (filePath.length == 0) {
        return ;
    }
    NSFileManager *manger = [NSFileManager defaultManager];
    [manger removeItemAtPath:filePath error:nil];
}
//清空Cache某一个文件夹
+(void)clearCacheDocumentFile:(NSString *)documentName andDocument:(NSString *)document{
    NSString *documents = [FileOperation getCacheDocuments:documentName andDocument:document];
    if (documents.length == 0) {
        return;
    }
    NSFileManager *manger = [NSFileManager defaultManager];
    NSArray *deepFileArr = [manger subpathsOfDirectoryAtPath:documents error:nil];
    for (NSInteger i = 0; i < deepFileArr.count; i++) {
        [manger removeItemAtPath:deepFileArr[i] error:nil];
    }
    [manger removeItemAtPath:documents error:nil];
}
//判断Cache某一个文件存不存在
+(BOOL)jugeFileExist:(NSString *)fileName andPath:(NSString *)path andDocument:(NSString *)document{
    NSString *filePath = [NSString stringWithFormat:@"%@/%@",document,path];
    NSString *finalPath = [NSString stringWithFormat:@"%@/%@",filePath,fileName];
    NSFileManager *manger = [NSFileManager defaultManager];
    if (![manger fileExistsAtPath:finalPath]) {
        return 0;
    }
    return 1;
}
//判断Cache某一个文件夹存不存在
+(BOOL)jugeFileExist:(NSString *)documentName andDocument:(NSString *)document{
    NSString *filePath = [NSString stringWithFormat:@"%@/%@",document,documentName];
    NSFileManager *manger = [NSFileManager defaultManager];
    if (![manger fileExistsAtPath:filePath]) {
        return 0;
    }
    return 1;
}
//向Cache直接下一层文件存数据
+(void)storeDrectoryCacheDataFile:(NSString *)fileName andFileData:(id)storeData andDocument:(NSString *)document{
    NSString *pathFile = [FileOperation createDirectory:fileName andDocument:document];
#warning message pathFile
    NSLog(@"%@",pathFile);
    NSFileHandle *fileManger = [NSFileHandle fileHandleForUpdatingAtPath:pathFile];
    [fileManger writeData:storeData];
}
//从Cache直接下一层文件里读数据
+(NSData *)readDrectoryCacheDataFile:(NSString *)fileName andDocument:(NSString *)document{
    NSString *filePath = [FileOperation getCacheDreatoryFile:fileName andDocument:document];
    if (filePath.length == 0) {
        return nil;
    }
    else{
        NSFileHandle *fileHanger = [NSFileHandle fileHandleForUpdatingAtPath:filePath];
        [fileHanger seekToFileOffset:0];
        NSData *data = [fileHanger readDataToEndOfFile];
        return data;
    }
    
}
//从cache读取直接一个文件路径
+(NSString *)getCacheDreatoryFile:(NSString *)fileName andDocument:(NSString *)document{
    NSString *filePath = [NSString stringWithFormat:@"%@/%@",document,fileName];
    
    NSFileManager *manger = [NSFileManager defaultManager];
    if (![manger fileExistsAtPath:filePath]) {
        return nil;
    }
    return filePath;
}
//创建一个文件夹
+(NSString *)createCacheDocument:(NSString *)folderPath andDocument:(NSString *)document{
    NSFileManager *manger = [NSFileManager defaultManager];
    BOOL isFileExist = [manger fileExistsAtPath:[NSString stringWithFormat:@"%@/%@",document,folderPath]];
    NSLog(@"%d",isFileExist);
    //2.2判断bool值，为NO的时候，创建文件
    if (isFileExist == NO) {
        BOOL isFileCreateSuccess =  [manger createDirectoryAtPath:[NSString stringWithFormat:@"%@/%@",document,folderPath] withIntermediateDirectories:YES attributes:nil error:nil];
        if (isFileCreateSuccess) {
            NSLog(@"yes");
            
        }
        else{
            NSLog(@"no");
            return nil;
        }
    }
    return [NSString stringWithFormat:@"%@/%@",document,folderPath];
    
}
//返回文件Url
+(NSString *)returnUrl:(NSString *)imageName{
    return nil;
}
//把沙盒中的路径转化成路径
+(void)tranlateAssertUrl:(NSURL *)imageUrl{
    ALAssetsLibrary *assetsLibary = [[ALAssetsLibrary alloc] init];
    ALAssetsLibraryAssetForURLResultBlock resultsBlock = ^(ALAsset *asset){
        ALAssetRepresentation *representation = [asset defaultRepresentation];
        CGImageRef image = [representation fullScreenImage];
        //[UIImage imageWithCGImage:image];
        //self.imageView.image = [UIImage imageWithCGImage:image];
    };
    ALAssetsLibraryAccessFailureBlock failureBlock = ^(NSError *error){
        /*  A failure here typically indicates that the user has not allowed this app access
         to location data. In that case the error code is ALAssetsLibraryAccessUserDeniedError.
         In principle you could alert the user to that effect, i.e. they have to allow this app
         access to location services in Settings > General > Location Services and turn on access
         for this application.
         */
        NSLog(@"FAILED! due to error in domain %@ with error code %d", error.domain, error.code);
        abort();
    };
    [assetsLibary assetForURL:imageUrl resultBlock:resultsBlock failureBlock:failureBlock];
}
@end
