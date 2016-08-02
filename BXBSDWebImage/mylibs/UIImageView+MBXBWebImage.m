//
//  UIImageView+MBXBWebImage.m
//  BXBSDWebImage
//
//  Created by 毕向北 on 16/8/1.
//  Copyright © 2016年 bifujian. All rights reserved.
//

#import "UIImageView+MBXBWebImage.h"
#import "MBXBDownloadManager.h"
#import <objc/runtime.h>
const char *kUrlString = "kUrlString";
@implementation UIImageView (MBXBWebImage)
- (void)bxb_setImageWithUrlstring:(NSString *)string placeholderImage:(UIImage *)image
{
    if(self.urlString !=nil && ![self.urlString isEqualToString:string])
    {
        NSLog(@"之前的操作取消了");
        [[MBXBDownloadManager shardManager] cancelOperationWithUrlstring:self.urlString];
    }
    //记录并保存
    //如果每张图片下载的时长不一定,还是会产生图片错乱,解决办法
    self.urlString =string;
    [[MBXBDownloadManager shardManager] downLoadImageWithUrlString:string compeletion:^(UIImage *image) {
        NSLog(@"已经下载好的图片%@",image);
        self.image =image;
        self.urlString = nil;
    }];
}
- (void)setUrlString:(NSString *)urlString
{
    //使用对象进行关联-需要用到运行时中的关联-应用场景-在分类中定义属性,给当前对象进行保值
    //参数:
    //1.要给谁关联
    //2.关联的key
    //3.关联的值
    //4.关联策略
//    OBJC_ASSOCIATION_ASSIGN = 0,           /**< Specifies a weak reference to the associated object. */
//    OBJC_ASSOCIATION_RETAIN_NONATOMIC = 1, /**< Specifies a strong reference to the associated object.
//                                            *   The association is not made atomically. */
//    OBJC_ASSOCIATION_COPY_NONATOMIC = 3,   /**< Specifies that the associated object is copied.
//                                            *   The association is not made atomically. */
//    OBJC_ASSOCIATION_RETAIN = 01401,       /**< Specifies a strong reference to the associated object.
//                                            *   The association is made atomically. */
//    OBJC_ASSOCIATION_COPY = 01403          /**< Specifies that the associated object is copied.
//                                            *   The association is made atomically. */
    objc_setAssociatedObject(self, kUrlString, urlString, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(NSString *)urlString
{
    return objc_getAssociatedObject(self,kUrlString);
}
@end
