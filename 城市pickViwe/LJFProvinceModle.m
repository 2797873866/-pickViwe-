//
//  LJFProvinceModle.m
//  GroupBuy
//
//  Created by ljf on 2017/2/8.
//  Copyright © 2017年 招. All rights reserved.
//

#import "LJFProvinceModle.h"

@implementation LJFProvinceModle

-(NSArray *)loadInfoWithPlist{
    
    NSBundle * bundle = [NSBundle mainBundle];
    NSString * filePath =[bundle pathForResource:@"Province&City&District.plist" ofType:nil];
    NSDictionary * dict = [[NSDictionary alloc] initWithContentsOfFile:filePath];
    
    NSMutableArray * mArrry = [NSMutableArray arrayWithCapacity:dict.count];
    
    for( int i = 0 ;i< 4;i++){
        NSDictionary * dictSub = dict[[NSString stringWithFormat:@"%d",i]];
        LJFProvinceModle * proince = [LJFProvinceModle mj_objectWithKeyValues:dictSub];
        
        [mArrry addObject:proince];
    }
    LJFProvinceModle * m = mArrry[0];
    
    LJFProvinceModle * ms = m.cities[0];
    
    LJFProvinceModle * mss = ms.cities[0];
    
    return mArrry;
}


-(void)setName:(NSString *)name{
    _name = name.copy;
}

//模型中 ==> 数组中 ==> 模型 
+(NSDictionary *)mj_objectClassInArray{
    
    return @{@"cities":[LJFProvinceModle class]};
}


@end
