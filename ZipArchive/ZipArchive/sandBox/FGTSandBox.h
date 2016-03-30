//
//  MPSandBox.h
//  ZipArchive
//
//  Created by yumingming on 16/3/4.
//  Copyright © 2016年 MM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FGTSandBox : NSObject

+ (NSString *)documentPath;             // 文档目录，需要ITUNES同步备份的数据存这里
+ (NSString *)libraryPath;              // 配置目录，配置文件存这里
+ (NSString *)applicationSupportPath;   //
+ (NSString *)cachePath;                // 缓存目录，系统永远不会删除这里的文件，ITUNES会删除
+ (NSString *)tempPath;                 // 缓存目录，APP退出后，系统可能会删除这里的内容
+ (NSString *)preferencePath;

+ (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL;

@end

@interface FGTSandBox (FGTApplication)

+ (NSString *)appPath;      //Documents/app/

+ (NSString *)fidgetPath;   //Documents/app/application/

+ (NSString *)pathForFileName:(NSString *)fileName underPath:(NSString *)path;

@end
