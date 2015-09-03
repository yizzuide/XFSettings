//
//  XFCellColorData.h
//  XFSettingsExample
//
//  Created by Yizzuide on 15/9/1.
//  Copyright (c) 2015年 Yizzuide. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XFCellAttrsData : NSObject
// Cell Color
@property (nonatomic, strong) UIColor *cellBackgroundColor;
@property (nonatomic, strong) UIColor *cellSelectedBackgroundColor;
@property (nonatomic, strong) UIView *cellBackgroundView;
@property (nonatomic, strong) UIView *cellSelectedBackgroundView;
// cell下线颜色
@property (nonatomic, strong) UIColor *cellBottomLineColor;

// Content
@property (nonatomic, strong) UIColor *contentTitleTextColor;
@property (nonatomic, strong) UIColor *contentDetailTextColor;
@property (nonatomic, strong) UIColor *contentInfoTextColor;
@property (nonatomic, assign) CGFloat contentTextMaxSize;
@property (nonatomic, assign) CGFloat contentIconSize;
@property (nonatomic, assign) CGFloat contentEachOtherPadding;



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
