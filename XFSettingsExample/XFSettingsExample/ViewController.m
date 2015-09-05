//
//  ViewController.m
//  XFSettingsExample
//
//  Created by Yizzuide on 15/6/28.
//  Copyright © 2015年 Yizzuide. All rights reserved.
//

#import "ViewController.h"
#import "NSString+Tools.h"
#import "UpdateViewController.h"
#import "XFNewFriendViewController.h"

@interface ViewController ()<XFSettingTableViewDataSource>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"设置";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.dataSource = self;
    
    // set cell attrs
    XFCellAttrsData *cellAttrsData = [XFCellAttrsData cellColorDataWithBackgroundColor:[UIColor whiteColor] selBackgroundColor:[UIColor colorWithWhite:0 alpha:0.4]];
    // 设置图标大小
    cellAttrsData.contentIconSize = 20;
    // 设置内容间距
    cellAttrsData.contentEachOtherPadding = 15;
    // cell 线条颜色
    cellAttrsData.cellBottomLineColor = [UIColor purpleColor];
    // 显示填充整个cell宽度画线
    cellAttrsData.cellFullLineEnable = YES;
    // 标题文字大小（其它文字会按个大小自动调整）
    cellAttrsData.contentTextMaxSize = 13;
    // 标题颜色
    cellAttrsData.contentTitleTextColor = [UIColor purpleColor];
    // 详细文字颜色
    cellAttrsData.contentDetailTextColor = [UIColor blueColor];
    // 辅助文字颜色
    cellAttrsData.contentInfoTextColor = [UIColor brownColor];
    self.cellAttrsData = cellAttrsData;
    
}

- (NSArray *)settingItems
{
    return @[ // groupArr
             @{ // groupModel
                 XFSettingGroupHeader: @"基本信息",
                 XFSettingGroupItems : @[ // items
                         @{ // itemModel
                             XFSettingItemTitle: @"我的朋友",
                             XFSettingItemIcon : @"1435582804_group",
                             XFSettingItemClass : [XFSettingInfoItem class], // 这个字段用于判断是否有右边辅助功能的cell,不写则没有
                             XFSettingItemAttrDetailText : @"你的好友",
                             XFSettingItemRelatedCellClass:[XFSettingInfoDotCell class],// 自定义的cell
                            XFSettingItemDestViewControllerClass : [XFNewFriendViewController class], // 如果有目标控制器
                             XFSettingOptionActionBlock : ^(XFSettingInfoDotCell *cell,XFSettingPhaseType phaseType,id intentData){ // 如果有可选的操作
                                 if (phaseType == XFSettingPhaseTypeCellInteracted) {
                                     cell.rightInfoLabel.hidden = YES;
                                 }
                             }
                             },// end itemModel
                         @{
                             XFSettingItemTitle: @"我的消息",
                             XFSettingItemIcon : @"1435527299_message",
                             XFSettingItemClass : [XFSettingInfoItem class],                              XFSettingItemAttrDetailText : @"新的好友",
                             XFSettingItemAttrRightInfo : @"3",
                             XFSettingItemRelatedCellClass:[XFSettingInfoCountCell class],
                             XFSettingOptionActionBlock : ^(XFSettingInfoCountCell *cell,XFSettingPhaseType phaseType,id intentData){
                                 // 交互时处理
                                 if (phaseType == XFSettingPhaseTypeCellInteracted) {
                                     int count = cell.rightInfoLabel.text.intValue;
                                     cell.rightInfoLabel.text = [NSString stringWithFormat:@"%d",++count];
                                 }
                             }
                             },
                         @{
                             XFSettingItemTitle: @"缓存大小",
                             XFSettingItemIcon : @"1435529531_CD-DVD Drive-2",
                             XFSettingItemClass : [XFSettingInfoItem class],
                             XFSettingItemAttrDetailText : @"cache",
                             XFSettingItemAttrRightInfo : @"正在计算",
                             XFSettingItemRelatedCellClass:[XFSettingInfoCell class],
                             XFSettingOptionActionBlock : ^(XFSettingInfoCell *cell,XFSettingPhaseType phaseType,id intentData){
                                
                                 [self cacheDirClear:cell phaseType:phaseType];
                             }
                             },
                         @{
                             XFSettingItemTitle: @"保存我的设置",
                             XFSettingItemIcon : @"1435527366_1-8",
                             XFSettingItemClass : [XFSettingSwitchItem class],
                             XFSettingOptionActionBlock : ^(XFSettingCell *cell,XFSettingPhaseType phaseType,id intentData){
                                 
                                 if (phaseType == XFSettingPhaseTypeCellInteracted) {
                                     if ([intentData[XFSettingIntentDataSwitchOn] boolValue]) {
                                         NSLog(@"%@", @"保存");
                                     }else{
                                         NSLog(@"%@", @"取消保存");
                                     }
                                 }
                             }
                             },
                         @{
                             XFSettingItemTitle: @"检测新版本",
                             XFSettingItemIcon : @"1435529156_cloud-arrow-up",
                             // 使用自定义向右箭头
                             XFSettingItemArrowIcon : @"CellArrow",
                             XFSettingItemClass : [XFSettingInfoItem class],
                             XFSettingItemRelatedCellClass:[XFSettingInfoCell class],
                             XFSettingItemAttrRightInfo : @"有新版本！",
                             XFSettingItemDestViewControllerClass : [UpdateViewController class],
                             XFSettingOptionActionBlock : ^(XFSettingInfoCell *cell,XFSettingPhaseType phaseType,id intentData){
                                 // 自定义初始化样式
                                 if (phaseType == XFSettingPhaseTypeCellInit) {
                                     cell.rightInfoLabel.textColor = [UIColor orangeColor];
                                     cell.rightInfoLabel.font = [UIFont systemFontOfSize:10];
                                 }
                             }
                             },
                         /*@{
                             XFSettingItemTitle: @"vip帮助",
                             XFSettingItemIcon : @"1435529211_circle_help_question-mark",
                             XFSettingOptionActionBlock : ^(XFSettingCell *cell,XFSettingPhaseType phaseType,id intentData){
                                 
                                 
                             }
                             }*/
                         @{
                             XFSettingItemTitle: @"vip帮助",
                             XFSettingItemIcon : @"1435529211_circle_help_question-mark",
                             XFSettingItemAttrDetailText : @"帮助文档",
                             XFSettingItemAttrAssistImageName : @"picture_download",
                             XFSettingItemClass : [XFSettingAssistImageItem class],
                             XFSettingItemRelatedCellClass:[XFSettingAssistImageCell class]
                             },
                         ],
                 XFSettingGroupFooter : @"lalala~"
                 }// end groupModel
             ];// endgroupArr
}

// 删除cache目录
- (void)cacheDirClear:(XFSettingInfoCell *)cell phaseType:(XFSettingPhaseType)phaseType
{
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString *cachePath =[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)  lastObject];
    
    switch (phaseType) {
        case XFSettingPhaseTypeCellInit:{
            
            NSInteger totalSize = [cachePath fileSize];
            double size = totalSize / 1000.0 / 1000.0; // MaxOS和IOS以1000为单位计算
            cell.rightInfoLabel.text = [NSString stringWithFormat:@"%.1fM",size];
        }
            break;
            
        case XFSettingPhaseTypeCellInteracted:{
            NSString *info = cell.rightInfoLabel.text;
            if ([info isEqualToString:@"0.0M"]) return;
            
            cell.rightInfoLabel.text = @"正在清理中...";
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                
                // 直接删除目录
                [fm removeItemAtPath:cachePath error:nil];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    cell.rightInfoLabel.text = @"0.0M";
                    cell.detailTextLabel.text = @"清理完成";
                });
            });
        }
            break;
    }
    
}

@end
