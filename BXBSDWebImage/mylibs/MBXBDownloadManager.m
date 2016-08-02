//
//  MBXBDownloadManager.m
//  MBXBWebImage
//
//  Created by 毕向北 on 16/7/31.
//  Copyright © 2016年 bifujian. All rights reserved.
//

#import "MBXBDownloadManager.h"
#import "MBXBDownloadOperation.h"
#import "NSString+path.h"
@interface MBXBDownloadManager()
//下载操作的缓存,避免重复下载
@property (nonatomic,strong)NSMutableDictionary *operationCache;
//图片缓存的字典(key:地址 value:图片)
@property (nonatomic,strong)NSMutableDictionary *imageCache;
//操作队列
@property (nonatomic,strong)NSOperationQueue *queue;
@end
@implementation MBXBDownloadManager
+(instancetype)shardManager
{
    static MBXBDownloadManager *instance;
    //只执行一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc]init];
    });
    
    return instance;
}
-(instancetype)init
{
    self = [super init];
    if(self)
    {
        self.operationCache = [NSMutableDictionary dictionary];
        self.imageCache = [NSMutableDictionary dictionary];
        self.queue = [[NSOperationQueue alloc]init];
        [[NSNotificationCenter  defaultCenter] addObserver:self selector:@selector(memoryWarning) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
        
    }
    //注册内存警告的通知!!!
    [[NSNotificationCenter  defaultCenter] addObserver:self selector:@selector(memoryWarning) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];

    return self;
}
- (void)downLoadImageWithUrlString : (NSString *)urlString
  compeletion :(void(^)(UIImage *))compeletion
{
    //断言
//    NSAssert(compeletion==nil, @"必须传入回调的block");
    //判断操作有没有,如果有什么都不做直接返回
    if (self.operationCache[urlString]!=nil) {
        NSLog(@"图片正下载中,请骚等!!!");
        return;
    }
    //图片往内存中去
    UIImage *image = self.imageCache[urlString];
    if(image != nil)
    {
        NSLog(@"从内存中取");
        //直接进行回调
        compeletion(image);
        return;
    }
    //判断沙河中有没有
    //1.取到沙河的路径
    NSString *sanboxPath = [urlString appendCachePath];
    image = [UIImage imageWithContentsOfFile:sanboxPath];
    if(image != nil)
    {
        //从沙河中取
        NSLog(@"从沙河中获取");
        compeletion(image);
        //由于在沙河中获取慢将沙河中的数据存到内存中
        [self.imageCache setObject:image forKey:urlString];
        return;
    }
    
    
    
    //创建一个操作下载图片
    MBXBDownloadOperation *operation = [MBXBDownloadOperation operationWithUrling:urlString];
    //处理循环引用问题
    __weak MBXBDownloadOperation *weakSelf = operation;
    //监听图片下载完成
    [operation setCompletionBlock:^{
        UIImage *image = weakSelf.image;
        //主线程回调,将image传出去
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            compeletion(image);
            //保存到内存中一份
            [self.imageCache setObject:image forKey:urlString];
            //将当前操作从缓存中移除
            [self.operationCache removeObjectForKey:urlString];
        }];
        
    }];
    //将操作添加至操作的缓存
    [self.operationCache setObject:operation forKey:urlString];
    //将操作添加至队列
    [self.queue addOperation:operation];
    //测试
    NSLog(@"创建操作下载image");
}
- (void)cancelOperationWithUrlstring : (NSString *)urlstring
{
    //取消操作
    //第一步首先取到这个操作
    NSOperation *op = [self.operationCache objectForKey:urlstring];
    //取消
    if(op!=nil)
    {
        [op cancel];
        [self.operationCache removeObjectForKey:urlstring];
    }
}

//内存警告????
- (void)memoryWarning

{
    //清除图片
    [self.imageCache removeAllObjects];
    //清除操作
    [self.operationCache removeAllObjects];
    //取消所有队列中的操作
    [self.queue cancelAllOperations];
    
}
//移除通知
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}


@end
