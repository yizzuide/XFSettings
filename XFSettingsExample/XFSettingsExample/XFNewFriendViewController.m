//
//  XFNewFriendViewController.m
//  XFSettingsExample
//
//  Created by 付星 on 15/8/14.
//  Copyright (c) 2015年 Yizzuide. All rights reserved.
//

#import "XFNewFriendViewController.h"

@interface XFNewFriendViewController ()

@end

@implementation XFNewFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSLog(@"%@",self.userInfo);
}

// 实现自己的屏幕旋转逻辑
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    NSLog(@"%@",@"执行屏幕覆盖的方法");
}

@end
