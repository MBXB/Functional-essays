//
//  MBXBDownloadOperation.m
//  MBXBWebImage
//
//  Created by 毕向北 on 16/7/31.
//  Copyright © 2016年 bifujian. All rights reserved.
//

#import "MBXBDownloadOperation.h"
#import "NSString+path.h"
@interface MBXBDownloadOperation()
@property (nonatomic,strong)NSString *urlString;
@end
@implementation MBXBDownloadOperation
+(instancetype)operationWithUrling : (NSString *)urlString
{
    //初始化操作
    MBXBDownloadOperation *op = [[MBXBDownloadOperation alloc]init];
    //记录urlString
    op.urlString = urlString;
    return op;
}

-(void)main
{
    NSURL *url = [NSURL URLWithString:self.urlString];
    //通过url获取二进制数据
    NSData *data = [NSData dataWithContentsOfURL:url];
    //将二进制数据改成
    UIImage *image = [UIImage imageWithData:data];
    //将数据写到沙河中
    [data writeToFile:[self.urlString appendCachePath]atomically:true];
    
    self.image =image;
    
}


@end
