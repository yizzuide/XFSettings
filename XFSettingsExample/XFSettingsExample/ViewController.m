//
//  ViewController.m
//  XFSettingsExample
//
//  Created by Yizzuide on 15/6/28.
//  Copyright © 2015年 Yizzuide. All rights reserved.
//

#import "ViewController.h"
#import "NSString+Tools.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"设置";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.dataSource = self;
}

- (NSArray *)baseSettingItems
{
    return @[ // groupArr
             @{ // groupModel
                 XFSettingGroupHeader: @"基本信息",
                 XFSettingGroupItems : @[ // items
                         @{ // itemModel
                             XFSettingItemTitle: @"我的消息",
                             XFSettingItemIcon : @"1435527299_message",
                             XFSettingItemClass : [XFSettingInfoItem class], // 这个字段用于判断是否有右边辅助功能的cell,不写则没有
                             XFSettingItemAttrDetailText : @"新的好友",
                             XFSettingItemAttrRightInfo : @"3",
                             XFSettingItemRelatedCellClass:[XFSettingInfoCountCell class],// 自定义的cell
                             //                             XFSettingItemDestViewControllerClass : [destVCClass class], // 如果有目标控制器
                             XFSettingOptionActionBlock : ^(XFSettingInfoCountCell *cell,XFSettingPhaseType phaseType,id intentData){ // 如果有可选的操作
                                 if (phaseType == XFSettingPhaseTypeCellInteracted) {
                                     int count = cell.rightInfoLabel.text.intValue;
                                     cell.rightInfoLabel.text = [NSString stringWithFormat:@"%d",++count];
                                 }
                             }
                             },// end itemModel
                         @{ // itemModel
                             XFSettingItemTitle: @"缓存大小",
                             XFSettingItemIcon : @"1435529531_CD-DVD Drive-2",
                             XFSettingItemClass : [XFSettingInfoItem class], // 这个字段用于判断是否有右边辅助功能的cell,不写则没有
                             XFSettingItemAttrDetailText : @"cache",
                             XFSettingItemAttrRightInfo : @"正在计算",
                             XFSettingItemRelatedCellClass:[XFSettingInfoCell class],// 自定义的cell
                             //                             XFSettingItemDestViewControllerClass : [destVCClass class], // 如果有目标控制器
                             XFSettingOptionActionBlock : ^(XFSettingInfoCell *cell,XFSettingPhaseType phaseType,id intentData){ // 如果有可选的操作
                                 //                                 [self cacheAction:cell phaseType:phaseType];
                                 [self cacheDirClear:cell phaseType:phaseType];
                             }
                             },// end itemModel
                         @{ // itemModel
                             XFSettingItemTitle: @"保存我的设置",
                             XFSettingItemIcon : @"1435527366_1-8",
                             XFSettingItemClass : [XFSettingSwitchItem class], // 这个字段用于判断是否有右边辅助功能的cell,不写则没有
                             XFSettingOptionActionBlock : ^(XFSettingCell *cell,XFSettingPhaseType phaseType,id intentData){ // 如果有可选的操作
                                 
                                 if (phaseType == XFSettingPhaseTypeCellInteracted) {
                                     if ([intentData[XFSettingIntentDataSwitchOn] boolValue]) {
                                         NSLog(@"%@", @"保存");
                                     }else{
                                         NSLog(@"%@", @"取消保存");
                                     }
                                 }
                             }
                             },
                         @{ // itemModel
                             XFSettingItemTitle: @"检测新版本",
                             XFSettingItemIcon : @"1435529156_cloud-arrow-up",
                             XFSettingItemClass : [XFSettingArrowItem class], // 这个字段用于判断是否有右边辅助功能的cell,不写则没有
//                             XFSettingItemDestViewControllerClass : [XFTestViewController class],
                             XFSettingOptionActionBlock : ^(XFSettingCell *cell,XFSettingPhaseType phaseType,id intentData){ // 如果有可选的操作
                                 
                             }
                             },
                         @{ // itemModel
                             XFSettingItemTitle: @"vip帮助",
                             XFSettingItemIcon : @"1435529211_circle_help_question-mark",
                             //                             XFSettingItemClass : [XFSettingArrowItem class], // 这个字段用于判断是否有右边辅助功能的cell,不写则没有
                             //                             XFSettingItemDestViewControllerClass : [XFTestViewController class],
                             XFSettingOptionActionBlock : ^(XFSettingCell *cell,XFSettingPhaseType phaseType,id intentData){ // 如果有可选的操作
                                 
                                 
                             }
                             }
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
