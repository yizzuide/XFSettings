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
    [arr enumerateObjectsUsingBlock:^(NSDictionary *item, NSUInteger idx, BOOL *stop) {
        // 创建到一个可变数组
        NSMutableDictionary *mItem= [item mutableCopy];
        // 如果是自定型子类
        if(item[@"itemClass"]){
            // 从可变数组中删除这个key,因为要实例化的类没有这个key会报错
            [mItem removeObjectForKey:@"itemClass"];
            // 创建对应的子类,传入这些可KVC的key到它的初始化方法
            [mArr addObject:[[item[@"itemClass"] alloc] initWithDict:mItem]];
        }else{
            // 创建默认
            [mArr addObject:[[self alloc] initWithDict:item]];
        }
    }];
    return mArr;
}
@end
