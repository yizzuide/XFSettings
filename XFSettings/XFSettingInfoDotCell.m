//
//  XFSettingInfoDotCell.m
//  XFSettingsExample
//
//  Created by Yizzuide on 15/6/29.
//  Copyright © 2015年 Yizzuide. All rights reserved.
//

#import "XFSettingInfoDotCell.h"

@implementation XFSettingInfoDotCell


- (void)setItem:(XFSettingItem *)item
{
    [super setItem:item];
    
    CGRect frame = self.rightInfoLabel.frame;
    frame.size.width = 6;
    frame.size.height = 6;
    self.rightInfoLabel.frame = frame;
    
//    self.rightInfoLabel.textColor = [UIColor whiteColor];
//    self.rightInfoLabel.font = [UIFont systemFontOfSize:15];
//    self.rightInfoLabel.textAlignment = NSTextAlignmentCenter;
    
    CALayer *layer = self.rightInfoLabel.layer;
    layer.cornerRadius = 3;
    layer.backgroundColor = [UIColor colorWithRed:1.000 green:0.000 blue:0.000 alpha:0.760].CGColor;
}
@end
