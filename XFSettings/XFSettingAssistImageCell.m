//
//  XFSettingAssistImageCell.m
//  XFSettings
//
//  Created by Yizzuide on 15/9/2.
//  Copyright (c) 2015年 Yizzuide. All rights reserved.
//

#import "XFSettingAssistImageCell.h"
#import "XFSettingArrowItem.h"
#import "XFSettingAssistImageItem.h"
#import "XFCellAttrsData.h"
#import "XFSettings.h"

@interface XFSettingAssistImageCell ()

@end

@implementation XFSettingAssistImageCell

- (UIImageView *)assistImageView{
    if (_assistImageView == nil) {
        UIImageView *assistImageView= [[UIImageView alloc] init];
//        assistImageView.bounds = CGRectMake(0, 0, 32, 32);
        
        [self.contentView addSubview:assistImageView];
        _assistImageView = assistImageView;
    }
    return _assistImageView;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGRect detailFrame = self.detailTextLabel.frame;
    detailFrame.origin.x = CGRectGetMaxX(self.textLabel.frame)  + (self.cellAttrsData.contentEachOtherPadding > 1.f ? self.cellAttrsData.contentEachOtherPadding * 0.5 : 7.5);
    self.detailTextLabel.frame = detailFrame;
    
    XFSettingAssistImageItem *assistImageItem = (XFSettingAssistImageItem *)self.item;
    float margin = assistImageItem.assistImageMargin ? assistImageItem.assistImageMargin.floatValue : 8;
    CGFloat assistImageWH = self.contentView.frame.size.height - margin * 2;
    CGRect assistImageFrame = CGRectMake(0, 0, assistImageWH, assistImageWH);
    assistImageFrame.origin.x = self.contentView.frame.size.width - assistImageWH -(self.cellAttrsData.contentEachOtherPadding > 1.f ? self.cellAttrsData.contentEachOtherPadding : 15);
    
    assistImageFrame.origin.y = margin;
    self.assistImageView.frame = assistImageFrame;
    if (assistImageItem.assistImageRenderRadii) {
        self.assistImageView.layer.masksToBounds = YES;
        // 正圆
        if (assistImageItem.assistImageRenderRadii.floatValue ==
            XFSettingItemAttrAssistImageRadiiCircle) {
            self.assistImageView.layer.cornerRadius = assistImageWH * 0.5;
        } else {
            self.assistImageView.layer.cornerRadius = assistImageItem.assistImageRenderRadii.floatValue;
        }
    }

}

+ (NSString *)settingCellReuseIdentifierString
{
    return @"settingAssistImage-cell";
}
- (void)setItem:(XFSettingItem *)item
{
    [super setItem:item];
    
    XFSettingAssistImageItem *assistImageItem = (XFSettingAssistImageItem *)item;
    
    self.detailTextLabel.font = [UIFont systemFontOfSize:(self.cellAttrsData.contentTextMaxSize > 1.f ? self.cellAttrsData.contentTextMaxSize - 1 : 12)];
    self.detailTextLabel.text = assistImageItem.detailText;
    self.detailTextLabel.textAlignment = NSTextAlignmentLeft;
    self.detailTextLabel.textColor = self.cellAttrsData.contentDetailTextColor ? self.cellAttrsData.contentDetailTextColor : [UIColor grayColor];
    
    self.assistImageView.image = assistImageItem.assistImage ?: [UIImage imageNamed:assistImageItem.assistImageName];
    self.assistImageView.contentMode = assistImageItem.assistImageContentMode ? assistImageItem.assistImageContentMode.integerValue : UIViewContentModeCenter;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // 是否允许Radio方式
    if(self.cellAttrsData.cellEnableRadioSelectStyle){
        self.assistImageView.hidden = !selected;
    }
}


@end
