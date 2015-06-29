//
//  XFSettingInfoCountCell.m
//  XFSeetings
//
//  Created by Yizzuide on 15/6/26.
//  Copyright © 2015年 Yizzuide. All rights reserved.
//

#import "XFSettingInfoCountCell.h"

@implementation XFSettingInfoCountCell


- (void)setItem:(XFSettingItem *)item
{
    [super setItem:item];
    
    CGRect frame = self.rightInfoLabel.frame;
    frame.size.width = 20;
    self.rightInfoLabel.frame = frame;

    self.rightInfoLabel.textColor = [UIColor whiteColor];
    self.rightInfoLabel.font = [UIFont systemFontOfSize:15];
    self.rightInfoLabel.textAlignment = NSTextAlignmentCenter;
    
    CALayer *layer = self.rightInfoLabel.layer;
    layer.cornerRadius = 10;
    layer.backgroundColor = [UIColor colorWithRed:1.000 green:0.000 blue:0.000 alpha:0.760].CGColor;
    layer.borderWidth = 1;
    layer.borderColor = [UIColor whiteColor].CGColor;
}
@end
