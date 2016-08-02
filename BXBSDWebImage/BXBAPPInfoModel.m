//
//  BXBAPPInfoModel.m
//  BXBSDWebImage
//
//  Created by 毕向北 on 16/7/31.
//  Copyright © 2016年 bifujian. All rights reserved.
//

#import "BXBAPPInfoModel.h"

@implementation BXBAPPInfoModel
+(instancetype)appInfoWith : (NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
    
}
-(instancetype)initWithDict: (NSDictionary *)dict
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
@end
