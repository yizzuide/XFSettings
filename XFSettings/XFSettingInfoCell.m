//
//  XFSettingInfoCell.m
//  XFSettings
//
//  Created by Yizzuide on 15/6/26.
//  Copyright © 2015年 Yizzuide. All rights reserved.
//

#import "XFSettingInfoCell.h"
#import "XFSettingInfoItem.h"

@implementation XFSettingInfoCell

- (UILabel *)rightInfoLabel{
    if (_rightInfoLabel == nil) {
        UILabel *label= [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 20)];
        _rightInfoLabel = label;
        _rightInfoLabel.textColor = [UIColor redColor];
        _rightInfoLabel.font = [UIFont systemFontOfSize:10];
        _rightInfoLabel.textAlignment = NSTextAlignmentRight;
        
        self.accessoryView = self.rightInfoLabel;
    }
    return _rightInfoLabel;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGRect detailFrame = self.detailTextLabel.frame;
    detailFrame.origin.x = CGRectGetMaxX(self.textLabel.frame)  + 5;
    self.detailTextLabel.frame = detailFrame;
}

- (void)setItem:(XFSettingItem *)item
{
    [super setItem:item];
    
    XFSettingInfoItem *infoItem = (XFSettingInfoItem *)item;
    
    self.detailTextLabel.font = [UIFont systemFontOfSize:12];
    self.detailTextLabel.text = infoItem.detailText;
    self.detailTextLabel.textAlignment = NSTextAlignmentLeft;
    
    self.rightInfoLabel.text = infoItem.rightInfo;
    
    /* [infoItem addObserver:self forKeyPath:@"rightInfo" options:NSKeyValueObservingOptionNew context:nil]; */
}

/* - (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([self respondsToSelector:@selector(settingInfoValueChanged:)]) {
        [self settingInfoValueChanged:self.rightInfoLabel];
    }
    
} */


@end
