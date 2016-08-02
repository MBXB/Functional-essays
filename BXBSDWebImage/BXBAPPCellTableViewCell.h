//
//  BXBAPPCellTableViewCell.h
//  BXBSDWebImage
//
//  Created by 毕向北 on 16/7/31.
//  Copyright © 2016年 bifujian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BXBAPPInfoModel.h"
@interface BXBAPPCellTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLB;
@property (weak, nonatomic) IBOutlet UILabel *downLoadLB;
@property (nonatomic,strong)NSMutableArray *appInfos;;;;;;
@property (nonatomic,strong)BXBAPPInfoModel *infoMD;
@end
