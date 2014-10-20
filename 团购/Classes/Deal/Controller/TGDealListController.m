//
//  TGDealListController.m
//  团购
//
//  Created by dan on 14-10-12.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "TGDealListController.h"

@implementation TGDealListController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 1.监听城市改变的通知
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cityChange) name:kCityChangeNote object:nil];
    
    // 2.设置背景色
    self.view.backgroundColor = kGlobalBg;
    
    // 3.添加右侧的搜索框
    UISearchBar *search = [[UISearchBar alloc] init];
    search.frame = CGRectMake(0, 0, 200, 40);
    search.placeholder = @"请输入商品名、地址";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:search];
    
    // 4.添加左侧的菜单栏
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[UIButton buttonWithType:UIButtonTypeContactAdd]];
    
}

//横竖屏自动伸缩
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

@end
