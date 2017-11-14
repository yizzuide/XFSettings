//
//  XFSettingItem.m
//  XFSettings
//
//  Created by Yizzuide on 15/5/26.
//  Copyright (c) 2015年 Yizzuide. All rights reserved.
//

#import "XFSettingItem.h"
#import "XFSettingArrowItem.h"

@implementation XFSettingItem
{
    BOOL _firstIndex;
    BOOL _lastIndex;
}

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)settingItemWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

+ (NSMutableArray *)settingItemsWithArray:(NSArray *)arr
{
    NSMutableArray *mArr = [NSMutableArray array];
    NSInteger count = arr.count;
    [arr enumerateObjectsUsingBlock:^(NSDictionary *item, NSUInteger idx, BOOL *stop) {
        // 创建到一个可变数组
        NSMutableDictionary *mItem= [item mutableCopy];
        
        XFSettingItem *instance = nil;
        
        // 如果是自定型子类
        if(item[@"itemClass"]){
            // 从可变数组中删除这个key,因为要实例化的类没有这个key会报错
            [mItem removeObjectForKey:@"itemClass"];
            // 创建对应的子类,传入这些可KVC的key到它的初始化方法
            instance = [[item[@"itemClass"] alloc] initWithDict:mItem];
            [mArr addObject:instance];
        }else{
            // 创建默认
            instance = [[self alloc] initWithDict:item];
            [mArr addObject:instance];
        }
        // 判断是否是第一个item,作为标记
        if (idx == 0) {
            instance->_firstIndex = YES;
        }
        if (idx == count - 1) {
            instance->_lastIndex = YES;
        }
        if (count == 1) {
            instance->_lastIndex = YES;
        }
    }];
    return mArr;
}

- (BOOL)isFirst {
    return self->_firstIndex;
}
- (BOOL)isLast
{
    return self->_lastIndex;
}
@end
