//
//  BXBAPPInfoModel.h
//  BXBSDWebImage
//
//  Created by 毕向北 on 16/7/31.
//  Copyright © 2016年 bifujian. All rights reserved.
//


#import <UIKit/UIKit.h>
@interface BXBAPPInfoModel : NSObject

@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *downLoad;
@property (nonatomic,copy)NSString *icon;
@property (nonatomic,strong)UIImage *iamge;
//转模型
+(instancetype)appInfoWith : (NSDictionary *)dict;
-(instancetype)initWithDict: (NSDictionary *)dict;
@end
