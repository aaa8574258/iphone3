//
//  MineGroupViewController.m
//  360du
//
//  Created by linghang on 16/3/2.
//  Copyright © 2016年 wangjian. All rights reserved.
//

#import "MineGroupViewController.h"
#import "AFNetworkTwoPackaging.h"
#import "StoreageMessage.h"
#import "MIneGroupModel.h"
#import "UIView+Toast.h"
#import "MineGroupTableViewCell.h"
#import "MIneGroupModel.h"
@interface MineGroupViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray *_serverDataArr;
    NSMutableArray *_dataArr;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MineGroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _serverDataArr = [NSMutableArray arrayWithCapacity:0];
    _dataArr = [NSMutableArray arrayWithCapacity:0];
    [self setBackImageStateName:@"fanhuijian02.png" AndHighlightedName:@""];

    self.automaticallyAdjustsScrollViewInsets = NO;
    // Do any additional setup after loading the view.
}
- (void)setStatue:(NSString *)statue{
    AFNetworkTwoPackaging *twoPack = [[AFNetworkTwoPackaging alloc] init];
    NSString *url = nil;
    
    if ([statue isEqualToString:@"1" ]) {
        url = [NSString stringWithFormat:MINEGROUPBUY,[StoreageMessage getMessage][0],@"1"];
    }else if ([statue isEqualToString:@"2"]){
        url = [NSString stringWithFormat:MINEGROUPBUY,[StoreageMessage getMessage][0],@"2"];

    }else{
        url = [NSString stringWithFormat:MINEGROUPBUY,[StoreageMessage getMessage][0],@"3"];
 
    }
    [twoPack getUrl:url andFinishBlock:^(id getResult) {
        if ([getResult[@"code"] isEqualToString:@"000000"]) {
            if ([getResult[@"datas"] count] == 0) {
                [self.view makeToast:@"暂时没有数据"];
                return ;
            }
            for (NSDictionary *dict in getResult[@"datas"]) {
                MIneGroupModel *model = [[MIneGroupModel alloc] initWithDictionary:dict];
                [_dataArr addObject:model];
            }
            [_tableView reloadData];
        }else{
            [self.view makeToast:getResult[@"message"]];
        }
    }];
}

#pragma mark tableViewdelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 220 * self.numSingleVesion;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MineGroupTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MineGroupTableViewCell class]) forIndexPath:indexPath];
    if (!cell) {
        cell = [[MineGroupTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([MineGroupTableViewCell class])];
        
    }
    MIneGroupModel *model = _dataArr[indexPath.row];
    cell.groupModel = model;
    return nil;
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
