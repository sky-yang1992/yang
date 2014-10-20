//
//  TGCitySection.m
//  团购
//
//  Created by dan on 14-10-14.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "TGCitySection.h"

@implementation TGCitySection

@synthesize cities = _cities;

-(void)setCities:(NSMutableArray *)cities
{
    // 当cities为空或者里面装的是模型数据，就直接赋值
    id obj = [cities lastObject];
    if (![obj isKindOfClass:[NSDictionary class]]){
        _cities = cities;
        return;
    }
    
    NSMutableArray *array = [NSMutableArray array];
    
    for (NSDictionary *dic in cities) {   
        
        TGCity *city = [[TGCity alloc] init];
        [city setValues:dic];
        [array addObject:city];
    }
    
    _cities = array;

}

@end
