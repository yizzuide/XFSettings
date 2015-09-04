//
//  XFSettingCell.m
//  XFSettings
//
//  Created by Yizzuide on 15/5/26.
//  Copyright (c) 2015年 Yizzuide. All rights reserved.
//

#import "XFSettingCell.h"
#import "XFSettingArrowItem.h"
#import "XFSettingSwitchItem.h"
#import "XFSettingTableViewController.h"
#import "XFCellAttrsData.h"

@interface XFSettingCell ()

@property (nonatomic, weak) UISwitch *switchView;
@property (nonatomic, weak) UIImageView *arrowIcon;
@end

@implementation XFSettingCell

- (UISwitch *)switchView
{
    if (_switchView == nil) {
        UISwitch *swithView= [[UISwitch alloc] init];
        [swithView addTarget:self action:@selector(stateChanged:) forControlEvents:UIControlEventValueChanged];
        self.accessoryView = swithView;
        
        _switchView = swithView;
    }
    return _switchView;
}
 - (UIImageView *)arrowIcon
{
    if (_arrowIcon == nil) {
        UIImageView *arrowIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 8, 12)];
        arrowIcon.contentMode = UIViewContentModeCenter;
        self.accessoryView = arrowIcon;
        _arrowIcon = arrowIcon;
    }
    return _arrowIcon;
} 

- (void)setItem:(XFSettingItem *)item
{
    _item = item;
    
    // 执行初始化
    if (item.optionBlock) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            item.optionBlock(self,XFSettingPhaseTypeCellInit,nil);
        });
    }

    self.textLabel.text = item.title;
    // 有的设置栏没有图标
    if (item.icon.length) {
        self.imageView.image = [UIImage imageNamed:item.icon];
    }
    
    // 设置辅助视图类型
    Class itemClass = [item class];
    // 如果是带有向右箭头的cell
    if ([item isKindOfClass:[XFSettingArrowItem class]]) {
        XFSettingArrowItem *arrowItem = (XFSettingArrowItem *)item;
        if (arrowItem.destVCClass) {
            // 如果有自定义的图标
            if (arrowItem.arrowIcon) {
                self.arrowIcon.image = [UIImage imageNamed:arrowItem.arrowIcon];
            }else{ // 否则用系统默认
                self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                self.selectionStyle = UITableViewCellSelectionStyleDefault;
            }
        }
    }else if (itemClass == [XFSettingSwitchItem class]){ // Switch Cell
        self.accessoryType = UITableViewCellAccessoryNone;
        [self switchView];
        // 点击不可选择
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }else { // 其它的恢复状态到默认
        self.accessoryType = UITableViewCellAccessoryNone;
        self.accessoryView = nil;
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
    }
}
// 创建可复用cell
+ (instancetype)settingCellWithTalbeView:(UITableView *)tableView cellColorData:(XFCellAttrsData *)cellAttrsData {
    NSString *ID = [self settingCellReuseIdentifierString];
    
    XFSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        
//        NSLog(@"%@",cell);
        cell.cellAttrsData = cellAttrsData;
        // 设置cell属性
        if (cellAttrsData.cellBackgroundColor)
            cell.backgroundColor = cellAttrsData.cellBackgroundColor;
        if (cellAttrsData.cellSelectedBackgroundColor){
            UIView *view = [[UIView alloc] init];
            view.backgroundColor = cellAttrsData.cellSelectedBackgroundColor;
            cell.selectedBackgroundView = view;
        }
        if (cellAttrsData.cellBackgroundView)
            cell.backgroundView = cellAttrsData.cellBackgroundView;
        if (cellAttrsData.cellSelectedBackgroundView)
            cell.selectedBackgroundView = cellAttrsData.cellSelectedBackgroundView;
    }
    
    return cell;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 更改ImageView
    CGRect bounds = self.imageView.bounds;
    CGFloat wh = self.cellAttrsData.contentIconSize > 1.f ? self.cellAttrsData.contentIconSize : 24;
    bounds.size = CGSizeMake(wh, wh);
    self.imageView.bounds = bounds;
    
    CGRect imageFrame = self.imageView.frame;
    imageFrame.origin.x = self.cellAttrsData.contentEachOtherPadding > 1.f ? self.cellAttrsData.contentEachOtherPadding : 15;
    self.imageView.frame = imageFrame;
    // textLabel
    CGRect titleFrame = self.textLabel.frame;
    titleFrame.origin.x = CGRectGetMaxX(imageFrame) + imageFrame.origin.x;
    self.textLabel.frame = titleFrame;
    
    // 调整系统的下划线
    NSUInteger count = self.subviews.count;
    for (int i = 0; i < count; i++) {
        UIView *subView = self.subviews[i];
        if ([subView isMemberOfClass:NSClassFromString(@"_UITableViewCellSeparatorView")]) {
            CGFloat lineW = subView.frame.size.width;
            CGRect lineFrame = subView.frame;
            if (lineW < [UIScreen mainScreen].bounds.size.width) {
                lineFrame.origin.x = titleFrame.origin.x;
                lineFrame.size.width = [UIScreen mainScreen].bounds.size.width - lineFrame.origin.x;
                subView.frame = lineFrame;
            }
            // 线条颜色
            subView.backgroundColor = self.cellAttrsData.cellBottomLineColor;
        }
    }
    
}

+ (NSString *)settingCellReuseIdentifierString
{
    return @"setting-cell";
}

- (void)stateChanged:(UISwitch *)switchView {
    if (self.item.optionBlock) {
        self.item.optionBlock(self,XFSettingPhaseTypeCellInteracted,@{@"switchOn":@(switchView.isOn)});
    }
}

@end
