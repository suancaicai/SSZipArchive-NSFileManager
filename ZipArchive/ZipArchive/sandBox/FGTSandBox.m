//
//  MPSandBox.m
//  ZipArchive
//
//  Created by yumingming on 16/3/4.
//  Copyright © 2016年 MM. All rights reserved.
//

#import "FGTSandBox.h"

@implementation FGTSandBox


+ (NSString *)documentPath {
    return NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
}

+ (NSString *)libraryPath {
    return NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0];
}

+ (NSString *)cachePath {
    return NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
}

+ (NSString *)preferencePath {
    return [[self libraryPath] stringByAppendingPathComponent:@"Preferences"];
}

+ (NSString *)applicationSupportPath {
    return NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES)[0];
}

+ (NSString *)tempPath {
    return NSTemporaryDirectory();
}


+ (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL{
    
    NSError *error = nil;
    BOOL success = [URL setResourceValue: [NSNumber numberWithBool: YES]
                                  forKey: NSURLIsExcludedFromBackupKey
                                   error: &error];
    if(!success){
        NSLog(@"Error excluding %@ from backup %@", [URL lastPathComponent], error);
    }
    
    return success;
}


@end


@implementation FGTSandBox (FGTApplication)

+ (NSString *)appPath
{
    return [[self documentPath] stringByAppendingPathComponent:@"app"];
}

+ (NSString *)fidgetPath
{
    return [[self appPath] stringByAppendingPathComponent:@"application"];
}

+ (NSString *)pathForFileName:(NSString *)fileName underPath:(NSString *)path;
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *filePath = [path stringByAppendingPathComponent:fileName];
    if ([fileManager fileExistsAtPath:filePath]) {
        return filePath;
    } else {
        NSArray *subPaths = [fileManager subpathsOfDirectoryAtPath:path error:nil];
        for (NSString *string in subPaths) {
            NSString *subPath = [path stringByAppendingPathComponent:string];
            filePath = [self pathForFileName:fileName underPath:subPath];
            if (filePath) {
                return filePath;
            }
        }
    }
    return nil;
}

@end
