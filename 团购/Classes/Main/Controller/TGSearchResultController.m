//
//  TGSearchResultController.m
//  团购
//
//  Created by dan on 14-10-18.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "TGSearchResultController.h"

@interface TGSearchResultController() {

    NSMutableArray *_resultCities;   //所有搜索到的城市
}

@end

@implementation TGSearchResultController

@synthesize searchText = _searchText;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)setSearchText:(NSString *)searchText{
    _searchText = searchText;
    
    // 1.清除之前的搜索结果
    [_resultCities removeAllObjects];
    
    // 2.筛选城市(汉字或拼音搜索)
    HanyuPinyinOutputFormat *fmt = [[HanyuPinyinOutputFormat alloc] init];
    fmt.caseType = CaseTypeUppercase;
    fmt.vCharType = VCharTypeWithUUnicode;
    fmt.toneType = ToneTypeWithoutTone;
        
    NSDictionary *cities = [TGMetaDataTool sharedTGMetaDataTool].totalCities;
    
    [cities enumerateKeysAndObjectsUsingBlock:^(NSString *key, TGCity *obj, BOOL *stop) {
        // 1.拼音
        NSString *pinyin = [PinyinHelper toHanyuPinyinStringWithNSString:obj.name withHanyuPinyinOutputFormat:fmt withNSString:@"#"];
        
        // 2.拼音首字母
        NSArray *words = [pinyin componentsSeparatedByString:@"#"];
        NSMutableString *pinyinHeader = [NSMutableString string];
        
        for (NSString *word in words) {
            [pinyinHeader appendString:[word substringToIndex:1]];
        }
        
        //去掉字符串中的＃号，用空字符替换即可
        pinyin = [pinyin stringByReplacingOccurrencesOfString:@"#" withString:@""];
        
        // 3.城市名中包含了搜索条件
        //   拼音中包含了搜索条件
        //   拼音首字母中包含了搜索条件
        if (([obj.name rangeOfString:searchText].length != 0) || ([pinyin rangeOfString:searchText.uppercaseString].length != 0) || ([pinyinHeader rangeOfString:searchText.uppercaseString].length != 0)) {
            //城市名中包含了搜索条件
            [_resultCities addObject:obj];
        }
    }];
    
    // 3.刷新表格
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    _resultCities = [NSMutableArray array];
    
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [NSString stringWithFormat:@"共%d个搜索结果",_resultCities.count];
}

#pragma mark - Table view data source

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
    return _resultCities.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    TGCity *city = [_resultCities objectAtIndex:indexPath.row];
    cell.textLabel.text = city.name;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    TGCity *city = [_resultCities objectAtIndex:indexPath.row];
    
    [TGMetaDataTool sharedTGMetaDataTool].currentCity = city;
    
}

@end
