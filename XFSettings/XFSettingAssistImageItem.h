//
//  XFSettingAssistImageItem.h
//  XFSettings
//
//  Created by 付星 on 15/9/2.
//  Copyright (c) 2015年 Yizzuide. All rights reserved.
//

#import "XFSettingArrowItem.h"

@interface XFSettingAssistImageItem : XFSettingArrowItem
@property (nonatomic, copy) NSString *detailText;
@property (nonatomic, copy) NSString *assistImageName;
@property (nonatomic, strong) UIImage *assistImage;
@property (nonatomic, strong) NSNumber *assistImageContentMode;
@property (nonatomic, strong) NSNumber *assistImageMargin;
@property (nonatomic, strong) NSNumber *assistImageRenderRadii;
@end
