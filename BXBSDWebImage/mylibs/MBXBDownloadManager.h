//
//  MBXBDownloadManager.h
//  MBXBWebImage
//
//  Created by 毕向北 on 16/7/31.
//  Copyright © 2016年 bifujian. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface MBXBDownloadManager : NSObject
//单例:全局访问点
+(instancetype)shardManager;
//下载图片的调用方法;异步操作不能直接给当前函数提供返回值;需要使用block进行回调
- (void)downLoadImageWithUrlString : (NSString *)urlString
compeletion :(void(^)(UIImage *))compeletion;
- (void)cancelOperationWithUrlstring : (NSString *)urlstring;
@end
