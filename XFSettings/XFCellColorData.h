//
//  XFCellColorData.h
//  XFSettingsExample
//
//  Created by Yizzuide on 15/9/1.
//  Copyright (c) 2015年 Yizzuide. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XFCellColorData : NSObject
@property (nonatomic, strong) UIColor *cellBackgroundColor;
@property (nonatomic, strong) UIColor *cellSelectedBackgroundColor;
@property (nonatomic, strong) UIView *cellBackgroundView;
@property (nonatomic, strong) UIView *cellSelectedBackgroundView;

/**
 *  快速初始化一个CellColorData
 *
 *  @param bgColor    背景颜色
 *  @param selBgColor 背景选择颜色
 *
 */
+ (instancetype)cellColorDataWithBackgroundColor:(UIColor *)bgColor selBackgroundColor:(UIColor *)selBgColor;
/**
 *  快速初始化一个CellColorData
 *
 *  @param bgColor    背景视图
 *  @param selBgColor 背景选择视图
 *
 */
+ (instancetype)cellColorDataWithBackgroundView:(UIView *)bgView selBackgroundView:(UIView *)selBgView;
@end
