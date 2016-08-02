//
//  BXBSDController.m
//  BXBSDWebImage
//
//  Created by 毕向北 on 16/7/31.
//  Copyright © 2016年 bifujian. All rights reserved.
//
#import "UIImageView+MBXBWebImage.h"
#import "BXBSDController.h"
#import "UIImageView+WebCache.h"
#import "AFNetworking.h"
#import "AFHTTPSessionManager.h"
#import "BXBAPPInfoModel.h"
#import "BXBAPPCellTableViewCell.h"
#import "NSString+path.h"
#import "MBXBDownloadOperation.h"
#import "MBXBDownloadManager.h"
@interface BXBSDController ()
//存储
@property (nonatomic,strong)NSMutableArray *appInfos;
//下载操作的缓存,避免重复下载
@property (nonatomic,strong)NSMutableDictionary *queueCache;
//图片缓存的字典(key:地址 value:图片)
@property (nonatomic,strong)NSMutableDictionary *imageCache;
//操作
@property (nonatomic,strong)NSOperationQueue *queue;

@end

@implementation BXBSDController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    // Do any additional setup after loading the view.
}

- (void)loadData
{
    NSString *urlStr = @"https://raw.githubusercontent.com/yinqiaoyin/SimpleDemo/master/apps.json";
    //使用AFNetWorking初始化一个网络请求的管理器
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //测试
        //        NSLog(@"%@",[NSThread currentThread]);
        //        NSLog(@"请求成功%@--%@",responseObject,[responseObject class]);
        //字典转模型
        NSArray *array = responseObject;
        //初始化模型,将模型存储在可变数组中
        for (NSDictionary *dict in array) {
            BXBAPPInfoModel *info = [[BXBAPPInfoModel alloc]initWithDict:dict];
            //将模型添加到可变数组中
            [self.appInfos addObject:info];
        }
        //测试
        // NSLog(@"%@",_appInfos);
        //请求成功后刷新当然tableview
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",[NSThread currentThread]);
        NSLog(@"请求失败:%@",error);
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSUInteger count = self.appInfos.count;
    NSLog(@"%tu",count);
    return count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //自定义cell
    //缓存池中找
   BXBAPPCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid" forIndexPath:indexPath];
   //获取模型对应的位置
    BXBAPPInfoModel *infoModel = self.appInfos[indexPath.row];
    cell.infoMD = infoModel;
    cell.iconImage.image = nil;
    //sd的一句代码:可以干我们处理多线程网络加载的所有小bug
//    [cell.iconImage sd_setImageWithURL:[NSURL URLWithString:infoModel.icon]];
    [cell.iconImage bxb_setImageWithUrlstring:infoModel.icon placeholderImage:[UIImage imageNamed:@"user_default"]];
    return cell;
}

//懒加载
-(NSMutableArray *)appInfos
{
    if(_appInfos==nil)
    {
        _appInfos = [NSMutableArray array];
    }
    return _appInfos;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
