//
//  ProertyPayCostViewController.m
//  360du
//
//  Created by 利美 on 16/10/21.
//  Copyright © 2016年 wangjian. All rights reserved.
//

#import "ProertyPayCostViewController.h"
#import "ProertyPayCostTableViewCell.h"
#import "StoreageMessage.h"
#import "ProertyPayModel.h"
#import "ProertyPayViewController.h"
#import "ProertyPayDetialViewController.h"
#import "MJRefresh.h"

@interface ProertyPayCostViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,weak) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArr;

@property (nonatomic ,copy) NSString *leftStr;

@end

@implementation ProertyPayCostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    if (self.dataArr.count == 0) {
//        UIImageView *imagev = [[UIImageView alloc] initWithFrame:CGRectZero];
//        [imagev setImage:[UIImage imageNamed:@"wushuju.png"]];
//        imagev.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
//        [self.tableView removeFromSuperview];
//        [self.view addSubview:imagev];
//    }else{
//        UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.frame];
//        tableView.delegate = self;
//        tableView.dataSource = self;
//        [self.view addSubview:tableView];
//        self.tableView = tableView;
//    }
    UIImageView *imagev = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width)];
    [imagev setImage:[UIImage imageNamed:@"wushuju.png"]];
    
    imagev.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
    [self.view addSubview:imagev];

}

-(void)viewWillAppear:(BOOL)animated{
    NSLog(@"%@",self.tag);

    [self makeNav];
    if (![self.target isKindOfClass:[ProertyPayCostViewController class]]) {//缴费账单
        if (self.tag.integerValue == 5) {
            [self giveInfo40];
        }else if (self.tag.integerValue == 4){
            [self giveInfo11];
        
        }else if (self.tag.integerValue == 6){
            [self giveInfo6];
            
        }else{
            [self giveInfo];
        }
    }else{//缴费记录
        if (self.tag.integerValue == 5) {
            [self giveInfo41];
        }else if (self.tag.integerValue == 4){
            
            [self giveInfo12];
        }else if (self.tag.integerValue == 6){
            [self giveInfo61];
            
        }else{
            [self giveInfo1];
        }
    }
    [self.tableView addHeaderWithTarget:self action:@selector(addHeader1)];
    self.tableView.headerRefreshingText = @"正在帮你刷新";

}


-(void)addHeader1{
    if (![self.target isKindOfClass:[ProertyPayCostViewController class]]) {
        if (self.tag.integerValue == 5) {
            [self giveInfo40];
        }else if (self.tag.integerValue == 4){
            [self giveInfo11];
            
        }else if (self.tag.integerValue == 6){
            [self giveInfo6];
            
        }else{
            [self giveInfo];
        }
    }else{
        if (self.tag.integerValue == 5) {
            [self giveInfo41];
        }else if (self.tag.integerValue == 4){
            
            [self giveInfo12];
        }else if (self.tag.integerValue == 6){
            [self giveInfo6];
            
        }else{
            [self giveInfo1];
        }
    }
}

-(void) giveInfo11{
    AFNetworkTwoPackaging *twoPacking = [[AFNetworkTwoPackaging alloc] init];
    [twoPacking getUrl:[NSString stringWithFormat:QNFNOTPAYMENT,[StoreageMessage getMessage][2]] andFinishBlock:^(id getResult) {
        NSLog(@"%@",getResult);
        self.dataArr = [NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *dic in getResult[@"datas"]) {
            ProertyPayModel *model = [[ProertyPayModel alloc] initWithDictionary:dic];
            [self.dataArr addObject:model];
            
        }
        NSLog(@"%lu",(unsigned long)[getResult[@"datas"] count]);
        if ([getResult[@"datas"] count] == 0) {
            
        }else{
            UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64)];
            tableView.delegate = self;
            tableView.dataSource = self;
            [self.view addSubview:tableView];
            self.tableView = tableView;
        }
        
        [self.tableView reloadData];
    }];
}

-(void) giveInfo12{
    AFNetworkTwoPackaging *twoPacking = [[AFNetworkTwoPackaging alloc] init];
    [twoPacking getUrl:[NSString stringWithFormat:QNFPAYMENT,[StoreageMessage getMessage][2]] andFinishBlock:^(id getResult) {
        NSLog(@"%@",getResult);
        self.dataArr = [NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *dic in getResult[@"datas"]) {
            ProertyPayModel *model = [[ProertyPayModel alloc] initWithDictionary:dic];
            [self.dataArr addObject:model];
            
        }
        NSLog(@"%lu",(unsigned long)[getResult[@"datas"] count]);
        if ([getResult[@"datas"] count] == 0) {
            
        }else{
            UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64)];
            tableView.delegate = self;
            tableView.dataSource = self;
            [self.view addSubview:tableView];
            self.tableView = tableView;
        }
        
        [self.tableView reloadData];
    }];
}

-(void)giveInfo40{
    AFNetworkTwoPackaging *twoPacking = [[AFNetworkTwoPackaging alloc] init];
    [twoPacking getUrl:[NSString stringWithFormat:WYFNOPAYMENT,[StoreageMessage getMessage][2]] andFinishBlock:^(id getResult) {
        NSLog(@"%@",getResult);
        self.dataArr = [NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *dic in getResult[@"datas"]) {
            ProertyPayModel *model = [[ProertyPayModel alloc] initWithDictionary:dic];
            [self.dataArr addObject:model];
            
        }
        NSLog(@"%lu",(unsigned long)[getResult[@"datas"] count]);
        if ([getResult[@"datas"] count] == 0) {
            
        }else{
            UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64)];
            tableView.delegate = self;
            tableView.dataSource = self;
            [self.view addSubview:tableView];
            self.tableView = tableView;
        }
        
        [self.tableView reloadData];
    }];
}


-(void)giveInfo41{
    AFNetworkTwoPackaging *twoPacking = [[AFNetworkTwoPackaging alloc] init];
    [twoPacking getUrl:[NSString stringWithFormat:WYFPAYMENT,[StoreageMessage getMessage][2]] andFinishBlock:^(id getResult) {
        NSLog(@"%@",getResult);
        self.dataArr = [NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *dic in getResult[@"datas"]) {
            ProertyPayModel *model = [[ProertyPayModel alloc] initWithDictionary:dic];
            [self.dataArr addObject:model];
            
        }
        NSLog(@"%lu",(unsigned long)[getResult[@"datas"] count]);
        if ([getResult[@"datas"] count] == 0) {
            
        }else{
            UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64)];
            tableView.delegate = self;
            tableView.dataSource = self;
            [self.view addSubview:tableView];
            self.tableView = tableView;
        }
        
        [self.tableView reloadData];
    }];
}



-(void)giveInfo{
    AFNetworkTwoPackaging *twoPacking = [[AFNetworkTwoPackaging alloc] init];
    [twoPacking getUrl:[NSString stringWithFormat:QUERYNEEDPAYMENTFEE,[StoreageMessage getMessage][2],self.tag] andFinishBlock:^(id getResult) {
        NSLog(@"%@",getResult);
        self.dataArr = [NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *dic in getResult[@"datas"]) {
            ProertyPayModel *model = [[ProertyPayModel alloc] initWithDictionary:dic];
            [self.dataArr addObject:model];
           
        }
        NSLog(@"%lu",(unsigned long)[getResult[@"datas"] count]);
        if ([getResult[@"datas"] count] == 0) {
            
        }else{
            UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64)];
            tableView.delegate = self;
            tableView.dataSource = self;
            [self.view addSubview:tableView];
            self.tableView = tableView;
        }

        [self.tableView reloadData];
    }];

}

-(void)giveInfo6{
    AFNetworkTwoPackaging *twoPacking = [[AFNetworkTwoPackaging alloc] init];
    [twoPacking getUrl:[NSString stringWithFormat:@"http://www.360duang.net/360duang/serviceServlet?serviceName=ParkingService&medthodName=tcfNotPayMent&memberId=%@",[StoreageMessage getMessage][2]] andFinishBlock:^(id getResult) {
        NSLog(@"%@",getResult);
        self.dataArr = [NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *dic in getResult[@"datas"]) {
            ProertyPayModel *model = [[ProertyPayModel alloc] initWithDictionary:dic];
            [self.dataArr addObject:model];
            
        }
        NSLog(@"%lu",(unsigned long)[getResult[@"datas"] count]);
        if ([getResult[@"datas"] count] == 0) {
            
        }else{
            UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64)];
            tableView.delegate = self;
            tableView.dataSource = self;
            [self.view addSubview:tableView];
            self.tableView = tableView;
        }
        
        [self.tableView reloadData];
    }];
    
}

-(void)giveInfo61{
    AFNetworkTwoPackaging *twoPacking = [[AFNetworkTwoPackaging alloc] init];
    [twoPacking getUrl:[NSString stringWithFormat:@"http://www.360duang.net/360duang/serviceServlet?serviceName=ParkingService&medthodName=tcfPayMent&memberId=%@",[StoreageMessage getMessage][2]] andFinishBlock:^(id getResult) {
        NSLog(@"%@",getResult);
        self.dataArr = [NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *dic in getResult[@"datas"]) {
            ProertyPayModel *model = [[ProertyPayModel alloc] initWithDictionary:dic];
            [self.dataArr addObject:model];
            
        }
        NSLog(@"%lu",(unsigned long)[getResult[@"datas"] count]);
        if ([getResult[@"datas"] count] == 0) {
            
        }else{
            UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64)];
            tableView.delegate = self;
            tableView.dataSource = self;
            [self.view addSubview:tableView];
            self.tableView = tableView;
        }
        
        [self.tableView reloadData];
    }];
    
}


-(void)giveInfo1{
    AFNetworkTwoPackaging *twoPacking = [[AFNetworkTwoPackaging alloc] init];
    NSLog(@"%@",[NSString stringWithFormat:QUERYHAVEPAYMENTFEE,[StoreageMessage getMessage][2],self.tag]);
    [twoPacking getUrl:[NSString stringWithFormat:QUERYHAVEPAYMENTFEE,[StoreageMessage getMessage][2],self.tag] andFinishBlock:^(id getResult) {
        NSLog(@"%@",getResult);
        self.dataArr = [NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *dic in getResult[@"datas"]) {
            ProertyPayModel *model = [[ProertyPayModel alloc] initWithDictionary:dic];
            [self.dataArr addObject:model];
            

        }
        if ([getResult[@"datas"] count] == 0) {
//            UIImageView *imagev = [[UIImageView alloc] initWithFrame:CGRectZero];
//            [imagev setImage:[UIImage imageNamed:@"wushuju.png"]];
//            imagev.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
//            [self.tableView removeFromSuperview];
//            [self.view addSubview:imagev];
        }else{
            UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64)];
            tableView.delegate = self;
            tableView.dataSource = self;
            [self.view addSubview:tableView];
            self.tableView = tableView;
        }
        [self.tableView reloadData];
    }];
}




-(void)makeNav{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"0.png"] forBarMetrics:UIBarMetricsDefault];
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(WIDTH_CONTROLLER - 32 , (44 - 20) / 2, 15, 15);
    [leftBtn setImage:[UIImage imageNamed:@"fanhuijian2222.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(setBack1) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftSecondItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectZero];
    if (![self.target isKindOfClass:[ProertyPayCostViewController class]]) {
        lable.text = @"缴费账单";
    }else{
        lable.text = @"缴费记录";
    }
    self.leftStr = lable.text;
    lable.font = [UIFont systemFontOfSize:19 * self.numSingleVesion];
    lable.textColor = [UIColor blackColor];
    [lable sizeToFit];
    lable.frame = CGRectMake(5 * self.numSingleVesion, 0 + (44 - 15) / 2, lable.frame.size.width, 15);
    [view addSubview:lable];
    view.frame = CGRectMake(0, 0, lable.frame.size.width, 44);
    UIBarButtonItem *centerBar = [[UIBarButtonItem alloc] initWithCustomView:view];
    self.navigationItem.leftBarButtonItems = @[leftSecondItem,centerBar];
    if (![self.target isKindOfClass:[ProertyPayCostViewController class]]) {
        UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        rightBtn.frame = CGRectMake(WIDTH_CONTROLLER - 60 * self.numSingleVesion, 5, 65 * self.numSingleVesion, 34 * self.numSingleVesion);
        [rightBtn setTitle:@"缴费记录" forState:UIControlStateNormal];
        [rightBtn setTitleColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1] forState:UIControlStateNormal];
        [rightBtn addTarget:self action:@selector(rightAct) forControlEvents:UIControlEventTouchUpInside];
        rightBtn.titleLabel.font = [UIFont systemFontOfSize:15 * self.numSingleVesion];
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
        self.navigationItem.rightBarButtonItem = rightItem;
    }
}


-(void)setBack1{

    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightAct{
    
    ProertyPayCostViewController  *controller = [[ProertyPayCostViewController alloc] init];
    controller.target = self;
    controller.tag = self.tag;
    [self.navigationController pushViewController:controller animated:YES];
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"%lu",(unsigned long)self.dataArr.count);
    return self.dataArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.tag.integerValue == 5 || self.tag.integerValue == 6) {
        return 120 *self.numSingleVesion;
    }
    return 70 * self.numSingleVesion;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ProertyPayCostTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"proertyPayCostCell"];
    cell = [[ProertyPayCostTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"proertyPayCostCell"];
//    cell.backgroundColor = [UIColor cyanColor];
    ProertyPayModel *model = self.dataArr[indexPath.row];
//    cell.weakLabel.backgroundColor = [UIColor redColor];
    if (self.tag.integerValue == 5 || self.tag.integerValue == 4) {
        if (self.tag.integerValue == 5) {
            cell.xqName.text = [NSString stringWithFormat:@"小区:%@",model.xqName];
            if (model.prompt.length != 0) {
                cell.cjText.text = [NSString stringWithFormat:@"缴费提示信息:%@",model.prompt];

            }
            if (model.promptTime.length != 0) {
                cell.cjTime.text = [NSString stringWithFormat:@"缴费提示时间:%@",model.promptTime];
            }
        }
        
        
        
        
        cell.picelabel.text = model.payMoney;
//        cell.weakLabel.text = model.payAccount;
//        [cell.weakLabel sizeToFit];
        if (model.payStatus.integerValue == 1) {
            NSString*string =model.payTime;
            NSLog(@"12121：%@",string);

            string = [string substringToIndex:10];//截取掉下标7之后的字符串
            NSLog(@"截取的值为：%@",string);
            NSString *str1,*str2;
            str1 =  [string substringFromIndex:5];//截取掉下标2之前的字符串
            NSLog(@"截取的值为：%@",str1);
            str2 = [string substringToIndex:4];
            NSLog(@"%@",str2);
            cell.weakLabel.text = str2;
            [cell.weakLabel sizeToFit];
            
            cell.timeLabel.text = str1;
            [cell.timeLabel sizeToFit];
            cell.picelabel.text = model.totalMoney;
            cell.picelabel.text = [NSString stringWithFormat:@"%@",model.payMoney];

        }else{
            NSLog(@"%@",model.payAccount);
            cell.weakLabel.text = [NSString stringWithFormat:@"%@",model.payAccount];
            [cell.weakLabel sizeToFit];
            
            
            NSString*string =model.payAccount;
            string = [string substringToIndex:10];//截取掉下标7之后的字符串
            NSLog(@"截取的值为：%@",string);
            NSString *str1,*str2;
            str1 =  [string substringFromIndex:5];//截取掉下标2之前的字符串
            NSLog(@"截取的值为：%@",str1);
            str2 = [string substringToIndex:4];
            NSLog(@"%@",str2);
            cell.weakLabel.text = str2;
            [cell.weakLabel sizeToFit];
            cell.timeLabel.text = str1;
            [cell.timeLabel sizeToFit];

            
            
//            cell.timeLabel.text = @" ";
//            [cell.timeLabel sizeToFit];
//            cell.picelabel.text = [NSString stringWithFormat:@"%@",model.payMoney];
//            [cell.picelabel sizeToFit];
        
        }
    }else{
        
//        if (model.payAccount != nil) {
//            cell.weakLabel.text = model.payAccount;
//            [cell sizeToFit];
//        }else{
        if (self.tag.integerValue == 6) {
            NSString*string =model.endDate;
            string = [string substringToIndex:10];//截取掉下标7之后的字符串
            NSLog(@"截取的值为：%@",string);
            NSString *str1,*str2;
            str1 =  [string substringFromIndex:5];//截取掉下标2之前的字符串
            NSLog(@"截取的值为：%@",str1);
            str2 = [string substringToIndex:4];
            NSLog(@"%@",str2);
            cell.weakLabel.text = str2;
            [cell.weakLabel sizeToFit];
            cell.timeLabel.text = str1;
            [cell.timeLabel sizeToFit];
            cell.picelabel.text = [NSString stringWithFormat:@"%@",model.totalMoney];
            
            cell.xqName.text = [NSString stringWithFormat:@"小区:%@",model.xqname];
            if (model.prompt.length != 0) {
                cell.cjText.text = [NSString stringWithFormat:@"缴费提示信息:%@",model.prompt];
                
            }
            if (model.promptTime.length != 0) {
                cell.cjTime.text = [NSString stringWithFormat:@"缴费提示时间:%@",model.promptTime];
            }
        }else{
        
        NSString*string =model.endTime;
        string = [string substringToIndex:10];//截取掉下标7之后的字符串
        NSLog(@"截取的值为：%@",string);
        NSString *str1,*str2;
        str1 =  [string substringFromIndex:5];//截取掉下标2之前的字符串
        NSLog(@"截取的值为：%@",str1);
        str2 = [string substringToIndex:4];
        NSLog(@"%@",str2);
        cell.weakLabel.text = str2;
        [cell.weakLabel sizeToFit];
        cell.timeLabel.text = str1;
        [cell.timeLabel sizeToFit];
        cell.picelabel.text = model.totalMoney;
        }

    }
//    [cell.imageview setImage:[UIImage imageNamed:@"jiaodianfei.png"]];
    
    if (self.tag.integerValue == 1) {
        [cell.imageview setImage:[UIImage imageNamed:@"jiaoshuifei.png"]];

        if ([model.payStatus isEqualToString:@"已交"]) {
            cell.oderLabel.text = [NSString stringWithFormat:@"水费缴费手机号:%@",model.payerPhone];
        }else{
            cell.oderLabel.text = [NSString stringWithFormat:@"水费-缴费号%@",model.preid];
        }
    }else if (self.tag.integerValue == 2){
        [cell.imageview setImage:[UIImage imageNamed:@"jiaodianfei.png"]];

        if ([model.payStatus isEqualToString:@"已交"]) {
            cell.oderLabel.text = [NSString stringWithFormat:@"电费缴费手机号:%@",model.payerPhone];
        }else{
            cell.oderLabel.text = [NSString stringWithFormat:@"电费-缴费号%@",model.preid];
        }
    }else if (self.tag.integerValue == 3){
        [cell.imageview setImage:[UIImage imageNamed:@"jiaoranqifei.png"]];

        if ([model.payStatus isEqualToString:@"已交"]) {
            cell.oderLabel.text = [NSString stringWithFormat:@"燃气费缴费手机号:%@",model.payerPhone];
        }else{
            cell.oderLabel.text = [NSString stringWithFormat:@"燃气费-缴费号%@",model.preid];
        }
    }else if (self.tag.integerValue == 5){
        [cell.imageview setImage:[UIImage imageNamed:@"jiaowuyefei.png"]];
        if (model.wyfId == nil) {
            cell.oderLabel.text = [NSString stringWithFormat:@"物业费缴费手机号:%@",model.phone];
        }else{
            cell.oderLabel.text = [NSString stringWithFormat:@"物业费-缴费号%@",model.wyfId];
        }
    }else if (self.tag.integerValue == 4){
        [cell.imageview setImage:[UIImage imageNamed:@"jiaoqunuanfei.jpg"]];
        if (model.payStatus.integerValue == 1) {
            cell.oderLabel.text = [NSString stringWithFormat:@"取暖费缴费手机号:%@",model.phone];
        }else{
            cell.oderLabel.text = [NSString stringWithFormat:@"取暖费-缴费号%@",model.qnfId];
        }
    }else if (self.tag.integerValue == 6){
        [cell.imageview setImage:[UIImage imageNamed:@"jiaoqunuanfei.jpg"]];
        if (model.payStatus.integerValue == 1) {
            cell.oderLabel.text = [NSString stringWithFormat:@"车位管理费手机号:%@",model.phone];
        }else{
            cell.oderLabel.text = [NSString stringWithFormat:@"车位管理费-缴费号%@",model.ThirdPaymentID];
        }
        
        
    }
//    cell.oderLabel.text = [NSString stringWithFormat:@"电费-缴费号%@",model.preid];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ProertyPayModel *model = self.dataArr[indexPath.row];
    NSLog(@"%@",model.wyid);
    AFNetworkTwoPackaging *twoPacking = [[AFNetworkTwoPackaging alloc] init];
    [twoPacking getUrl:[NSString stringWithFormat:WXALIPAY,model.wyid] andFinishBlock:^(id getResult) {
        NSLog(@"%@",getResult);
        ProertyPayDetialViewController *detial = [[ProertyPayDetialViewController alloc] init];
        detial.model = model;
        detial.tag = self.tag;
        detial.wxTag = getResult[@"weixin"];
        detial.zfbTag = getResult[@"zhifubao"];
        [self.navigationController pushViewController:detial animated:YES];
    }];
//    if ([self.target isKindOfClass:[ProertyPayViewController class]]) {

//    }else{
//        
//        
//    }

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
