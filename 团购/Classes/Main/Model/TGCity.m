//
//  TGCity.m
//  团购
//
//  Created by dan on 14-10-14.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "TGCity.h"

@implementation TGCity

@synthesize districts = _districts;
@synthesize hot = _hot;

-(void)setDistricts:(NSArray *)districts{
    
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dic in districts) {
        TGDistrict *district = [[TGDistrict alloc] init];
        [district setValues:dic];        
        [array addObject:district];
    }
    _districts = array;

}

@end
