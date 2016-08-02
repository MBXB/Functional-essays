//
//  BXBAPPCellTableViewCell.m
//  BXBSDWebImage
//
//  Created by 毕向北 on 16/7/31.
//  Copyright © 2016年 bifujian. All rights reserved.
//

#import "BXBAPPCellTableViewCell.h"


@implementation BXBAPPCellTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupUI];
    // Initialization code
}
- (void)setupUI
{
//    BXBAPPInfoModel *infoMD = [[BXBAPPInfoModel alloc]init];
//    self.iconImage.image = infoMD.iamge;
//    self.nameLB.text = infoMD.name;
//    self.downLoadLB.text = infoMD.downLoad;

}
-(void)setInfoMD:(BXBAPPInfoModel *)infoMD
{
    _infoMD = infoMD;
    self.iconImage.image = self.infoMD.iamge;
    self.nameLB.text = self.infoMD.name;
    self.downLoadLB.text = self.infoMD.downLoad;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
