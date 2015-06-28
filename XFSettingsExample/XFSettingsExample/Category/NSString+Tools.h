//
//  NSString+Tools.h
//  05-新浪微博
//
//  Created by apple on 14-8-21.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface NSString (Tools)

/**
 *  获取单行文本的size
 *
 *  @param fontSize fontSize
 *
 *  @return textSize
 */
- (CGSize)sizeOfFontSize:(CGFloat)fontSize;
/**
 *  获得多行文本的size
 *
 *  @param fontSize fontSize
 *  @param maxWidth maxWidth
 *
 *  @return textSize
 */
- (CGSize)sizeOfFontSize:(CGFloat)fontSize maxWidth:(CGFloat)maxWidth;
/**
 *  返回文件或目录的大小byte单位
 *
 *  @return fileSize 如果路径不存在返回0
 */
- (NSInteger)fileSize;
@end
