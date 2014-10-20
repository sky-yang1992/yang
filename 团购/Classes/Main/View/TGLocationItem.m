//
//  TGLocationItem.m
//  团购
//
//  Created by dan on 14-10-12.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "TGLocationItem.h"
#define kImageScale 0.5

@interface TGLocationItem()<UIPopoverControllerDelegate>
{
    UIPopoverController *_popover;
}
@end

@implementation TGLocationItem

#pragma mark - 初始化方法
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 1.距离顶部自动伸缩
        self.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        
        // 2.设置图片
        [self setIcon:@"ic_district.png" selectedIcon:@"ic_district_hl.png"];
        
        // 3.设置默认文字
        [self setTitle:@"定位中" forState:UIControlStateNormal];
        self.titleLabel.textAlignment = UITextAlignmentCenter;//文字居中显示
        self.titleLabel.font = [UIFont systemFontOfSize:16];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];//不可点击时是白色
        [self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];  //正常情况下是灰色
        
        // 4.设置图片属性
        self.imageView.contentMode = UIViewContentModeCenter;//图片居中显示
        
        // 5.监听点击
        [self addTarget:self action:@selector(locationClick) forControlEvents:UIControlEventTouchDown];
        
        // 6.监听城市改变
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cityChange) name:kCityChangeNote object:nil];
        
    }
    return self;
}

#pragma mark 城市改变
-(void)cityChange{
    
    TGCity *city = [TGMetaDataTool sharedTGMetaDataTool].currentCity;
    
    // 1.更改显示的城市名称
    [self setTitle:city.name forState:UIControlStateNormal];
    
    // 2.关闭popover（代码关闭popover不会触发代理方法）
    [_popover dismissPopoverAnimated:YES];
    
    // 3.变为enable
    self.enabled = YES;
}

//屏幕旋转的方法
-(void)screenRotate{
    //屏幕旋转时，如果_popover已经显示出来，就先将_popover移除，0.5秒后调用[self locationClick]方法重新显示一个popover
    if (_popover.popoverVisible) {
        [_popover dismissPopoverAnimated:YES];
        
        [self performSelector:@selector(showPopover) withObject:nil afterDelay:0.5];
    }
}

#pragma mark 显示popover
-(void)showPopover{
    [_popover presentPopoverFromRect:self.bounds inView:self permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

//'定位中'按钮点击事件
-(void)locationClick{
    self.enabled = NO;
    
    TGCityListController *city = [[TGCityListController alloc] init];
    _popover = [[UIPopoverController alloc] initWithContentViewController:city];
    _popover.popoverContentSize = CGSizeMake(320,480);
    _popover.delegate = self;
    [self showPopover];
    
    //监听屏幕旋转的通知
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(screenRotate) name:UIDeviceOrientationDidChangeNotification object:nil];
}

-(void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController{
    self.enabled = YES;
    //_popover被销毁时移除通知,节约内存
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
}

//移除通知
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//自定义image在button中的位置
-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat w = contentRect.size.width;
    CGFloat h = contentRect.size.height * kImageScale;
    return CGRectMake(0, 0, w, h);
}

//自定义title在button中的位置
-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat w = contentRect.size.width;
    CGFloat h = contentRect.size.height * (1 - kImageScale);
    CGFloat y = contentRect.size.height - h;
    return CGRectMake(0, y, w, h);
}

@end
