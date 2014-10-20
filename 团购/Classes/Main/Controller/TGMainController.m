//
//  TGMainController.m
//  团购
//
//  Created by dan on 14-10-10.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "TGMainController.h"
#import "TGDock.h"

@implementation TGMainController

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"%@",NSStringFromCGRect(self.view.frame));//打印整个view的尺寸
    
    self.view.backgroundColor = [UIColor redColor];
    
    // 1.添加Dock
    TGDock *dock = [[TGDock alloc] init];
    dock.frame = CGRectMake(0, 0, 0, self.view.frame.size.height);
    [self.view addSubview:dock];
    
}

//横竖屏自动伸缩
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    return YES;
}
@end
