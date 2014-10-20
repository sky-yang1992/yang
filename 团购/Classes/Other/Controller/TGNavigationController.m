//
//  TGNavigationController.m
//  团购
//
//  Created by dan on 14-10-12.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "TGNavigationController.h"

@implementation TGNavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];    
}

#pragma mark 第一次使用这个类的时候调用一次
+ (void)initialize{
    // 1.appearance方法返回一个导航栏的外观对象
    // 修改了这个外观对象，相当于修改了整个项目中的外观
    UINavigationBar *bar = [UINavigationBar appearance];
    
    // 2.设置导航栏的背景图片
    [bar setBackgroundImage:[UIImage resizedImage:@"bg_navigation.png"] forBarMetrics:UIBarMetricsDefault];
    
    // 3.设置导航栏文字的主题
    NSArray *obj_array = [NSArray arrayWithObjects:UITextAttributeTextColor,UITextAttributeTextShadowOffset, nil];
    NSArray *key_array = [NSArray arrayWithObjects:[UIColor blackColor],[NSValue valueWithUIOffset:UIOffsetZero], nil];
    NSDictionary *dic = [NSDictionary dictionaryWithObjects:obj_array forKeys:key_array];
    [bar setTitleTextAttributes:dic];
    
    // 4.修改所有UIBarButtonItem的外观
    UIBarButtonItem *barItem = [UIBarButtonItem appearance];
    // 修改item的背景图片
    [barItem setBackgroundImage:[UIImage resizedImage:@"bg_navigation_right.png"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [barItem setBackgroundImage:[UIImage resizedImage:@"bg_navigation_right_hl.png"] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
    
    // 修改item上面的文字样式
    NSArray *objArray = [NSArray arrayWithObjects:UITextAttributeTextColor,UITextAttributeTextShadowOffset, nil];
    NSArray *keyArray = [NSArray arrayWithObjects:[UIColor darkGrayColor],[NSValue valueWithUIOffset:UIOffsetZero], nil];
    NSDictionary *dict = [NSDictionary dictionaryWithObjects:objArray forKeys:keyArray];
    [barItem setTitleTextAttributes:dict forState:UIControlStateNormal];
    [barItem setTitleTextAttributes:dict forState:UIControlStateHighlighted];
    
    // 5.设置状态栏样式
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleBlackOpaque;
}

//横竖屏自动伸缩
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

@end
