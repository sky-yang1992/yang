//
//  TGCollectController.m
//  团购
//
//  Created by dan on 14-10-12.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "TGCollectController.h"

@implementation TGCollectController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"我的收藏";
}

//横竖屏自动伸缩
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

@end
