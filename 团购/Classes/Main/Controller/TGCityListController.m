//
//  TGCityListController.m
//  团购
//
//  Created by dan on 14-10-13.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "TGCityListController.h"

#define kSearchH 44

@interface  TGCityListController() <UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
{
    NSMutableArray *_citySections;   //所有的城市组信息
    UIView *_cover;                  //搜索时背景灰色遮盖
    UITableView *_tableView;         //tableView
    UISearchBar *_searchBar;         //搜索框
    TGSearchResultController *_searchResult;
}
@end

@implementation TGCityListController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 1.添加搜索栏
    [self addSearchBar];
    
    // 2.添加TableView
    [self addTableView];
    
    // 3.加载城市数据
    [self loadCitiesData];
    
}

#pragma mark 添加搜索栏
-(void)addSearchBar{
    UISearchBar *search = [[UISearchBar alloc] init];
    search.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    search.frame = CGRectMake(0, 0, self.view.frame.size.width, kSearchH);
    search.delegate = self;
    search.placeholder = @"请输入城市名或拼音";
    search.barStyle = UIBarStyleBlack;
    [self.view addSubview:search];
    _searchBar = search;
}

#pragma mark 添加TableView
-(void)addTableView{
    UITableView *tableView = [[UITableView alloc] init];
    tableView.frame = CGRectMake(0, kSearchH, self.view.frame.size.width, self.view.frame.size.height - kSearchH);
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:tableView];
    _tableView = tableView;
}

#pragma mark 加载城市数据
-(void)loadCitiesData{
    _citySections = [NSMutableArray array];
    
    NSArray *sections = [TGMetaDataTool sharedTGMetaDataTool].totalCitySections;
    [_citySections addObjectsFromArray:sections];
    
}

#pragma mark ---- 搜索框的代理方法
#pragma mark 监听搜索框的文字改变
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if (searchText.length == 0) {
        // 隐藏搜索界面
        [_searchResult.view removeFromSuperview];
    }else{
        // 显示搜索界面
        if (_searchResult == nil) {
            _searchResult = [[TGSearchResultController alloc] init];
            _searchResult.view.frame = _cover.frame;
            _searchResult.view.autoresizingMask = _cover.autoresizingMask;
            [self addChildViewController:_searchResult];
        }
        _searchResult.searchText = searchText;
        [self.view addSubview:_searchResult.view];
    }
}

#pragma mark 搜索框开始编辑（开始聚焦）
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    // 1.显示取消按钮
    [searchBar setShowsCancelButton:YES animated:YES];
    
    // 2.显示遮盖（蒙版）
    if (_cover == Nil) {
        _cover = [[UIView alloc] init];
        _cover.backgroundColor = [UIColor blackColor];
        _cover.frame = _tableView.frame;
        _cover.autoresizingMask = _tableView.autoresizingMask;
        [_cover addGestureRecognizer:[[UIGestureRecognizer alloc] initWithTarget:self action:@selector(coverClick)]];
    }
    [self.view addSubview:_cover];
    
    _cover.alpha = 0;
    [UIView animateWithDuration:0.3 animations:^() {
        _cover.alpha = 0.7;
    }];
    
}

#pragma mark 退出搜索框的键盘（失去聚焦－－点击键盘的退出按钮）
-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    [self coverClick];
}

#pragma mark 点击取消按钮
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [self coverClick];
}

#pragma mark 监听点击遮盖（黑色背景）
-(void)coverClick{
    // 1.移除遮盖
    [UIView animateWithDuration:0.3 animations:^() {
        _cover.alpha = 0.0;
    }completion:^(BOOL finished) {
        [_cover removeFromSuperview];
    }];
    
    
    // 2.隐藏取消按钮
    [_searchBar setShowsCancelButton:NO animated:YES];
    
    // 3.退出键盘
    [_searchBar resignFirstResponder];
}

#pragma mark - UITableViewDataSource数据源方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _citySections.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    TGCitySection *citySection = [_citySections objectAtIndex:section];
    return citySection.cities.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == Nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    TGCitySection *citySection = [_citySections objectAtIndex:indexPath.section];
    
    TGCity *city = [citySection.cities objectAtIndex:indexPath.row];
    
    cell.textLabel.text = city.name;
    
    return cell;
}

//section的headTitle
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{

    return [[_citySections objectAtIndex:section] name];
    
}

//右侧的索引
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    //会取出_citySections中所有字典name属性的值，并且装到数组中返回
    return [_citySections valueForKeyPath:@"name"];
    
}

#pragma mark -UITableViewDelegate代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TGCitySection *section = [_citySections objectAtIndex:indexPath.section];
    TGCity *city = [section.cities objectAtIndex:indexPath.row];
    
    [TGMetaDataTool sharedTGMetaDataTool].currentCity = city;
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

@end
