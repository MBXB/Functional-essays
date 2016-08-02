//
//  MBXBDownloadOperation.h
//  MBXBWebImage
//
//  Created by 毕向北 on 16/7/31.
//  Copyright © 2016年 bifujian. All rights reserved.
//


#import <UIKit/UIKit.h>
@interface MBXBDownloadOperation : NSOperation
@property (nonatomic,strong)UIImage *image;
+(instancetype)operationWithUrling : (NSString *)urlString;
@end
