//
//  UIViewController+XFSettings.m
//  XFSettingsExample
//
//  Created by 付星 on 16/6/22.
//  Copyright © 2016年 Yizzuide. All rights reserved.
//

#import "UIViewController+XFSettings.h"
#import <objc/runtime.h>
#import "XFSettings.h"

@implementation UIViewController (XFSettings)

static void * xfSettings_TableView = (void *)@"xfSettings_TableView";
static void * xfSettings_DataSource = (void *)@"xfSettings_DataSource";
static void * xfSettings_SettingGroups = (void *)@"xfSettings_SettingGroups";
static void * xfSettings_cellAttrsData = (void *)@"xfSettings_cellAttrsData";

- (void)setTableView:(UITableView *)tableView
{
    objc_setAssociatedObject(self, &xfSettings_TableView, tableView, OBJC_ASSOCIATION_ASSIGN);
}

- (UITableView *)tableView
{
    UITableView *view = objc_getAssociatedObject(self, &xfSettings_TableView);
    if(!view){
        UITableViewStyle style = self.cellAttrsData.tableViewStyle;
        view = [[UITableView alloc] initWithFrame:self.view.frame style:style];
        [self.view addSubview:view];
        [self setTableView:view];
        return view;
    }
    return view;
}

- (void)setDataSource:(id<XFSettingTableViewDataSource>)dataSource
{
    objc_setAssociatedObject(self, &xfSettings_DataSource, dataSource, OBJC_ASSOCIATION_ASSIGN);
}

- (id<XFSettingTableViewDataSource>)dataSource
{
    return objc_getAssociatedObject(self, &xfSettings_DataSource);
}

- (void)setSettingGroups:(NSMutableArray *)settingGroups
{
    objc_setAssociatedObject(self, &xfSettings_SettingGroups, settingGroups, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSMutableArray *)settingGroups
{
    NSMutableArray *groups = objc_getAssociatedObject(self, &xfSettings_SettingGroups);
    if (groups == nil) {
        NSArray *source = [self.dataSource settingItems];
        groups = [XFSettingGroup settingGroupsWithArray:source];
        [self setSettingGroups:groups];
        
        // 是否取消系统划线
        if (self.cellAttrsData.cellFullLineEnable) {
            self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        }
    }
    return groups;
}

- (void)setCellAttrsData:(XFCellAttrsData *)cellAttrsData
{
    objc_setAssociatedObject(self, &xfSettings_cellAttrsData, cellAttrsData, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (XFCellAttrsData *)cellAttrsData
{
    return objc_getAssociatedObject(self, &xfSettings_cellAttrsData);
}

- (void)xf_setup
{
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.settingGroups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.settingGroups[section] items].count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // cell的模型
    XFSettingItem *item = [self.settingGroups[indexPath.section] items][indexPath.row];
    // 显示的cell
    XFSettingCell *cell;
    // 如果有自定义的cell类型
    if (item.relatedCellClass) {
        cell = [item.relatedCellClass settingCellWithTalbeView:tableView cellColorData:self.cellAttrsData];
    }else{ // 使用默认类型
        cell = [XFSettingCell settingCellWithTalbeView:tableView cellColorData:self.cellAttrsData];
    }
    // 绑定item
    cell.item = item;
    
    return cell;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.settingGroups[section] header];
    
}
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    return [self.settingGroups[section] footer];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 取消选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    XFSettingItem *item = [self.settingGroups[indexPath.section] items][indexPath.row];
    // 如果有操作要执行
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell.selectionStyle != UITableViewCellSelectionStyleNone) {
        if (item.optionBlock) {
            item.optionBlock([tableView cellForRowAtIndexPath:indexPath],XFSettingPhaseTypeCellInteracted,nil);
        }
    }
    
    
    // 如果是有第二级控制器显示类型
    if ([item isKindOfClass:[XFSettingArrowItem class]]) {
        XFSettingArrowItem *arrowItem = (XFSettingArrowItem *)item;
        Class vcClass = ((XFSettingArrowItem *)arrowItem).destVCClass ;
        if (vcClass) {
            // 通过Class生成对象，如果这个对象不是控制器直接返回
            id object = [[vcClass alloc] init];
            if (![object isKindOfClass:[UIViewController class]]) {
                return;
            }
            UIViewController *controller = object;
            
            // 是否带有参数
            id<XFSettingIntentUserInfo> intent = (id<XFSettingIntentUserInfo>)controller;
            if (arrowItem.destVCUserInfo) {
                if([intent respondsToSelector:@selector(setUserInfo:)])
                    intent.userInfo = arrowItem.destVCUserInfo;
            }
            
            // 设置标题
            controller.title = arrowItem.title;
            
            [self.navigationController pushViewController:controller animated:YES];
        }
    }
}

@end
