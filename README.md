![XFSettings logo](./ScreenShot/XFSettingLogo.png)

[![CocoaPods](https://img.shields.io/cocoapods/v/XFSettings.svg?style=flat)](http://cocoadocs.org/docsets/XFSettings)
![Language](https://img.shields.io/badge/language-ObjC-orange.svg)
![License](https://img.shields.io/hexpm/l/plug.svg)
![Version](https://img.shields.io/badge/platform-ios7%2B-green.svg)

基于UITableView的界面定制，目标是更快更方便构建设置界面。

![XFSettings usage1](./ScreenShot/usage.gif)

##安装
1、通过cocoapods
> pod 'XFSettings'

2、手动加入
把XFSettings整个目录拖入到工程

##使用方法
首先, 在`.m`里添加 `#import "XFSettings.h`，在`viewDidLoad`方法里设置`XFCellAttrsData`参数，数据源`self.dataSource`并调用`[self xf_setup]`进行配置，然后添加 `- (NSArray *)settingItems`数据源方法返回`NSArray`以供库内部的渲染。

```objc

//.m
@interface ViewController ()<XFSettingTableViewDataSource>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"设置";
    self.view.backgroundColor = [UIColor whiteColor];
    
    // set cell attrs
    XFCellAttrsData *cellAttrsData = [XFCellAttrsData cellColorDataWithBackgroundColor:[UIColor whiteColor] selBackgroundColor:[UIColor colorWithWhite:0 alpha:0.4]];
    // 设置图标大小
    cellAttrsData.contentIconSize = 20;
    // 设置内容间距
    cellAttrsData.contentEachOtherPadding = 15;
    // cell 线条颜色
    cellAttrsData.cellBottomLineColor = [UIColor purpleColor];
    // 显示填充整个cell宽度画线
//    cellAttrsData.cellFullLineEnable = YES;
    // 标题文字大小（其它文字会按个大小自动调整）
    cellAttrsData.contentTextMaxSize = 13;
    // 标题颜色
    cellAttrsData.contentTitleTextColor = [UIColor purpleColor];
    // 详细文字颜色
    cellAttrsData.contentDetailTextColor = [UIColor blueColor];
    // 辅助文字颜色
    cellAttrsData.contentInfoTextColor = [UIColor brownColor];
    self.cellAttrsData = cellAttrsData;
    // 设置数据源
    self.dataSource = self;
    // 调用配置设置
    [self xf_setup];
    
    
}

- (NSArray *)settingItems
{
    WS(weakSelf)
    return @[ // groupArr
             @{ // groupModel
                 XFSettingGroupHeader: @"基本信息",
                 XFSettingGroupItems : @[ // items
                         @{ // itemModel
                             XFSettingItemTitle: @"我的朋友",
                             XFSettingItemIcon : @"1435582804_group",
                             XFSettingItemClass : [XFSettingInfoItem class], // 这个字段用于判断是否有右边辅助功能的cell,不写则没有
                             XFSettingItemAttrDetailText : @"你的好友",
                             XFSettingItemRelatedCellClass:[XFSettingInfoDotCell class],// 自定义的cell
                            XFSettingItemDestViewControllerClass : [XFNewFriendViewController class], // 如果有目标控制器
                             XFSettingItemDestViewControllerUserInfo : @{@"url":@"http://www.yizzuide.com"},// 目标控制器带有参数
                             XFSettingOptionActionBlock : ^(XFSettingInfoDotCell *cell,XFSettingPhaseType phaseType,id intentData){ // 如果有可选的操作
                                 if (phaseType == XFSettingPhaseTypeCellInteracted) {
                                     cell.rightInfoLabel.hidden = YES;
                                 }
                             }
                             },// end itemModel
                         @{
                             XFSettingItemTitle: @"我的消息",
                             XFSettingItemIcon : @"1435527299_message",
                             XFSettingItemClass : [XFSettingInfoItem class],                              XFSettingItemAttrDetailText : @"新的好友",
                             XFSettingItemAttrRightInfo : @"3",
                             XFSettingItemRelatedCellClass:[XFSettingInfoCountCell class],
                             XFSettingOptionActionBlock : ^(XFSettingInfoCountCell *cell,XFSettingPhaseType phaseType,id intentData){
                                 // 交互时处理
                                 if (phaseType == XFSettingPhaseTypeCellInteracted) {
                                     int count = cell.rightInfoLabel.text.intValue;
                                     cell.rightInfoLabel.text = [NSString stringWithFormat:@"%d",++count];
                                 }
                             }
                             },
                         @{
                             XFSettingItemTitle: @"缓存大小",
                             XFSettingItemIcon : @"1435529531_CD-DVD Drive-2",
                             XFSettingItemClass : [XFSettingInfoItem class],
                             XFSettingItemAttrDetailText : @"cache",
                             XFSettingItemAttrRightInfo : @"正在计算",
                             XFSettingItemRelatedCellClass:[XFSettingInfoCell class],
                             XFSettingOptionActionBlock : ^(XFSettingInfoCell *cell,XFSettingPhaseType phaseType,id intentData){
                                
                                 [weakSelf cacheDirClear:cell phaseType:phaseType];
                             }
                             },
                         @{
                             XFSettingItemTitle: @"保存我的设置",
                             XFSettingItemIcon : @"1435527366_1-8",
                             XFSettingItemClass : [XFSettingSwitchItem class],
                             XFSettingOptionActionBlock : ^(XFSettingCell *cell,XFSettingPhaseType phaseType,id intentData){
                                 
                                 if (phaseType == XFSettingPhaseTypeCellInteracted) {
                                     if ([intentData[XFSettingIntentDataSwitchOn] boolValue]) {
                                         NSLog(@"%@", @"保存");
                                     }else{
                                         NSLog(@"%@", @"取消保存");
                                     }
                                 }
                             }
                             },
                         @{
                             XFSettingItemTitle: @"检测新版本",
                             XFSettingItemIcon : @"1435529156_cloud-arrow-up",
                             // 使用自定义向右箭头
                             XFSettingItemArrowIcon : @"CellArrow",
                             XFSettingItemClass : [XFSettingInfoItem class],
                             XFSettingItemRelatedCellClass:[XFSettingInfoCell class],
                             XFSettingItemAttrRightInfo : @"有新版本！",
                             XFSettingItemDestViewControllerClass : [UpdateViewController class],
                             XFSettingOptionActionBlock : ^(XFSettingInfoCell *cell,XFSettingPhaseType phaseType,id intentData){
                                 // 自定义初始化样式
                                 if (phaseType == XFSettingPhaseTypeCellInit) {
                                     cell.rightInfoLabel.textColor = [UIColor orangeColor];
                                     cell.rightInfoLabel.font = [UIFont systemFontOfSize:10];
                                 }
                             }
                             },
                         /*@{
                             XFSettingItemTitle: @"vip帮助",
                             XFSettingItemIcon : @"1435529211_circle_help_question-mark",
                             XFSettingOptionActionBlock : ^(XFSettingCell *cell,XFSettingPhaseType phaseType,id intentData){
                                 
                                 
                             }
                             }*/
                         @{
                             XFSettingItemTitle: @"vip帮助",
                             XFSettingItemIcon : @"1435529211_circle_help_question-mark",
                             XFSettingItemAttrDetailText : @"帮助文档",
                             XFSettingItemAttrAssistImageName : @"picture_download",
                             XFSettingItemClass : [XFSettingAssistImageItem class],
                             XFSettingItemRelatedCellClass:[XFSettingAssistImageCell class]
                             },
                         @{
                             XFSettingItemTitle: @"服务协议",
                             XFSettingItemClass : [XFSettingInfoItem class],
                             XFSettingItemRelatedCellClass:[XFSettingInfoDotCell class],
                             XFSettingOptionActionBlock : ^(XFSettingInfoDotCell *cell,XFSettingPhaseType phaseType,id intentData){ // 如果有可选的操作
                                 if (phaseType == XFSettingPhaseTypeCellInit) {
                                     cell.dotColor = [UIColor greenColor];
                                 }
                                 if (phaseType == XFSettingPhaseTypeCellInteracted) {
                                     cell.rightInfoLabel.hidden = YES;
                                 }
                             }
                             },
                         @{
                             XFSettingItemTitle: @"更新数据",
                             XFSettingItemAttrRightInfo : @"123456789@qq.com",
                             XFSettingItemArrowIcon : @"CellArrow",
                             XFSettingItemClass : [XFSettingInfoItem class],
                             XFSettingItemRelatedCellClass:[XFSettingInfoCell class],
                             // 当不使用控制器类时可以实现有箭头并且不会调转
                             XFSettingItemDestViewControllerClass:[NSObject class],
                             // 只是实行相当动作
                             XFSettingOptionActionBlock : ^(XFSettingInfoCell *cell,XFSettingPhaseType phaseType,id intentData){
                                 if (phaseType == XFSettingPhaseTypeCellInit) {
                                     cell.rightInfoLabel.textColor = [UIColor grayColor];
                                     cell.rightInfoLabel.font = [UIFont systemFontOfSize:10];
                                 }
                                 if (phaseType == XFSettingPhaseTypeCellInteracted) {
                                     NSLog(@"%@",@"正在更新中。。。");
                                 }
                             }
                             }
                         ],
                 XFSettingGroupFooter : @"lalala~"
                 }// end groupModel
             ];// endgroupArr
}

@end
```
