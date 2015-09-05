//
//  XFSettingAssistImageCell.m
//  XFSettingsExample
//
//  Created by Yizzuide on 15/9/2.
//  Copyright (c) 2015年 Yizzuide. All rights reserved.
//

#import "XFSettingAssistImageCell.h"
#import "XFSettingArrowItem.h"
#import "XFSettingAssistImageItem.h"
#import "XFCellAttrsData.h"

@interface XFSettingAssistImageCell ()
@property (nonatomic, weak) UIImageView *assistImageView;
@property (nonatomic, weak) UIView *bottomLineView;
@end

@implementation XFSettingAssistImageCell

- (UIImageView *)assistImageView{
    if (_assistImageView == nil) {
        UIImageView *assistImageView= [[UIImageView alloc] init];
//        assistImageView.layer.borderWidth = 1;
//        assistImageView.layer.borderColor = [UIColor redColor].CGColor;
        //        label.backgroundColor = [UIColor grayColor];
        assistImageView.bounds = CGRectMake(0, 0, 32, 32);
        assistImageView.contentMode = UIViewContentModeCenter;
        
        [self.contentView addSubview:assistImageView];
        _assistImageView = assistImageView;
    }
    return _assistImageView;
}

- (UIView *)bottomLineView
{
    if (_bottomLineView == nil) {
        UIView *bottomLineView = [[UIView alloc] init];
        bottomLineView.backgroundColor = [UIColor grayColor];
        [self addSubview:bottomLineView];
        _bottomLineView = bottomLineView;
    }
    return _bottomLineView;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGRect detailFrame = self.detailTextLabel.frame;
    detailFrame.origin.x = CGRectGetMaxX(self.textLabel.frame)  + (self.cellAttrsData.contentEachOtherPadding > 1.f ? self.cellAttrsData.contentEachOtherPadding * 0.5 : 7.5);
    self.detailTextLabel.frame = detailFrame;
    
    XFSettingArrowItem *item = (XFSettingArrowItem *)self.item;
    CGRect assistImageFrame = self.assistImageView.frame;
    if (item.destVCClass) {
        NSLog(@"%@",@"destVC");
        assistImageFrame.origin.x = self.contentView.frame.size.width - assistImageFrame.size.width;
    }else{
        assistImageFrame.origin.x = self.contentView.frame.size.width - assistImageFrame.size.width - (self.cellAttrsData.contentEachOtherPadding > 1.f ? self.cellAttrsData.contentEachOtherPadding : 15);
    }
    assistImageFrame.origin.y = (self.contentView.frame.size.height - assistImageFrame.size.height) * 0.5;
    self.assistImageView.frame = assistImageFrame;
    
    
    // 画下线
    if(self.cellAttrsData.cellFullLineEnable){
        // 画cell底部的线
        CGRect frame = self.bottomLineView.frame;
        frame.size.width = self.frame.size.width;
        frame.size.height = 0.3;
        frame.origin.y = self.frame.size.height - frame.size.height;
        self.bottomLineView.frame = frame;
        // 线条颜色
        self.bottomLineView.backgroundColor = self.cellAttrsData.cellBottomLineColor;
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
    
    self.detailTextLabel.font = [UIFont systemFontOfSize:12];
    self.detailTextLabel.text = assistImageItem.detailText;
    self.detailTextLabel.textAlignment = NSTextAlignmentLeft;
    self.detailTextLabel.textColor = self.cellAttrsData.contentDetailTextColor ? self.cellAttrsData.contentDetailTextColor : [UIColor grayColor];
    
    self.assistImageView.image = [UIImage imageNamed:assistImageItem.assistImageName];
    
    // 如果用户用了cellFullLineEnable
    if (self.cellAttrsData.cellFullLineEnable) {
        [self bottomLineView];
    }
}


@end
