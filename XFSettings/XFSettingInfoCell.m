//
//  XFSettingInfoCell.m
//  XFSettings
//
//  Created by Yizzuide on 15/6/26.
//  Copyright © 2015年 Yizzuide. All rights reserved.
//

#import "XFSettingInfoCell.h"
#import "XFSettingInfoItem.h"
#import "XFCellAttrsData.h"

@implementation XFSettingInfoCell

- (UILabel *)rightInfoLabel{
    if (_rightInfoLabel == nil) {
        UILabel *label= [[UILabel alloc] init];
//        label.backgroundColor = [UIColor grayColor];
        label.bounds = CGRectMake(0, 0, 80, 20);
        label.textColor = [UIColor redColor];
        label.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:label];
        _rightInfoLabel = label;
    }
    return _rightInfoLabel;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGRect detailFrame = self.detailTextLabel.frame;
    detailFrame.origin.x = CGRectGetMaxX(self.textLabel.frame)  + (self.cellAttrsData.contentEachOtherPadding > 1.f ? self.cellAttrsData.contentEachOtherPadding * 0.5 : 7.5);
    self.detailTextLabel.frame = detailFrame;
    
    XFSettingArrowItem *item = (XFSettingArrowItem *)self.item;
    CGRect rightInfoFrame = self.rightInfoLabel.frame;
    if (item.destVCClass) {
        rightInfoFrame.origin.x = self.contentView.frame.size.width - rightInfoFrame.size.width - self.cellAttrsData.contentEachOtherPadding;
    }else{
        rightInfoFrame.origin.x = self.contentView.frame.size.width - rightInfoFrame.size.width - (self.cellAttrsData.contentEachOtherPadding > 1.f ? self.cellAttrsData.contentEachOtherPadding : 15);
    }
    rightInfoFrame.origin.y = (self.contentView.frame.size.height - rightInfoFrame.size.height) * 0.5;
    self.rightInfoLabel.frame = rightInfoFrame;
}

+ (NSString *)settingCellReuseIdentifierString
{
    return @"settingInfo-cell";
}

- (void)setItem:(XFSettingItem *)item
{
    [super setItem:item];
    
    XFSettingInfoItem *infoItem = (XFSettingInfoItem *)item;
    
    self.detailTextLabel.font = [UIFont systemFontOfSize:(self.cellAttrsData.contentTextMaxSize > 1.f ? self.cellAttrsData.contentTextMaxSize - 1 : 12)];
    self.detailTextLabel.text = infoItem.detailText;
    self.detailTextLabel.textAlignment = NSTextAlignmentLeft;
    self.detailTextLabel.textColor = self.cellAttrsData.contentDetailTextColor ? self.cellAttrsData.contentDetailTextColor : [UIColor grayColor];
    
    self.rightInfoLabel.text = infoItem.rightInfo;
    self.rightInfoLabel.font = [UIFont systemFontOfSize:(self.cellAttrsData.contentTextMaxSize > 1.f ? self.cellAttrsData.contentTextMaxSize - 1 : 12)];
    self.rightInfoLabel.textColor = self.cellAttrsData.contentInfoTextColor ? self.cellAttrsData.contentInfoTextColor : [UIColor redColor];
    
    /* [infoItem addObserver:self forKeyPath:@"rightInfo" options:NSKeyValueObservingOptionNew context:nil]; */
}

/* - (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([self respondsToSelector:@selector(settingInfoValueChanged:)]) {
        [self settingInfoValueChanged:self.rightInfoLabel];
    }
    
} */


@end
