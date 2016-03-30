//
//  ViewController.m
//  ZipArchive
//
//  Created by yumingming on 16/3/4.
//  Copyright © 2016年 MM. All rights reserved.
//

#import "ViewController.h"
#import "FGTSandBox.h"
#import <SSZipArchive/SSZipArchive.h>

@interface ViewController ()<SSZipArchiveDelegate>

@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];

    NSFileManager * manager = [NSFileManager defaultManager];
    NSError * error = nil;
    NSString *testZipPath = [[NSBundle mainBundle] pathForResource:@"testZip" ofType:@"zip"];
    BOOL unzipResult= [SSZipArchive unzipFileAtPath:testZipPath toDestination:[FGTSandBox fidgetPath]];
    if (unzipResult) {
    }

    //解压新文件的地址
    NSString *ResPath = [[NSBundle mainBundle] pathForResource:@"Res" ofType:@"zip"];
    BOOL unzipResultNew = [SSZipArchive unzipFileAtPath:ResPath toDestination:[FGTSandBox fidgetPath]];
    if (unzipResultNew) {
    }

    //解压原文件的地址
    NSString *testFilePath = [FGTSandBox pathForFileName:@"testZip" underPath:[FGTSandBox fidgetPath]];
    NSLog(@"testFilePath:%@",testFilePath);
    NSString *testPath = [self appendString:testFilePath];
    NSArray *testFileNames = [manager contentsOfDirectoryAtPath:testFilePath error:&error];



    NSString *resPathString = [FGTSandBox pathForFileName:@"Res" underPath:[FGTSandBox fidgetPath]];
    NSString *resHaxPathString = [self appendString:resPathString];
    NSArray *resFileNames = [manager contentsOfDirectoryAtPath:resPathString error:&error];

    for (NSString *resNametring in resFileNames) {
        //res 的完整路径
        NSString *ResCompath = [self appendFullPathHaxString:resHaxPathString sufString:resNametring];
        //非常重要的一步 想要copy过去必需把路径和到另一个文件夹里的名字写好，名字不能改变
        NSString *resCopyPath = [self appendFullPathHaxString:testPath sufString:resNametring];

        for (NSInteger i = 0; i < testFileNames.count; i++) {
              //testZip的原文件完整路径
               NSString *compath = [self appendFullPathHaxString:testPath sufString:testFileNames[i]];

            if ([resNametring isEqualToString: testFileNames[i]]) {
                //把相同文件名的路径删除
                [manager removeItemAtPath:compath error:&error];
                //copy新的文件到路径中 覆盖源文件 名字不能改变
                [manager copyItemAtPath:ResCompath toPath:resCopyPath error:&error];
            }
            else
            {
                [manager copyItemAtPath:ResCompath toPath:resCopyPath error:&error];
            }
        }
    }
    //完成后把新文件夹路径删除
    [manager removeItemAtPath:resPathString error:&error];


    NSLog(@"testFilePath:%@",testFilePath);

}

//拼接路径
-(NSString*)appendString:(NSString *)str{
    NSString *createPath = [str stringByAppendingString:@"/"];;
    return createPath;
}
//每个文件的完整路径
-(NSString *)appendFullPathHaxString:(NSString*)haxString sufString:(NSString *)str{
    NSString *fullPath = [haxString stringByAppendingString:str];
    return fullPath;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
