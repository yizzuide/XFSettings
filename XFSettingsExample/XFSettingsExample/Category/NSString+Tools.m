//
//  NSString+Tools.m
//  XFSetting
//
//  Created by apple on 14-8-21.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "NSString+Tools.h"

@implementation NSString (Tools)

- (CGSize)sizeOfFontSize:(CGFloat)fontSize
{
    return [self sizeOfFontSize:fontSize maxWidth:MAXFLOAT];
}
- (CGSize)sizeOfFontSize:(CGFloat)fontSize maxWidth:(CGFloat)maxWidth
{
    
    return [self boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{
                                                                                                                                NSFontAttributeName : [UIFont systemFontOfSize:fontSize]
                                                                                                                                } context:nil].size;
   
}


- (NSInteger)fileSize
{
    NSFileManager *mgr = [NSFileManager defaultManager];
    // 判断是否为文件
    BOOL dir = NO;
    BOOL exists = [mgr fileExistsAtPath:self isDirectory:&dir];
    // 文件\文件夹不存在
    if (exists == NO) return 0;
    
    if (dir) { // self是一个文件夹
        // 这个方法只会遍历直接内容(一级深度内容)
        //        [mgr contentsOfDirectoryAtPath:self error:nil];
        // 遍历caches里面的所有内容 --- 直接和间接内容
        NSArray *subpaths = [mgr subpathsAtPath:self];
        NSInteger totalByteSize = 0;
        for (NSString *subpath in subpaths) {
            // 获得全路径
            NSString *fullSubpath = [self stringByAppendingPathComponent:subpath];
            // 判断是否为文件
            BOOL dir = NO;
            [mgr fileExistsAtPath:fullSubpath isDirectory:&dir];
            if (dir == NO) { // 文件
                totalByteSize += [[mgr attributesOfItemAtPath:fullSubpath error:nil][NSFileSize] integerValue];
            }
        }
        return totalByteSize;
    } else { // self是一个文件
        return [[mgr attributesOfItemAtPath:self error:nil][NSFileSize] integerValue];
    }
}

@end
