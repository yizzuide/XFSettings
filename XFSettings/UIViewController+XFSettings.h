//
//  UIViewController+XFSettings.h
//  XFSettingsExample
//
//  Created by 付星 on 16/6/22.
//  Copyright © 2016年 Yizzuide. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XFCellAttrsData;
@protocol XFSettingTableViewDataSource;

@interface UIViewController (XFSettings) <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, weak) id<XFSettingTableViewDataSource> dataSource;
@property (nonatomic, strong) NSMutableArray *settingGroups;
@property (nonatomic, strong) XFCellAttrsData *cellAttrsData;

/**
 *  建立配置设置
 */
- (void)xf_setup;

@end
