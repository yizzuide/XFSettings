//
//  XFSettingInfoCell.h
//  XFSettings
//
//  Created by Yizzuide on 15/6/26.
//  Copyright © 2015年 Yizzuide. All rights reserved.
//

#import "XFSettingCell.h"

@protocol XFSettingInfoCellDelegate <NSObject>

@optional
- (void)settingInfoValueChanged:(UILabel *)rightInfoLabel;

@end

/**
 *  一个显示各种详细的Cell
 */
@interface XFSettingInfoCell : XFSettingCell<XFSettingInfoCellDelegate>

@property (nonatomic, weak) UILabel *rightInfoLabel;
@end
