//
//  MineGroupThreeViewController.m
//  360du
//
//  Created by 利美 on 16/6/8.
//  Copyright © 2016年 wangjian. All rights reserved.
//

#import "MineGroupThreeViewController.h"
#import "AFNetworkTwoPackaging.h"
#import "StoreageMessage.h"
#import "MIneGroupModel.h"
#import "UIView+Toast.h"
#import "MineGroupTableViewCell.h"
#import "MIneGroupModel.h"
#import "MJRefresh.h"
#import "OrderDetialViewController.h"
#import "LogisticsViewController.h"
#import "OrderListModel.h"
#import "OrderDeatilViewController.h"
#import "OrderDetialViewController.h"
#import "CWHOrderDetialViewController.h"
#import "OrderListModel.h"
#import "WeChantViewViewController.h"
#import "LogisticsViewController.h"

@interface MineGroupThreeViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray *_serverDataArr;
    NSMutableArray *_dataArr;
}
@property (strong, nonatomic) UITableView *tableView;
@property (nonatomic ,copy) NSString *cpid,*cppicture;

@property (nonatomic ,copy) NSString *payName;
@property (nonatomic ,copy) NSString *payNumber;
@property (nonatomic ,copy) NSString *ccpo;
@property (nonatomic ,assign) NSInteger index, maxIndex;
@property (nonatomic ,strong) NSMutableArray *sectionArr;
@property (nonatomic ,strong) NSMutableArray *rowArr;
@property (nonatomic ,strong) NSIndexPath *tableIndexPath;
@end

@implementation MineGroupThreeViewController
//-(void)viewWillAppear:(BOOL)animated{
//    self.automaticallyAdjustsScrollViewInsets = NO;
//    [self givieStatue];
//}
//-(void)viewDidLoad{
//    [super viewDidLoad];
//    [self setNavBarImage:@"landi.png"];
//    //[self setBackgroud:@"lantiao x.png"];
//    [self setBackImageStateName:@"fanhuijian02.png" AndHighlightedName:@""];
//    
////    [self setNavTitleItemWithName:@"个人中心"];
//    [self makeHUd];
//    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTENTVIEW, HEIGHT_CONTENTVIEW-110)];    self.tableView.delegate = self;
//    self.tableView.dataSource = self;
////    self.tableView.backgroundColor = [UIColor yellowColor];
//    //    _serverDataArr = [NSMutableArray arrayWithCapacity:0];
//    //    _dataArr = [NSMutableArray arrayWithCapacity:0];
////    [self setBackImageStateName:@"fanhuijian02.png" AndHighlightedName:@""];
//    [self.view addSubview:self.tableView];
//    self.automaticallyAdjustsScrollViewInsets = NO;
//    [self givieStatue];
//}
//
//
//- (void)givieStatue{
//    AFNetworkTwoPackaging *twoPack = [[AFNetworkTwoPackaging alloc] init];
//    NSString *url = nil;
// 
//
//    //    }
//    
//    //    if ([statue isEqualToString:@"3"]){
//    url = [NSString stringWithFormat:MINEGROUPBUY,[StoreageMessage getMessage][2],@"4"];
//    
//    [twoPack getUrl:url andFinishBlock:^(id getResult) {
////        NSLog(@"%@",getResult);
//        [self hudWasHidden:self.hudProgress];
//        [self.tableView headerEndRefreshing];
//
//        _dataArr =  [NSMutableArray arrayWithCapacity:0];
//        if ([getResult[@"code"] isEqualToString:@"000000"]) {
//            if ([getResult[@"datas"] count] == 0) {
//                [self.view makeToast:getResult[@"message"]];
//                return ;
//            }
//            for (NSDictionary *dict in getResult[@"datas"]) {
//                MIneGroupModel *model = [[MIneGroupModel alloc] initWithDictionary:dict];
//                [_dataArr addObject:model];
//            }
//        }else{
//            [self.view makeToast:getResult[@"message"]];
//        }
//        [self.tableView reloadData];
//    }];
//}
////}
//
//#pragma mark tableViewdelegate
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
////    NSLog(@"count::%lu",(unsigned long)_dataArr.count);
//    return _dataArr.count;
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 220 *self.numSingleVesion;
//}
//
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    MIneGroupModel *model = _dataArr[indexPath.row];
//    OrderDetialViewController *order =  [[OrderDetialViewController alloc] initWithModel:model];
//    [self.navigationController pushViewController:order animated:YES];
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    MineGroupTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MineGroupTableViewCell class])];
//    if (!cell) {
//        cell = [[MineGroupTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([MineGroupTableViewCell class])];
//        
//    }
//    MIneGroupModel *model = _dataArr[indexPath.row];
//    self.cpid = model.ccpo;
//    self.cppicture = model.cppicture;
////    NSLog(@"asdasdasdasd%ld",(long)model.orderStatus.integerValue);
//    //    cell.nameLab.text = model.name;
//    cell.tag1 = @"4";
//    cell.groupModel = model;
//    cell.target = self;
//    [cell.payBtn addTarget:self action:@selector(viewDidLoad) forControlEvents:UIControlEventTouchUpInside];
//    [cell.shouHuoBtn addTarget:self action:@selector(viewDidLoad) forControlEvents:UIControlEventTouchUpInside];
//    [cell.logisticsBtn addTarget:self action:@selector(logisticsAction:) forControlEvents:UIControlEventTouchUpInside];
//    return cell;
//}
//
//-(void)logisticsAction:(UIButton *)btn{
//    if ([btn.titleLabel.text isEqualToString:@"查看物流"]) {
//        
//        ;
//        
//        LogisticsViewController *cleanerViewController = [[UIStoryboard storyboardWithName:@"MineGroupStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"logistics"];
//        cleanerViewController.cpid = self.cpid;
//        cleanerViewController.imageUrl = self.cppicture;
//        //        LogisticsViewController *Logistics = [[LogisticsViewController alloc] init];
//        [self.navigationController pushViewController:cleanerViewController animated:YES];
//    }
//}
//-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
//    if (scrollView.contentOffset.y < -50) {
//        [self.tableView headerBeginRefreshing];
//        self.tableView.headerRefreshingText = @"正在刷新";
//        //loadData
//        //[self.dataArr removeAllObjects];
//        [self.tableView addHeaderWithTarget:self action:@selector(givieStatue)];
//    }
//    if (scrollView.contentOffset.y > scrollView.contentSize.height + 50) {
//        //[self.tableView ]
//    }
//}
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)viewWillAppear:(BOOL)animated{
    //    self.automaticallyAdjustsScrollViewInsets = NO;
    //    [self givieStatue];
//    self.index = 1;
    [self forData];

}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavBarImage:@"landi.png"];
    //[self setBackgroud:@"lantiao x.png"];
    [self setBackImageStateName:@"fanhuijian02.png" AndHighlightedName:@""];
    [self makeHUd];
    self.index = 1;
//    [self forData];
    //    [self setNavTitleItemWithName:@"个人中心"];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTENTVIEW, HEIGHT_CONTENTVIEW-110)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //    self.tableView.backgroundColor = [UIColor yellowColor];
    //    _serverDataArr = [NSMutableArray arrayWithCapacity:0];
    //    _dataArr = [NSMutableArray arrayWithCapacity:0];
    [self setBackImageStateName:@"fanhuijian02.png" AndHighlightedName:@""];
    [self.view addSubview:self.tableView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.tableView addFooterWithTarget:self action:@selector(forIndexData)];
    self.tableView.footerPullToRefreshText = @"上拉可以加载更多数据了";
    self.tableView.footerReleaseToRefreshText = @"松开马上加载更多数据";
    self.tableView.footerRefreshingText = @"正在加载，请稍后";
    //    [self givieStatue];
    // Do any additional setup after loading the view.
}
//- (void)givieStatue{
//    AFNetworkTwoPackaging *twoPack = [[AFNetworkTwoPackaging alloc] init];
//    NSString *url = nil;
//        url = [NSString stringWithFormat:MINEGROUPBUY,[StoreageMessage getMessage][2],@"0"];
////    NSLog(@"1212%@",url);
//
//        [twoPack getUrl:url andFinishBlock:^(id getResult) {
////            NSLog(@"getResult::%@",getResult);
//            [self hudWasHidden:self.hudProgress];
//            [self.tableView headerEndRefreshing];
//
//            _dataArr = [NSMutableArray arrayWithCapacity:0];
//            if ([getResult[@"code"] isEqualToString:@"000000"]) {
//                if ([getResult[@"datas"] count] == 0) {
////                    [self.view makeToast:getResult[@"message"]];
//                    return ;
//                }
//                for (NSDictionary *dict in getResult[@"datas"]) {
//                    MIneGroupModel *model = [[MIneGroupModel alloc] initWithDictionary:dict];
//                    [_dataArr addObject:model];
//                }
//            }else{
////                [self.view makeToast:getResult[@"message"]];
//            }
//            [_tableView reloadData];
//
//        }];
//    }
//
//
//#pragma mark tableViewdelegate
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
////    NSLog(@"count::%lu",(unsigned long)_dataArr.count);
//    return _dataArr.count;
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 220 *self.numSingleVesion;
//}
//
//
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    MineGroupTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MineGroupTableViewCell class])];
//    if (!cell) {
//        cell = [[MineGroupTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([MineGroupTableViewCell class])];
//
//    }
//    MIneGroupModel *model = _dataArr[indexPath.row];
//
////    self.cpid = model.ccpo;
////    self.cppicture = model.cppicture;
////    NSLog(@"cpid:%@",self.cpid);
////    NSLog(@"%ld",(long)model.orderStatus.integerValue);
////    cell.nameLab.text = model.name;
//    cell.tag1 = @"1";
//    cell.groupModel = model;
//    if ([cell.payBtn.titleLabel.text isEqualToString:@"已过期"] && [cell.payBtn.titleLabel.text isEqualToString:@"处理中"]) {
//        cell.payBtn.userInteractionEnabled = NO;
//    }
//    cell.target = self;
//    cell.logisticsBtn.tag = indexPath.row;
//    [cell.logisticsBtn addTarget:self action:@selector(logisticsAction:) forControlEvents:UIControlEventTouchUpInside];
//    [cell.payBtn addTarget:self action:@selector(viewDidLoad) forControlEvents:UIControlEventTouchUpInside];
//    [cell.shouHuoBtn addTarget:self action:@selector(viewDidLoad) forControlEvents:UIControlEventTouchUpInside];
//
//
//
//
//
//
//    return cell;
//}
//
//-(void)logisticsAction:(UIButton *)btn{
////    NSLog(@"12121212144444444%ld",(long)btn.tag);
//        MIneGroupModel *model = _dataArr[btn.tag];
//
//        self.cpid = model.ccpo;
//        self.cppicture = model.cppicture;
//
//
//    if ([btn.titleLabel.text isEqualToString:@"查看物流"]) {
//        LogisticsViewController *cleanerViewController = [[UIStoryboard storyboardWithName:@"MineGroupStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"logistics"];
//        cleanerViewController.cpid = self.cpid;
//        cleanerViewController.imageUrl = self.cppicture;
////        LogisticsViewController *Logistics = [[LogisticsViewController alloc] init];
//        [self.navigationController pushViewController:cleanerViewController animated:YES];
//    }
//}
//
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    MIneGroupModel *model = _dataArr[indexPath.row];
//    OrderDetialViewController *order =  [[OrderDetialViewController alloc] initWithModel:model];
//    [self.navigationController pushViewController:order animated:YES];
//}
//
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (scrollView.contentOffset.y < -50) {
        [self.tableView headerBeginRefreshing];
        self.tableView.headerRefreshingText = @"正在刷新";
        //loadData
        //[self.dataArr removeAllObjects];
        [self.tableView addHeaderWithTarget:self action:@selector(forData)];
    }
//    if (scrollView.contentOffset.y > scrollView.contentSize.height + 150)
//    if (scrollView.contentOffset.y > 50)
//    
//    {
//        //[self.tableView ]
//        [self.tableView footerBeginRefreshing];
//        self.tableView.footerRefreshingText = @"将要加载更多...";
//        //loadData
//        //[self.dataArr removeAllObjects];
////        [self.tableView addHeaderWithTarget:self action:@selector(forData)];
//        [self.tableView addFooterWithTarget:self action:@selector(forIndexData)];
//    }
}





-(void) forIndexData{
    if (self.maxIndex > self.index) {
        self.index ++;
    }else{
        [self.tableView footerEndRefreshing];
        
        return;
    }
    
    NSLog(@"%ld",self.index);
    
    AFNetworkTwoPackaging *twoPacking = [[AFNetworkTwoPackaging alloc] init];
    [twoPacking getUrl:[NSString stringWithFormat:GETORDERLISTPAGERBYSTATUS,[StoreageMessage getMessage][2],[NSString stringWithFormat:@"%ld",self.index],@"3"] andFinishBlock:^(id getResult) {
        [self hudWasHidden:self.hudProgress];
        [self.tableView headerEndRefreshing];
        [self.tableView footerEndRefreshing];
        NSLog(@"%@",getResult);
        self.sectionArr = [NSMutableArray arrayWithCapacity:0];
        self.rowArr = [NSMutableArray arrayWithCapacity:0];
        
        for (NSDictionary *dic1 in getResult[@"datas"]) {
            NSMutableArray *arr1 = [NSMutableArray arrayWithCapacity:0];
            OrderListModel *model1 = [[OrderListModel alloc] initWithDictionary:dic1];
            for (NSDictionary *dic2 in dic1[@"itemArray"]) {
                OrderListModel *model2 = [[OrderListModel alloc] initWithDictionary:dic2];
                [arr1 addObject:model2];
                
            }
            [self.rowArr addObject:arr1];
            [self.sectionArr addObject:model1];
            
        }
        //        NSLog(@"%@- - - - - - - - %@",self.rowArr,self.sectionArr);
        [self.tableView reloadData];
    }];


}




























-(void)forData{
    AFNetworkTwoPackaging *twoPacking = [[AFNetworkTwoPackaging alloc] init];
    [twoPacking getUrl:[NSString stringWithFormat:GETORDERLISTPAGERBYSTATUS,[StoreageMessage getMessage][2],@"1",@"3"] andFinishBlock:^(id getResult) {
        [self hudWasHidden:self.hudProgress];
        [self.tableView headerEndRefreshing];
        [self.tableView footerEndRefreshing];
        NSLog(@"%@",getResult);
        self.sectionArr = [NSMutableArray arrayWithCapacity:0];
        self.rowArr = [NSMutableArray arrayWithCapacity:0];
        if ([getResult[@"totalRows"] integerValue] % 10 == 0) {
            self.maxIndex = [getResult[@"totalRows"] integerValue] / 10;
        }else{
            self.maxIndex = [getResult[@"totalRows"] integerValue] / 10 + 1;
        }
        NSLog(@"%ld",self.index);
        for (NSDictionary *dic1 in getResult[@"datas"]) {
            NSMutableArray *arr1 = [NSMutableArray arrayWithCapacity:0];
            OrderListModel *model1 = [[OrderListModel alloc] initWithDictionary:dic1];
            for (NSDictionary *dic2 in dic1[@"itemArray"]) {
                OrderListModel *model2 = [[OrderListModel alloc] initWithDictionary:dic2];
                [arr1 addObject:model2];
                
            }
            [self.rowArr addObject:arr1];
            [self.sectionArr addObject:model1];
            
        }
        //        NSLog(@"%@- - - - - - - - %@",self.rowArr,self.sectionArr);
        [self.tableView reloadData];
    }];
}


-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  [self.rowArr[section] count] + 3;
}


-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return self.sectionArr.count;
}


-(CGFloat ) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 48;
    }else if (indexPath.row == [self.rowArr[indexPath.section] count] + 1){
        return 48;
    }
    else if (indexPath.row == [self.rowArr[indexPath.section] count] + 2){
        return 48;
    }else{
        return 144;
    }
    return 200;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 4;
    }
    return 10;//section头部高度
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    self.tableIndexPath = indexPath;
    NSString *CellIdentifier = [NSString stringWithFormat:@"shopCarCell%ld%ld", (long)[indexPath section], (long)[indexPath row]];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier ];
//    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//    }
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 0) {
        OrderListModel *model = self.sectionArr[indexPath.section];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(8, 8, WIDTH_CONTENTVIEW - 16, 30)];
        label.text = model.shopName;
        label.font = [UIFont systemFontOfSize:16];
        [cell.contentView addSubview:label];
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH_CONTENTVIEW - 100, 8, 88, 30)];
        if (model.payStatus.integerValue == 0) {
            if (model.status.integerValue != 5 && model.status.integerValue != 16 ) {
                label1.text = model.payStatusName;
                
            }
        }else{
            label1.text = model.StatusName;
        }
        label1.font = [UIFont systemFontOfSize:15];
        label1.textAlignment = UITextAlignmentRight;
        
        label1.textColor = [UIColor redColor];
        [cell.contentView addSubview:label1];
    }else if (indexPath.row == [self.rowArr[indexPath.section] count] + 2){
        OrderListModel *model = self.sectionArr[indexPath.section];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(WIDTH_CONTENTVIEW - 210, 0, 100, 48);
        [button addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        //        button.backgroundColor = [UIColor redColor];
        [cell.contentView addSubview:button];
        
        
        UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
        button2.frame = CGRectMake(WIDTH_CONTENTVIEW - 120, 0, 100, 48);
        [button2 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        NSLog(@"%@--%@",model.payStatus,model.status);
        button2.tag = 151885;
        
        if ([model.payStatus isEqualToString:@"0"]) {
            if ([model.status isEqualToString:@"5"] || [model.status isEqualToString:@"16"]) {
                
                
            }else{
                button2.backgroundColor = [UIColor redColor];
                [button2 setTitle:@"付款" forState:UIControlStateNormal];
            }
        }else{
            if ([model.status isEqualToString:@"1"] || [model.status isEqualToString:@"2"] || [model.status isEqualToString:@"3"]|| [model.status isEqualToString:@"4"]|| [model.status isEqualToString:@"7"]|| [model.status isEqualToString:@"10"]|| [model.status isEqualToString:@"12"]|| [model.status isEqualToString:@"13"]) {
                if (model.shopType.integerValue == 2) {
                    button.backgroundColor = [UIColor redColor];
                    button.tag = 151884;
                    [button setTitle:@"查看物流" forState:UIControlStateNormal];
                }
                if (model.status.integerValue != 4 && model.status.integerValue != 7) {
                    button2.backgroundColor = [UIColor redColor];
                    [button2 setTitle:@"确认收货" forState:UIControlStateNormal];
                }
            }else{
                [cell.contentView removeFromSuperview];
            }
            
        }
        [cell.contentView addSubview:button2];
        
        
    }else if (indexPath.row == [self.rowArr[indexPath.section] count] +1){
        OrderListModel *model = self.sectionArr[indexPath.section];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH_CONTENTVIEW - 150, 8, 140, 30)];
        label.text = [NSString stringWithFormat:@"总价：¥%@",model.price];
        label.textColor = [UIColor orangeColor];
        label.textAlignment = NSTextAlignmentRight;
        label.font = [UIFont systemFontOfSize:16];
        [cell.contentView addSubview:label];
    }
    else{
        OrderListModel *model = self.rowArr[indexPath.section][indexPath.row -1];
        cell.contentView.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
        UIImageView *proImage = [[UIImageView alloc] initWithFrame:CGRectMake(8, 8, 100, 100)];
        [proImage sd_setImageWithURL:[NSURL URLWithString:model.proPic] placeholderImage:[UIImage imageNamed:@"order_manager_n.png"]];
        [cell.contentView addSubview:proImage];
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(116, 8, WIDTH_CONTENTVIEW - 116 , 30)];
        lab.text = model.proName;
        //    lab.backgroundColor = [UIColor blueColor];
        lab.numberOfLines = 0;
        [cell.contentView addSubview:lab];
        UILabel *lab2 = [[UILabel alloc] initWithFrame:CGRectMake(116, 78, 100 , 30)];
        lab2.text = [NSString stringWithFormat:@"¥%0.2f",model.proPrice.floatValue];
        lab2.numberOfLines = 0;
        [cell.contentView addSubview:lab2];
        UILabel *lab3 = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH_CONTENTVIEW - 46, 78,60, 30)];
        lab3.text = [NSString stringWithFormat:@"x%@",model.proCount];
        //    lab3.backgroundColor = [UIColor redColor];
        lab3.textColor = [UIColor redColor];
        lab3.numberOfLines = 0;
        [cell.contentView addSubview:lab3];
        
    }
    return cell;
}

-(void) btnAction:(UIButton *)center{
    OrderListModel *model = self.sectionArr[self.tableIndexPath.section ];
    NSLog(@"%@",model.price);
    self.payNumber = model.price;
    self.ccpo = model.orderId;
    self.payName = model.shopName;
    if (center.tag == 151884) {
        if ([center.titleLabel.text isEqualToString:@"查看物流"]) {
            LogisticsViewController *cleanerViewController = [[UIStoryboard storyboardWithName:@"MineGroupStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"logistics"];
            NSLog(@"%@",model.proPic);
            cleanerViewController.cpid = self.ccpo;
            cleanerViewController.imageUrl = model.proPic;
            //        LogisticsViewController *Logistics = [[LogisticsViewController alloc] init];
            [self.navigationController pushViewController:cleanerViewController animated:YES];
        }
    }else{
        if ([center.titleLabel.text isEqualToString:@"付款"]) {
            
            UIAlertView*alert = [[UIAlertView alloc]initWithTitle:@"提示"
                                 
                                                          message:@"请选择支付方式："
                                 
                                                         delegate:self
                                 
                                                cancelButtonTitle:@"取消"
                                 
                                                otherButtonTitles:@"使用微信支付",
                                 @"使用支付宝支付",
                                 nil];
            [alert show];
        }
        if ([center.titleLabel.text isEqualToString:@"确认收货"]) {
            NSLog(@"333%@",_ccpo);
            AFNetworkTwoPackaging *twoPack = [[AFNetworkTwoPackaging alloc] init];
            NSString *url = nil;
            
            url = [NSString stringWithFormat:CONFIRMFINISHED,model.orderId];
            NSLog(@"333%@",url);
            
            [twoPack getUrl:url andFinishBlock:^(id getResult) {
                //                NSLog(@"%@",getResult);
                [self.view makeToast:getResult[@"message"]];
            }];
            
        }
        
    }
    
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex

{
    if (buttonIndex == 1) {
        //         [WeChantViewViewController payName:_payName andMoney:[NSString stringWithFormat:@"%0.2f",_payNumber.floatValue * 100 ]];
        //        NSLog(@"%@",[NSString stringWithFormat:@"GB%@",_ccpo]);
        [WeChantViewViewController payName:_payName andMoney:[NSString stringWithFormat:@"%0.2f",_payNumber.floatValue *100] andOder:[NSString stringWithFormat:@"GB%@",_ccpo]];
    }else if (buttonIndex == 2){
        //        AlipayViewController *aliPay = [[AlipayViewController alloc] initPrice:[NSString stringWithFormat:@"%0.2f",_payNumber.floatValue] andDescMerchant:nil andTitle:_payName andMerOrder:nil];
        //
        //        id next = [self nextResponder] ;
        //
        //        while (next != nil) {
        //
        //            next = [next nextResponder];
        //
        //            if ([next isKindOfClass:[MineGroupViewController class]]) {
        //                //                NSLog(@"qwqwqw%@",next);
        //                //                NSLog(@"%@",[NSString stringWithFormat:@"GB%@",_ccpo]);
        //                //
        //                //                [next pushViewController:aliPay animated:YES];
        [WeChantViewViewController payTHeMoneyUseAliPayWithOrderId:[NSString stringWithFormat:@"GB%@",_ccpo] totalMoney:[NSString stringWithFormat:@"%0.2f",_payNumber.floatValue] payTitle:_payName];
        return;
        
        //            }
        //        }
    }
    
    
}


-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld--%ld",indexPath.row,indexPath.section);
    //    OrderListModel *model = self.rowArr[indexPath.section][indexPath.row - 1];
    OrderListModel *model = self.sectionArr[indexPath.section];
    NSLog(@"%@",model.shopType);
    
    if ([model.shopType isEqualToString:@"2"]) {
        //        OrderDetialViewController *order =  [[OrderDetialViewController alloc] initWithModel:model];
        //        [self.navigationController pushViewController:order animated:YES];
        CWHOrderDetialViewController *CWH = [[CWHOrderDetialViewController alloc] initWithOrderId:model.orderId];
        //        CWH.orderId = model.orderId;
        [self.navigationController pushViewController:CWH animated:YES];
    }
    if ([model.shopType isEqualToString:@"1"]) {
        OrderDeatilViewController *orderDeatil = [[OrderDeatilViewController alloc] initWithOrderId:model.orderId andNavTitle:model.shopName];
        orderDeatil.stateName = model.payStatusName;
        orderDeatil.merchantId = model.did;
        orderDeatil.starCount = model.sendPrice;
        orderDeatil.finalPrice = model.price;
        orderDeatil.personalName = model.Name;
        [self.navigationController pushViewController:orderDeatil animated:YES];
    }
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
