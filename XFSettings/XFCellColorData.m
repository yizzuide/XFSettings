//
//  XFCellColorData.m
//  XFSettingsExample
//
//  Created by Yizzuide on 15/9/1.
//  Copyright (c) 2015年 Yizzuide. All rights reserved.
//

#import "XFCellColorData.h"

@implementation XFCellColorData

+ (instancetype)cellColorDataWithBackgroundColor:(UIColor *)bgColor selBackgroundColor:(UIColor *)selBgColor {
    XFCellColorData *colData = [[XFCellColorData alloc] init];
    colData.cellBackgroundColor = bgColor;
    colData.cellSelectedBackgroundColor = selBgColor;
    return colData;
}

+ (instancetype)cellColorDataWithBackgroundView:(UIView *)bgView selBackgroundView:(UIView *)selBgView {
    XFCellColorData *colData = [[XFCellColorData alloc] init];
    colData.cellBackgroundView = bgView;
    colData.cellSelectedBackgroundView = selBgView;
    return colData;
}
@end
