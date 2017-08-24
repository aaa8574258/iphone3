//
//  CWHOrderDetialViewController.m
//  360du
//
//  Created by 利美 on 16/9/23.
//  Copyright © 2016年 wangjian. All rights reserved.
//

#import "CWHOrderDetialViewController.h"
#import "CWHDetialModel.h"
#import "OrderDeatilViewController.h"
#import "CWHOrderDetialViewController.h"
#import "OrderListModel.h"
#import "WeChantViewViewController.h"
#import "LogisticsViewController.h"
#import "UIView+Toast.h"

@interface CWHOrderDetialViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong) UITableView *tableView;

@property (nonatomic ,copy) NSString *payName;
@property (nonatomic ,copy) NSString *payNumber;
@property (nonatomic ,copy) NSString *ccpo;
@property (nonatomic ,strong) NSMutableArray *sectionData;
@property (nonatomic ,strong) NSMutableArray *rowData;
@property (nonatomic ,copy) NSString *cpid,*cppicture;


@end

@implementation CWHOrderDetialViewController

- (instancetype)initWithOrderId:(NSString *)orderId
{
    self = [super init];
    if (self) {
        self.orderId = orderId;
//        self.view.backgroundColor = [UIColor redColor];
        [self forData];
        [self makeUI];
    }
    return self;
}

-(void) makeUI{
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame];
   self.automaticallyAdjustsScrollViewInsets = YES;

    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;


}


-(void)forData{
    AFNetworkTwoPackaging *twoPacking = [[AFNetworkTwoPackaging alloc] init];
    [twoPacking getUrl:[NSString stringWithFormat:GETORDERDETAILSBAYORDERID,self.orderId] andFinishBlock:^(id getResult) {
        NSLog(@"%@",getResult);
        self.sectionData = [NSMutableArray arrayWithCapacity:0];
        self.rowData = [NSMutableArray arrayWithCapacity:0];
        NSDictionary *dic = getResult[@"datas"];
        CWHDetialModel *model = [[CWHDetialModel alloc] initWithDictionary:dic];
        [self.sectionData addObject:model];
        
        for (NSDictionary *dic1 in dic[@"itemArray"]) {
            CWHDetialModel *model1 = [[CWHDetialModel alloc] initWithDictionary:dic1];
            [self.rowData addObject:model1];
        }
        NSLog(@"%@------%@",self.sectionData,self.rowData);
        [self.tableView reloadData];
    }];
    
}




-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
        return 5;
    }

}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 100;
    }else{
        if (indexPath.row == 0) {
            return 50;
        }else if (indexPath.row == 1){
            return self.rowData.count *144;
        }else if (indexPath.row == 2){
            return 50;
        }else if (indexPath.row == 3){
            return 50;
        }else{
            return 100;
        }
    }
}


-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"asdasd"];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"asdasd"];
    CWHDetialModel *model = self.sectionData[0];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0) {
        
        UILabel *labName = [[UILabel alloc] initWithFrame:CGRectMake(20, 8, WIDTH_CONTENTVIEW - 40 / 2 , 30)];
        labName.numberOfLines = 0;
        labName.text = model.Name;
        [cell.contentView addSubview:labName];
        UILabel *labName1 = [[UILabel alloc] initWithFrame:CGRectMake(128, 8, WIDTH_CONTENTVIEW - 40 / 2 , 30)];
        labName1.numberOfLines = 0;
        labName1.text = model.phone;
        [cell.contentView addSubview:labName1];
        UILabel *labName2 = [[UILabel alloc] initWithFrame:CGRectMake(20, 38, WIDTH_CONTENTVIEW - 40, 60)];
        //        labName2.backgroundColor = [UIColor redColor];
        labName2.numberOfLines = 0;
        labName2.text = model.address;
        [cell.contentView addSubview:labName2];
    }else{
        if (indexPath.row == 0) {
            //            NSLog(@"%@", model.shopName);
            UILabel *label  = [[UILabel alloc] initWithFrame:cell.contentView.frame];
            label.backgroundColor = [UIColor whiteColor];
            label.text = model.shopName;
            [cell.contentView addSubview:label];
            
            UILabel *label1  = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH_CONTENTVIEW- 180, 8, 120, 30)];
            label1.text = model.payStatusName;
            label1.textColor = [UIColor redColor];
            label1.textAlignment = UITextAlignmentRight;
            [cell.contentView addSubview:label1];
            
        }else if (indexPath.row == 1){
            for (NSInteger i = 0; i < self.rowData.count; i++) {
                CWHDetialModel *model = _rowData[i];
                
                UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 117*i, WIDTH_CONTENTVIEW, 116)];
                [self makeProViewWithimageURL:model.proPic andProName:model.proName andRule:@"" andPrice:[NSString stringWithFormat:@"%f",model.proPrice.floatValue] andNumber:model.proCount inView:view];
                [cell.contentView addSubview:view];
            }
        
        
        }else if (indexPath.row == 2){
            UILabel *label1  = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH_CONTENTVIEW- 180, 8, 120, 30)];
            label1.text = [NSString stringWithFormat:@"总计: %@",model.price];
            label1.textColor = [UIColor redColor];
            label1.textAlignment = UITextAlignmentRight;
            [cell.contentView addSubview:label1];
        
        }else if (indexPath.row == 3){
//            OrderListModel *model = self.sectionArr[indexPath.section];
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(WIDTH_CONTENTVIEW - 210, 0, 100, 48);
            [button addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
            //        button.backgroundColor = [UIColor redColor];
            [cell.contentView addSubview:button];
            
            
            UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
            button2.frame = CGRectMake(WIDTH_CONTENTVIEW - 120, 0, 100, 48);
            [button2 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
            
            //        button2.backgroundColor = [UIColor redColor];
            NSLog(@"%@",model.shopType);
            if (model.shopType.integerValue == 2) {
////                [button removeFromSuperview];
//                
            }else{
                if ([model.status isEqualToString:@"1"] || [model.status isEqualToString:@"2"] || [model.status isEqualToString:@"3"] || [model.status isEqualToString:@"4"]) {
                    button.backgroundColor = [UIColor redColor];
                    button.tag = 151884;
                    [button setTitle:@"查看物流" forState:UIControlStateNormal];
                }
                
            }
            NSLog(@"%@--%@",model.payStatus,model.status);
            button2.tag = 151885;
            
            if ([model.payStatus isEqualToString:@"0"]) {
                if ([model.status isEqualToString:@"5"] || [model.status isEqualToString:@"16"]) {
                    
                }else{
                    button2.backgroundColor = [UIColor redColor];
                    [button2 setTitle:@"付款" forState:UIControlStateNormal];
                }
            }else{
                if ([model.status isEqualToString:@"1"] || [model.status isEqualToString:@"2"] || [model.status isEqualToString:@"3"] ) {
                    
                    if (model.shopType.integerValue == 2) {
                        button2.backgroundColor = [UIColor redColor];
                        
                        [button2 setTitle:@"确认收货" forState:UIControlStateNormal];
                        
                    }
                    
                    
                }else{
                    [cell.contentView removeFromSuperview];
                }
                
            }
            [cell.contentView addSubview:button2];
        
        }else if (indexPath.row == 4){
            UILabel *labName1 = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, WIDTH_CONTENTVIEW - 40 / 2 , 30)];
            labName1.numberOfLines = 0;
            labName1.text = [NSString stringWithFormat:@"订单编号: %@",model.orderId];
            [cell.contentView addSubview:labName1];
            UILabel *labName2 = [[UILabel alloc] initWithFrame:CGRectMake(20, 36, WIDTH_CONTENTVIEW - 40 / 2 , 30)];
            labName2.numberOfLines = 0;
            labName2.text = [NSString stringWithFormat:@"下单时间: %@",model.orderTime];

            [cell.contentView addSubview:labName2];
//            UILabel *labName3 = [[UILabel alloc] initWithFrame:CGRectMake(20, 8, WIDTH_CONTENTVIEW - 40 / 2 , 30)];
//            labName3.numberOfLines = 0;
//            labName3.text = model.Name;
//            [cell.contentView addSubview:labName3];
        
        }
    
    
    
    
    
    
    
    }
    
//    cell.backgroundColor = [UIColor redColor];
    return cell;
}

-(void) makeProViewWithimageURL:(NSString *) imageurl andProName:(NSString *) proName andRule:(NSString *) rule andPrice :(NSString *)price andNumber:(NSString *)number inView:(UIView *)view1{
    //    UIView *view1 = [[UIView alloc] initWithFrame:CGRectZero];
    view1.backgroundColor = [UIColor colorWithRed:209/255.0 green:209/255.0 blue:214/255.0 alpha:1];
    UIImageView *proImage = [[UIImageView alloc] initWithFrame:CGRectMake(8, 8, 100, 100)];
    [proImage sd_setImageWithURL:[NSURL URLWithString:imageurl]];
    [view1 addSubview:proImage];
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(116, 8, WIDTH_CONTENTVIEW - 116 , 30)];
    lab.text = proName;
    //    lab.backgroundColor = [UIColor blueColor];
    lab.numberOfLines = 0;
    [view1 addSubview:lab];
    UILabel *lab1 = [[UILabel alloc] initWithFrame:CGRectMake(116, 50, WIDTH_CONTENTVIEW - 116 , 30)];
    lab1.text = rule;
    //    lab1.backgroundColor = [UIColor blueColor];
    lab1.numberOfLines = 0;
    [view1 addSubview:lab1];
    UILabel *lab2 = [[UILabel alloc] initWithFrame:CGRectMake(116, 78, 100 , 30)];
    lab2.text = [NSString stringWithFormat:@"¥%0.2f",price.floatValue];
    lab2.numberOfLines = 0;
    [view1 addSubview:lab2];
    UILabel *lab3 = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH_CONTENTVIEW - 46, 78,60, 30)];
    lab3.text = [NSString stringWithFormat:@"x%@",number];
    //    lab3.backgroundColor = [UIColor redColor];
    lab3.textColor = [UIColor redColor];
    lab3.numberOfLines = 0;
    [view1 addSubview:lab3];
    
    //    return view1;
}


-(void) btnAction:(UIButton *)center{
    
    
    CWHDetialModel *model = self.sectionData[0];

//    OrderListModel *model = self.sectionArr[self.tableIndexPath.section -1];
    
    NSLog(@"%@",model.price);
    self.payNumber = model.price;
    self.ccpo = model.orderId;
    self.payName = model.shopName;
    if (center.tag == 151884) {
        if ([center.titleLabel.text isEqualToString:@"查看物流"]) {
            LogisticsViewController *cleanerViewController = [[UIStoryboard storyboardWithName:@"MineGroupStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"logistics"];
            cleanerViewController.cpid = self.ccpo;
            cleanerViewController.imageUrl = self.cppicture;
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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
