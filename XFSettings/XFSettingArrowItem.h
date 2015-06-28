//
//  XFSettingArrowItem.h
//  XFSettings
//
//  Created by Yizzuide on 15/5/26.
//  Copyright (c) 2015年 Yizzuide. All rights reserved.
//

#import "XFSettingItem.h"

/**
 *  用于跳转控制器
 */
@interface XFSettingArrowItem : XFSettingItem

// 跳转的目标控制器
@property (nonatomic, assign) Class destVCClass;
@end
