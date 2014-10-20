//
//  TGMineController.m
//  团购
//
//  Created by dan on 14-10-12.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "TGMineController.h"

@implementation TGMineController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"我的";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"退出登录" style:UIBarButtonItemStylePlain target:nil action:nil];
}

//横竖屏自动伸缩
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

@end
