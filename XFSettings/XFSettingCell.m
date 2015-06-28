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

@interface XFSettingCell ()

@property (nonatomic, weak) UISwitch *switchView;
//@property (nonatomic, strong) UIImageView *arrowIcon;
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
/* - (UIImageView *)arrowIcon
{
    if (_arrowIcon == nil) {
        _arrowIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CellArrow"]];
    }
    return _arrowIcon;
} */

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
    if (itemClass == [XFSettingArrowItem class]) {
//        self.accessoryView = self.arrowIcon;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
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
+ (instancetype)settingCellWithTalbeView:(UITableView *)tableView {
    static NSString *ID = @"cell";
    
    XFSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    
    return cell;
}

- (void)stateChanged:(UISwitch *)switchView {
    if (self.item.optionBlock) {
        self.item.optionBlock(self,XFSettingPhaseTypeCellInteracted,@{@"switchOn":@(switchView.isOn)});
    }
}

@end
