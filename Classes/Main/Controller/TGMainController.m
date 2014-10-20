//
//  TGMainController.m
//  团购
//
//  Created by dan on 14-10-10.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "TGMainController.h"


@interface TGMainController()<TGDockDelegate>
{
    UIView *_contentView;
}
@end

@implementation TGMainController

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    
    // 1.添加Dock
    TGDock *dock = [[TGDock alloc] init];
    dock.frame = CGRectMake(0, 0, 0, self.view.frame.size.height);
    dock.delegate = self;
    [self.view addSubview:dock];
    
    // 2.添加内容view
    _contentView = [[UIView alloc] init];
    CGFloat w = self.view.frame.size.width - kDockItemW;
    CGFloat h = self.view.frame.size.height;
    _contentView.frame = CGRectMake(kDockItemW, 0, w, h);
    _contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:_contentView];
    
    // 3.添加子控制器
    [self addChildViewControllers];
    
}

#pragma mark 添加子控制器
-(void)addChildViewControllers{
    // 1.团购
    TGDealListController *deal = [[TGDealListController alloc] init];
    TGNavigationController *nav = [[TGNavigationController alloc] initWithRootViewController:deal];
    [self addChildViewController:nav];
    
    // 2.地图
    TGMapController *map = [[TGMapController alloc] init];
    nav = [[TGNavigationController alloc] initWithRootViewController:map];
    [self addChildViewController:nav];
    
    // 3.收藏
    TGCollectController *collect = [[TGCollectController alloc] init];
    nav = [[TGNavigationController alloc] initWithRootViewController:collect];
    [self addChildViewController:nav];
    
    // 4.我的
    TGMineController *mine = [[TGMineController alloc] init];
    nav = [[TGNavigationController alloc] initWithRootViewController:mine];
    [self addChildViewController:nav];
    
    // 5. 默认选择团购控制器
    [self dock:nil tabChangeFrom:0 to:0];
}

#pragma mark 点击了Dock上的某一个标签
-(void)dock:(TGDock *)dock tabChangeFrom:(int)from to:(int)to{
    // 1.先移除旧的控制器
    UIViewController *old = [self.childViewControllers objectAtIndex:from];
    [old.view removeFromSuperview];
    
    // 2.添加新的控制器
    UIViewController *new = [self.childViewControllers objectAtIndex:to];
    new.view.frame = _contentView.bounds;
    new.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [_contentView addSubview:new.view];
}

//横竖屏自动伸缩
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    return YES;
}
@end
