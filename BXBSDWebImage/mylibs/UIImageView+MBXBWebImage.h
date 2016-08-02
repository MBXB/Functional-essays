//
//  UIImageView+MBXBWebImage.h
//  BXBSDWebImage
//
//  Created by 毕向北 on 16/8/1.
//  Copyright © 2016年 bifujian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (MBXBWebImage)
@property (nonatomic,strong)NSString *urlString;
- (void)bxb_setImageWithUrlstring:(NSString *)string placeholderImage:(UIImage *)image;
@end
