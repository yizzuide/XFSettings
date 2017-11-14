//
//  XFCellColorData.h
//  XFSettings
//
//  Created by Yizzuide on 15/9/1.
//  Copyright (c) 2015年 Yizzuide. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    // 默认样式
    XFSettingStyleDefault,
    // 卡片样式
    XFSettingStyleCard,
} XFSettingStyle;

@interface XFCellAttrsData : NSObject
// Cell Color
@property (nonatomic, strong) UIColor *cellBackgroundColor;
@property (nonatomic, strong) UIColor *cellSelectedBackgroundColor;
@property (nonatomic, strong) UIView *cellBackgroundView;
@property (nonatomic, strong) UIView *cellSelectedBackgroundView;
/**
 *  是否允许选中单个Cell
 */
@property (nonatomic, assign) BOOL cellEnableRadioSelectStyle;
// cell下线颜色
@property (nonatomic, strong) UIColor *cellBottomLineColor;
/**
 *  显示满线
 */
@property (nonatomic, assign) BOOL cellFullLineEnable;

// Content
/**
 *  标题颜色
 */
@property (nonatomic, strong) UIColor *contentTitleTextColor;
/**
 *  详细文字颜色
 */
@property (nonatomic, strong) UIColor *contentDetailTextColor;
/**
 *  辅助文字颜色
 */
@property (nonatomic, strong) UIColor *contentInfoTextColor;
/**
 *  标题文字大小（其它文字会按个大小自动调整）
 */
@property (nonatomic, assign) CGFloat contentTextMaxSize;
/**
 *  设置图标大小
 */
@property (nonatomic, assign) CGFloat contentIconSize;
/**
 *  设置内容间距
 */
@property (nonatomic, assign) CGFloat contentEachOtherPadding;
/**
 *  禁止显示第一条线
 */
@property (nonatomic, assign) BOOL disableTopLine;
/**
 *  UITableView列表显示风格（注意：只适用于使用分类UIViewController+XFSettings.h方式）
 */
@property (nonatomic, assign) UITableViewStyle tableViewStyle;
/**
 * 设置列表样式
 */
@property (nonatomic, assign) XFSettingStyle settingStyle;
/**
 * 卡片样式下的外间距
 */
@property (nonatomic, assign) CGFloat cardSettingStyleMargin;
/**
 * 卡片样式下的圆角
 */
@property (nonatomic, assign) CGFloat cardSettingStyleCornerRadius;


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
