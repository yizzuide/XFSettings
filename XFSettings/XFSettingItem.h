//
//  XFSettingItem.h
//  XFSettings
//
//  Created by Yizzuide on 15/5/26.
//  Copyright (c) 2015年 Yizzuide. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    XFSettingPhaseTypeCellInit,
    XFSettingPhaseTypeCellInteracted
} XFSettingPhaseType;

typedef void(^SettingItemOptionBlock)(UITableViewCell *cell,XFSettingPhaseType phaseType,id intentData);

@interface XFSettingItem : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *icon;

@property (nonatomic, assign) Class relatedCellClass;

@property (nonatomic, copy) SettingItemOptionBlock optionBlock;


- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)settingItemWithDict:(NSDictionary *)dict;
+ (NSMutableArray *)settingItemsWithArray:(NSArray *)arr;
@end
