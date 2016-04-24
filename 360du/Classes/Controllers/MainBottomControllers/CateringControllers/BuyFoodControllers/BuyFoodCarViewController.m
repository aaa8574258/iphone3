//
//  BuyFoodCarViewController.m
//  360du
//
//  Created by linghang on 15/7/6.
//  Copyright (c) 2015年 wangjian. All rights reserved.
//

#import "BuyFoodCarViewController.h"
#import "BuyFoodCarCell.h"
#import "FileOperation.h"
#import "CommitOrderViewController.h"
#import "FoodMerchatListModel.h"
#import "RemarkSendFoodViewController.h"
#import "AFNetworkTwoPackaging.h"
#import "StoreageMessage.h"
#import "NSString+URLEncoding.h"
#import "PaymentPrevilage.h"
#import "AddressModel.h"
#import "UIView+Toast.h"
#import "DebitCompanyOrPersonalViewController.h"
#import "AlipayViewController.h"
#import "GiveFoodTimeListModel.h"
#import "TranlateTime.h"
#import "MerchantDiscountViewController.h"
#import "GoodsPrivilegeViewController.h"
#import "WeChantViewViewController.h"
#define BUYFOOFCARCELL @"buyFoodCarCell"
@interface BuyFoodCarViewController ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate>
@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,weak)UITableView *tableView;
@property(nonatomic,copy)NSString *privelage;
@property(nonatomic,copy)NSString *moneyTotalCount;
//@property(nonatomic,copy)NSString *
@property(nonatomic,strong)NSArray *shopArr;//购买商品的
@property(nonatomic,strong)NSArray *addressArr;//地址arr
@property(nonatomic,weak)UIDatePicker *datePick;
@property(nonatomic,strong)NSArray *rlidArr;//可选规格里边的

@property(nonatomic,strong)NSMutableArray *typeSliderArr;//看看第几个需要描述,存了第几个和描述过程
@property(nonatomic,strong)NSMutableArray *previlageArr;//优惠数组
@property(nonatomic,copy)NSString *merchantId;
@property(nonatomic,copy)NSString *sendPrice;//起送价
@property(nonatomic,copy)NSString *distrutionPrice;//配送价
@property(nonatomic,strong)NSMutableArray *addressListArr;//地址数组

@property(nonatomic,assign)NSInteger payType;//选择付款方式
@property(nonatomic,weak)UILabel *previlageLab;//优惠LAb
@property(nonatomic,weak)UILabel *priceLab;//价格
@property(nonatomic,assign)CGFloat totalPrice;//总价格
@property(nonatomic,copy)NSString *remarkLabText;//备注
@property(nonatomic,strong)UIButton *payPreBtn;//付款前一个btn
@property(nonatomic,assign)BOOL switchDebit;//是否需要发票
@property(nonatomic,copy)NSString *debiteDetail;//填写发票的内容
@property(nonatomic,weak)UILabel *remarkLab;//备注
@property(nonatomic,weak)UILabel *debitLab;//发票
@property(nonatomic,assign)CGFloat finalPrice;//最后价格
@property(nonatomic,strong)NSMutableArray *timeListArr;//送餐时间表
@property(nonatomic,copy)NSString *giveFoodTimeStr;//送餐时间
@property(nonatomic,weak)UILabel *discountLab;//优惠券
@property(nonatomic,copy)NSString *discount;//优惠
@property(nonatomic,copy)NSString *privelegeMoney;//优惠钱数
@end

@implementation BuyFoodCarViewController
-(id)initWithArr:(NSArray *)array andPrice:(CGFloat)price andFoodTypeArr:(NSArray *)typeArr andMerchantId:(NSString *)merchantId andSendPrice:(NSString *)sendPrice andDistrutionPrice:(NSString *)distrutionPrice{
    self = [super init];
    if (self) {
        self.switchDebit = NO;
        self.remarkLabText = @"无";
        self.debiteDetail = @"不需要发票";
        self.discount = @"无";
        self.sendPrice = sendPrice;
        self.distrutionPrice = distrutionPrice;
        self.privelegeMoney = @"0";
        self.payType = -1;
        self.moneyTotalCount = [NSString stringWithFormat:@"总计￥%0.2f元",price + distrutionPrice.integerValue];
        self.finalPrice = price + distrutionPrice.integerValue;
        self.totalPrice = price + distrutionPrice.floatValue;
        self.shopArr = array;
        self.rlidArr = typeArr;
        self.merchantId = merchantId;
        self.giveFoodTimeStr = @"立即送餐";
        [self makeInit];
        [self loadPaymentPre];
        [self loadData];
        [self loadTimeList];
        [self makeNav];
       // [self makePickDate];
        //[self loadAddress];

    }
    return self;
}
-(void)makeInit{
    self.dataArr = [NSMutableArray arrayWithCapacity:0];
    self.typeSliderArr = [NSMutableArray arrayWithCapacity:0];
    self.previlageArr = [NSMutableArray arrayWithCapacity:0];
    self.addressListArr = [NSMutableArray arrayWithArray:0];
    self.timeListArr = [NSMutableArray arrayWithCapacity:0];
}
- (void)viewWillAppear:(BOOL)animated{
}
//加载优惠方式
- (void)loadPaymentPre{
    NSLog(@"merchantId:%@",[NSString stringWithFormat:PAYMENTPRELIVIAGE,[StoreageMessage getMessage][2],self.merchantId]);
    [self makeHUd];
    AFNetworkTwoPackaging *twoPack = [[AFNetworkTwoPackaging alloc] init];
    [twoPack getUrl:[NSString stringWithFormat:PAYMENTPRELIVIAGE,[StoreageMessage getMessage][2],self.merchantId] andFinishBlock:^(id getResult) {
        [self hudWasHidden:self.hudProgress];
        NSMutableArray *tempArr = [NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *dict in getResult) {
            PaymentPrevilage *model = [[PaymentPrevilage alloc] initWithDictionary:dict];
            [self.previlageArr addObject:model];
            [tempArr addObject:model.Payname];
        }
        [self.dataArr replaceObjectAtIndex:1 withObject:tempArr];
        [self makeUI];
        [self loadAddress];
    }];
}

-(void)makeNav{
    [self setNavBarImage:@"landi.png"];
    //[self setBackgroud:@"lantiao x.png"];
    [self setBackImageStateName:@"fanhuijian02.png" AndHighlightedName:@""];
    
    
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    //view.backgroundColor = MAINVIEWNAVBARCOLOR;
    //[self.view addSubview:view];
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectZero];
    lable.text = @"提交订单";
    lable.font = [UIFont systemFontOfSize:16 * self.numSingleVesion];
    lable.textColor = [UIColor whiteColor];
    [lable sizeToFit];
    lable.frame = CGRectMake(5 * self.numSingleVesion, 0 + (44 - 15) / 2, lable.frame.size.width, 15);
    [view addSubview:lable];
    view.frame = CGRectMake(0, 0, lable.frame.size.width, 44);
    //UIBarButtonItem *centerBar = [[UIBarButtonItem alloc] initWithCustomView:view];
    self.navigationItem.titleView = view;
}
-(void)loadData{
    
    [self.dataArr addObject:@[@"新增地址"]];
    [self.dataArr addObject:@[@"货到付款",@"微信支付",@"支付宝支付"]];
    [self.dataArr addObject:@[@"配送时间",@"配送备注",@"需要发票"]];
    [self.dataArr addObject:@[@"代金券"]];
    //[self.rlidArr addObject:@{@"rlid":rlid,@"count":[NSString stringWithFormat:@"%ld",count],@"descName":foodName,@"ItemModel":model}];
    [self.dataArr addObject:self.shopArr];
    
    
}
- (void)loadAddress{
//#define ADDRESSLIST MAININTERFACE@"serviceServlet?serviceName=MyAccountXmlGenerator&medthodName=addressJson&MemberID=%@&gotoPage=%ld&pageSize=%ld"

    AFNetworkTwoPackaging *twoPacking = [[AFNetworkTwoPackaging alloc] init];
    [twoPacking getUrl:[NSString stringWithFormat:ADDRESSLIST,[StoreageMessage getMessage][2],(long)1,(long)5] andFinishBlock:^(id getResult) {
        if ([getResult[@"code"] isEqualToString:@"000001"]) {
            return ;
        }else{
            for (NSInteger i = 0;i < [getResult[@"datas"] count];i++) {
                AddressModel *model = [[AddressModel alloc] initWithDictionary:getResult[@"datas"][i]];
                if ([model.isDefault isEqual:@"Y"]) {
                    [self.dataArr replaceObjectAtIndex:0 withObject:@[model]];
                }
                [self.addressListArr addObject:model];
            }
            [self.tableView reloadData];
        }

    }];
}
//加载时间表
- (void)loadTimeList{
    AFNetworkTwoPackaging *twoPack = [[AFNetworkTwoPackaging alloc] init];
    [twoPack getUrl:[NSString stringWithFormat:GIVEFOODTIMELIST,self.merchantId] andFinishBlock:^(id getResult) {
        [self hudWasHidden:self.hudProgress];
        for (NSInteger i = 0; i < [getResult count]; i++) {
            GiveFoodTimeListModel *model = [[GiveFoodTimeListModel alloc] initWithDictionary:getResult[i]];
            [self.timeListArr addObject:model];
        }
    }];
}
-(void)makeUI{
    [self makeTable];
    [self makeBottom];
}
-(void)makeTable{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, WIDTH_CONTROLLER, HEIGHT_CONTROLLER - 64 - 49 * self.numSingleVesion) style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    //[tableView registerClass:[BuyFoodCarCell class] forCellReuseIdentifier:BUYFOOFCARCELL];
    tableView.showsVerticalScrollIndicator = NO;
   // tableView.separatorStyle = NO;
    self.tableView = tableView;
}
-(void)makeBottom{
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, HEIGHT_CONTROLLER - 49 * self.numSingleVesion, WIDTH_CONTROLLER / 4 * 3, 49 * self.numSingleVesion)];
    leftView.backgroundColor = SMSColor(55, 50, 51);;
    [self.view addSubview:leftView];
    
    //优惠
    UILabel *preivielL = [[UILabel alloc] initWithFrame:CGRectMake(5 * self.numSingleVesion, (49 - 15) / 2 * self.numSingleVesion, 60 * self.numSingleVesion, 15 * self.numSingleVesion)];
    preivielL.textColor = [UIColor redColor];
    [leftView addSubview:preivielL];
    preivielL.text = @"以优惠0元";
    preivielL.font = [UIFont systemFontOfSize:12];
    [preivielL sizeToFit];
    preivielL.center = CGPointMake(5 * self.numSingleVesion + preivielL.frame.size.width / 2, 49 / 2 * self.numSingleVesion);
    self.previlageLab = preivielL;
    //价格
    UILabel *priceLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 15 * self.numSingleVesion)];
    priceLab.text = self.moneyTotalCount;
    [leftView addSubview:priceLab];
    priceLab.font = [UIFont systemFontOfSize:15];
    priceLab.textColor = [UIColor redColor];
    [priceLab sizeToFit];
    priceLab.center = CGPointMake(WIDTH_CONTROLLER / 4 * 3 - 5 * self.numSingleVesion - priceLab.frame.size.width, 24.5 * self.numSingleVesion);
    self.priceLab = priceLab;
    //右边确认下单
//    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(WIDTH_CONTROLLER / 4 * 3, HEIGHT_CONTROLLER - 49 * self.numSingleVesion, WIDTH_CONTROLLER / 2, 49 * self.numSingleVesion)];
//    rightView.backgroundColor = [UIColor redColor];
//    [self.view addSubview:rightView];
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(WIDTH_CONTROLLER / 4 * 3, HEIGHT_CONTROLLER - 49 * self.numSingleVesion, WIDTH_CONTROLLER / 4, 49 * self.numSingleVesion);
    rightBtn.backgroundColor = [UIColor redColor];
    [rightBtn setTitle:@"确认下单" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rightBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [rightBtn addTarget:self action:@selector(rightBtnDown:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rightBtn];
}
//确认下单
-(void)rightBtnDown:(UIButton *)rightBtn{
    if (!self.payPreBtn) {
        [self.view makeToast:@"请选择付款方式"];
        return;
    }
    PaymentPrevilage *preModel =  self.previlageArr[self.payPreBtn.tag - 1610];
        [self makeHUd];
    
   AFHTTPRequestOperationManager *_rom = [AFHTTPRequestOperationManager manager];
    _rom.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/json",@"text/html",@"application/json",nil];
    _rom.requestSerializer = [[AFHTTPRequestSerializer alloc] init];
    _rom.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    //NSString *url = [NSString stringWithFormat:STUDY_CATEGORY_ITEM,self.categoryId,22];
    NSString *temost = @"京瑞大厦";
    
//#define CONFIRMORDER MAININTERFACE@"serviceServlet?serviceName=UGoshoppingcar&medthodName=userorder&memberID=%@&did=%@&SendEndDate=%@&addressID=%@&PaymentType=%@&faPiao=%@&remark=%@"
    AddressModel *model = self.dataArr[0][0];
    NSString *remark = self.remarkLabText;
    NSString *debit = self.debiteDetail;
    if (self.remarkLabText.length == 0 || [self.remarkLabText isEqual:@"无"]
) {
        remark = @"";
    }
    if (self.debiteDetail.length == 0 || [self.debiteDetail isEqual:@"不需要发票"]){
        debit = @"";
    }
    NSString *goodTimeStr = self.giveFoodTimeStr;

    if ([self.giveFoodTimeStr isEqual:@"立即送餐"]) {
        goodTimeStr = [TranlateTime returnHourAndMinuate];
    }
    NSString *url = [NSString stringWithFormat:CONFIRMORDER,[StoreageMessage getMessage][2],self.merchantId,goodTimeStr,model.ID,preModel.Payid,[[debit urlEncodeString] urlEncodeString],[[remark urlEncodeString] urlEncodeString]];
    [_rom GET: url parameters:nil  success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self hudWasHidden:self.hudProgress];

        NSString *tempStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSData *data = [tempStr dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        if ([dict[@"code"] isEqual:@"000000"]) {
            [self.view makeToast:@"下单成功!"];
            if ([preModel.Payname isEqual:@"微信支付"]) {
                [WeChantViewViewController payName:self.shopName andMoney:[NSString stringWithFormat:@"%0.2f",self.finalPrice * 100 ]];
//                [self.view makeToast:@"暂时不支持微信支付，请选择另一种支付方式"];
//                return;
            }else{

                if ([preModel.Payid isEqual:@"3"]) {
                    [self.navigationController popToRootViewControllerAnimated:YES];
                    return ;
                }
                AlipayViewController *aliPay = [[AlipayViewController alloc] initPrice:[NSString stringWithFormat:@"%0.2f",self.finalPrice] andDescMerchant:self.shopDesc andTitle:self.shopName andMerOrder:dict[@"orderID"]];
                [self.navigationController pushViewController:aliPay animated:YES];
            }
        }else{
            [self.view makeToast:@"由于网络原因,下单失败,请重新下单!"];
            return ;
        }
       
        
        
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //[[NSURLCache sharedURLCache] removeAllCachedResponses];
                [self hudWasHidden:self.hudProgress];
        NSLog(@"%@",[error description]);
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"警告" message:@"网络不流畅，请换个网络试试" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
        [alertView show];
        return ;
    }];

//    AFNetworkTwoPackaging *twoPack = [[AFNetworkTwoPackaging alloc] init];
//    //"serviceServlet?serviceName=UGoshoppingcar&medthodName=userorder&memberID=%@&did=%@&SendEndDate=%@&addressID=%@&PaymentType=%@"
//    //3.货到付款，1，支付宝，2，微信支付
//    [twoPack getUrl:[NSString stringWithFormat:CONFIRMORDER,[StoreageMessage getMessage][2],self.merchantId,@"15:30",@"京瑞大厦",@"3"] andFinishBlock:^(id getResult) {
//        NSLog(@"getResult:%@",[NSString stringWithFormat:CONFIRMORDER,[StoreageMessage getMessage][2],self.merchantId,@"15:30",@"京瑞大厦",@"3"]);
//        NSLog(@"result:%@",getResult);
//    }];
    //CommitOrderViewController *commitOrder = [[CommitOrderViewController alloc] initWithAddressArr:self.addressArr];
    //[self.navigationController pushViewController:commitOrder animated:YES];
    
}
#pragma mark tableView的协议代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataArr[section] count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BuyFoodCarCell *cell = [tableView dequeueReusableCellWithIdentifier:BUYFOOFCARCELL];
    if (!cell) {
        cell = [[BuyFoodCarCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:BUYFOOFCARCELL];
        if (indexPath.section == 2 && indexPath.row == 1) {
            UILabel *remarkLab = [[UILabel alloc] initWithFrame:CGRectZero];
            remarkLab.font = [UIFont systemFontOfSize:13];
            
            remarkLab.textColor = [UIColor lightGrayColor];
            [cell.contentView addSubview:remarkLab];
            remarkLab.tag = 3100;
            self.remarkLab = remarkLab;
        }else if (indexPath.section == 2 && indexPath.row == 2){
            UILabel *debitLab = [[UILabel alloc] initWithFrame:CGRectZero];
            debitLab.font = [UIFont systemFontOfSize:13];
            debitLab.textColor = [UIColor lightGrayColor];
            [cell.contentView addSubview:debitLab];
            debitLab.tag = 3150;
            self.debitLab = debitLab;
        }else if (indexPath.section == 2 && indexPath.row == 0){
            UILabel *sendFoodLab = [[UILabel alloc] initWithFrame:CGRectZero];
            //sendFoodLab.text = @"今日 立即送餐";
            sendFoodLab.font = [UIFont systemFontOfSize:13];
            //[sendFoodLab sizeToFit];
            sendFoodLab.tag = 3120;
            sendFoodLab.textColor = [UIColor lightGrayColor];
            [cell.contentView addSubview:sendFoodLab];
        }else if (indexPath.section == 3 && indexPath.row == 0){
            UILabel *debitLab = [[UILabel alloc] initWithFrame:CGRectZero];
            debitLab.font = [UIFont systemFontOfSize:13];
            debitLab.textColor = [UIColor lightGrayColor];
            [cell.contentView addSubview:debitLab];
            debitLab.tag = 3180;
            self.discountLab = debitLab;
        }
    }
   // [cell initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:BUYFOOFCARCELL];

   // [cell.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    //[cell init];
    if (indexPath.section == 1) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (indexPath.row == 0 && indexPath.section == 0) {

    }else{
    }

    if (indexPath.section == 0 && indexPath.row == 0) {
        if ([self.dataArr[indexPath.section][indexPath.row] isEqual:@"新增地址"]) {
            cell.textLabel.text = self.dataArr[indexPath.section][indexPath.row];
        }else{
            AddressModel *model = self.dataArr[indexPath.section][indexPath.row];
            cell.textLabel.text = [NSString stringWithFormat:@"%@ %@ %@",model.name,model.sex,model.phone];
            cell.detailTextLabel.text = [NSString stringWithFormat:@"地址:%@",model.address];
            cell.detailTextLabel.textColor = [UIColor blackColor];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:13];
        }
        cell.textLabel.textColor = [UIColor blackColor];

        
    }else if(indexPath.section != 0 && indexPath.section != 4 ){
        cell.textLabel.text = self.dataArr[indexPath.section][indexPath.row];
//        if(indexPath.section != 2 && indexPath.row != 2){
//            cell.textLabel.text = self.dataArr[indexPath.section][indexPath.row];
//        }
        
    }else{
        NSDictionary *tempDic = self.dataArr[indexPath.section][indexPath.row];
        if (indexPath.section == 4 && indexPath.row == [self.dataArr[indexPath.section] count] - 1 && self.distrutionPrice.integerValue != 0) {
            cell.textLabel.text = tempDic[@"name"];
            cell.textLabel.font = [UIFont systemFontOfSize:15];
            UILabel *priceLab = [[UILabel alloc] initWithFrame:CGRectZero];
            //priceLab.text = itemModel.price;
            
            priceLab.text = [NSString stringWithFormat:@"￥%@",self.distrutionPrice];
            priceLab.font = [UIFont systemFontOfSize:13];
            priceLab.textColor = [UIColor lightGrayColor];
            [cell.contentView addSubview:priceLab];
            [priceLab sizeToFit];
            priceLab.center = CGPointMake(WIDTH_CONTROLLER - 5 * self.numSingleVesion - priceLab.frame.size.width / 2, cell.frame.size.height / 2);
            return cell;
        }
        FoodMerchatListItemModel *itemModel = tempDic[@"ItemModel"];
        cell.textLabel.text = itemModel.name;
        //价格
        
        UILabel *priceLab = [[UILabel alloc] initWithFrame:CGRectZero];
        //priceLab.text = itemModel.price;

       priceLab.text = [NSString stringWithFormat:@"￥%ld",itemModel.price.integerValue];
        priceLab.font = [UIFont systemFontOfSize:13];
        priceLab.textColor = [UIColor lightGrayColor];
        [cell.contentView addSubview:priceLab];
        [priceLab sizeToFit];
        priceLab.center = CGPointMake(WIDTH_CONTROLLER - 5 * self.numSingleVesion - priceLab.frame.size.width / 2, cell.frame.size.height / 2);
        //数量
        UILabel *countLab = [[UILabel alloc] initWithFrame:CGRectZero];
        countLab.textColor = [UIColor lightGrayColor];
        countLab.text = [NSString stringWithFormat:@"x %@",tempDic[@"count"]];
        [cell.contentView addSubview:countLab];
        countLab.font = [UIFont systemFontOfSize:13];
        [countLab sizeToFit];
        countLab.center = CGPointMake(WIDTH_CONTROLLER - 20 * self.numSingleVesion - priceLab.frame.size.width - 15 * self.numSingleVesion, cell.frame.size.height / 2);
        //[self.rlidArr addObject:@{@"rlid":rlid,@"count":[NSString stringWithFormat:@"%ld",count],@"descName":foodName,@"ItemModel":model}];
        if ([tempDic[@"descName"] length] != 0) {
            UILabel *styleLab = [[UILabel alloc] initWithFrame:CGRectZero];
            styleLab.textColor = [UIColor lightGrayColor];
            styleLab.text = [tempDic objectForKey:@"descName"];
            [cell.contentView addSubview:styleLab];
            styleLab.font = [UIFont systemFontOfSize:13];
            [styleLab sizeToFit];
            styleLab.center = CGPointMake(WIDTH_CONTROLLER / 2, cell.frame.size.height / 2);
        }
        
    }
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    if (indexPath.section == 1) {
//        for (NSInteger i = 0; i < 3; i++) {
//            UIButton *payBtn = (UIButton *)[cell.contentView viewWithTag:1610 + i];
//            [payBtn setImage:[UIImage imageNamed:@"圆"] forState:UIControlStateNormal];
//        }
        UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        rightBtn.frame = CGRectMake(WIDTH_CONTROLLER - 40 * self.numSingleVesion, 5 * self.numSingleVesion, 25 * self.numSingleVesion, 25 * self.numSingleVesion);
        [rightBtn addTarget:self action:@selector(payment:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:rightBtn];
        rightBtn.tag = 1600 + indexPath.section * 10 + indexPath.row ;
        [rightBtn setImage:[UIImage imageNamed:@"圆"] forState:UIControlStateNormal];

        //self.foodCarCell = cell;
//        if (self.payType == indexPath.row) {
//            [rightBtn setImage:[UIImage imageNamed:@"确认"] forState:UIControlStateNormal];
//        }else{
//            [rightBtn setImage:[UIImage imageNamed:@"圆"] forState:UIControlStateNormal];
//        }
    }
    if (indexPath.section == 2 && indexPath.row == 0) {
        UILabel *sendFoodLab = (UILabel *)[cell viewWithTag:3120];
        sendFoodLab.text = [NSString stringWithFormat:@"今日 %@",self.giveFoodTimeStr];
        [sendFoodLab sizeToFit];
        sendFoodLab.center = CGPointMake(WIDTH_CONTROLLER - 10 * self.numSingleVesion - sendFoodLab.frame.size.width / 2, cell.frame.size.height / 2);
        
    }else if (indexPath.section == 2 && indexPath.row == 1){
        UILabel *remarkLab = (UILabel *)[cell viewWithTag:3100];
        remarkLab.text = self.remarkLabText;
        
        [remarkLab sizeToFit];
        remarkLab.center = CGPointMake(WIDTH_CONTROLLER - 10 * self.numSingleVesion - 5 * self.numSingleVesion / 2 - remarkLab.frame.size.width / 2, cell.frame.size.height / 2);
    }else if (indexPath.section == 2 && indexPath.row == 2){
        UILabel *debitLab = (UILabel *)[cell viewWithTag:3150];
        debitLab.text = self.debiteDetail;
        [debitLab sizeToFit];
        debitLab.center = CGPointMake(WIDTH_CONTROLLER - 10 * self.numSingleVesion - 5 * self.numSingleVesion / 2 - debitLab.frame.size.width / 2, cell.frame.size.height / 2);
        //cell.textLabel.text = @"";
        self.debitLab = debitLab;
        
//        UISwitch *swtich = [[UISwitch alloc] initWithFrame:CGRectMake(WIDTH_CONTROLLER - 60 * self.numSingleVesion, 5 * self.numSingleVesion, 50 * self.numSingleVesion, 30 * self.numSingleVesion)];
//        [swtich addTarget:self action:@selector(switchValueChange:) forControlEvents:UIControlEventValueChanged];
//
//        [cell.contentView addSubview:swtich];
//        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(10 * self.numSingleVesion, 50 * self.numSingleVesion, WIDTH_CONTROLLER - 20 * self.numSingleVesion, 30 * self.numSingleVesion)];
//        textField.borderStyle = UITextBorderStyleRoundedRect;
//        textField.placeholder = @"请填写公司或者个人信息开头";
//        textField.textColor = SMSColor(211, 211, 211);
//        [cell.contentView addSubview:textField];
//        self.debiteText = textField;
//        textField.font = [UIFont systemFontOfSize:13];
//        textField.hidden = YES;
//        
//
////        UILabel *debitLab = [[UILabel alloc] initWithFrame:CGRectMake(15 * self.numSingleVesion, 15 * self.numSingleVesion, WIDTH_CONTROLLER - 20 * self.numSingleVesion, 20 * self.numSingleVesion)];
////        debitLab.text = @"需要发票";
////        debitLab.font = [UIFont systemFontOfSize:13];
////        [debitLab sizeToFit];
////        debitLab.textColor = SMSColor(51, 51, 51);
////        [cell.contentView addSubview:debitLab];
//        if(self.switchDebit){
//            cell.textLabel.frame = CGRectMake(15 * self.numSingleVesion, 15 * self.numSingleVesion, 100 * self.numSingleVesion, 20 * self.numSingleVesion);
//            textField.hidden = NO;
//            swtich.on = YES;
//
//        }else{
//            swtich.on = NO;
//            textField.frame = CGRectMake(10 * self.numSingleVesion,0 * self.numSingleVesion, WIDTH_CONTROLLER - 20 * self.numSingleVesion, 20 * self.numSingleVesion);
//            //debitLab.hidden = YES;
//            //debitLab.frame = CGRectZero;
//        }
    }else if (indexPath.section == 4){
        
    }else if (indexPath.section == 3 && indexPath.row == 0){//代金券
        UILabel *debitLab = (UILabel *)[cell viewWithTag:3180];
        debitLab.text = self.discount;
        [debitLab sizeToFit];
        debitLab.center = CGPointMake(WIDTH_CONTROLLER - 10 * self.numSingleVesion - 5 * self.numSingleVesion / 2 - debitLab.frame.size.width / 2, cell.frame.size.height / 2);
    }
//    if(indexPath.row % 2 == 0){
//        cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
//    }else{
//        
//    }
    
    return cell;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }else{
        
        return 30 * self.numSingleVesion;
    }
}
//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//   
//        return 30 * self.numSingleVesion;
//}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 60 * self.numSingleVesion;
    }else if(indexPath.section == 2 && indexPath.row == 2 && self.switchDebit){
        return 80 * self.numSingleVesion;
    }
        return 40 * self.numSingleVesion;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //选择优惠方式
    if (indexPath.section == 1) {
        if (self.previlageArr.count == 0) {
            //[self.view makeToast:@"正在加载优惠方式,"]
            [self makeHUd];
            return;
        }
        UIButton *paymentBtn = (UIButton *)[tableView viewWithTag:1610 + indexPath.row];
        if (!self.payPreBtn) {
            self.payPreBtn = paymentBtn;
        }else{
            [self.payPreBtn setImage:[UIImage imageNamed:@"圆"] forState:UIControlStateNormal];
        }
        [paymentBtn setImage:[UIImage imageNamed:@"确认"] forState:UIControlStateNormal];
        self.payPreBtn = paymentBtn;
        for (NSInteger i = 0; i < self.previlageArr.count; i++) {
            PaymentPrevilage *model = self.previlageArr[i];
            NSString *temp = self.dataArr[1][indexPath.row];
            //self.priceLab.text = self.moneyTotalCount;
            if ([model.Payname isEqual:temp]) {
                if (model.couponName.length == 0) {
                    self.previlageLab.text = @"以优惠0元";
                    self.priceLab.text = self.moneyTotalCount;
                    self.finalPrice = self.totalPrice;
                    self.privelegeMoney = @"0";
                }else{
                    CGFloat priceTotal = self.totalPrice - model.couponMoney.floatValue;
                    self.privelegeMoney = model.couponMoney;
                    if (priceTotal <= 0) {
                        priceTotal = 0;
                    }
                    self.previlageLab.text = model.couponName;
                    self.priceLab.text = [NSString stringWithFormat:@"总计￥%0.2f元",priceTotal];
                    self.finalPrice = priceTotal;
                    
                }
            }
        }

//        if (!self.payPreBtn) {
//            self.payPreBtn = paymentBtn;
//        }else{
//            [self.payPreBtn setImage:[UIImage imageNamed:@"圆"] forState:UIControlStateNormal];
//        }
//        [paymentBtn setImage:[UIImage imageNamed:@"确认"] forState:UIControlStateNormal];
//        self.payPreBtn = paymentBtn;
//        for (NSInteger i = 0; i < 3; i++) {
//            UIButton *payBtn = (UIButton *)[tableView viewWithTag:1610 + i];
//            [payBtn setImage:[UIImage imageNamed:@"圆"] forState:UIControlStateNormal];
//        }
        self.payType = paymentBtn.tag - 1610;
        //[self.tableView reloadData];

    }
    
       if (indexPath.section == 0 && indexPath.row == 0){
        CommitOrderViewController *commitOrder = [[CommitOrderViewController alloc] initWithAddressArr:self.addressListArr];
        commitOrder.target = self;
        [self.navigationController pushViewController:commitOrder animated:YES];

    }
    if (indexPath.section == 2 && indexPath.row == 1) {
        RemarkSendFoodViewController *remark = [[RemarkSendFoodViewController alloc] init];
        remark.target = self;
        remark.content = self.remarkLab.text;
        [self.navigationController pushViewController:remark animated:YES];
    }else if (indexPath.section == 2 && indexPath.row == 2){
        DebitCompanyOrPersonalViewController *debitCompanyOrPersonal = [[DebitCompanyOrPersonalViewController alloc] init];
        debitCompanyOrPersonal.target = self;
        debitCompanyOrPersonal.content = self.debitLab.text;
        [self.navigationController pushViewController:debitCompanyOrPersonal animated:YES];
    }
    //代金券
    if(indexPath.section == 3){
        GoodsPrivilegeViewController *goodsPrivilege = [[GoodsPrivilegeViewController alloc] initWithMerchantId:self.merchantId andMoney:self.totalPrice];
        goodsPrivilege.target = self;
        [self.navigationController pushViewController:goodsPrivilege animated:YES];
//        MerchantDiscountViewController *merchant = [[MerchantDiscountViewController alloc] initWithMoney:self.discount];
//        merchant.target = self;
//        [self.navigationController pushViewController:merchant animated:YES];
    }
}
//加载优惠方式
-(void)payment:(UIButton *)paymentBtn{
    if (self.previlageArr.count == 0) {
        //[self.view makeToast:@"正在加载优惠方式,"]
        [self makeHUd];
        return;
    }
    for (NSInteger i = 0; i < self.previlageArr.count; i++) {
        PaymentPrevilage *model = self.previlageArr[i];
        NSString *temp = self.dataArr[1][paymentBtn.tag - 1610];
        //self.priceLab.text = self.moneyTotalCount;
        if ([model.Payname isEqual:temp]) {
            if (model.couponName.length == 0) {
                self.previlageLab.text = @"以优惠0元";
                self.priceLab.text = self.moneyTotalCount;
                self.finalPrice = self.totalPrice;
                self.privelegeMoney = @"0";
            }else{
                CGFloat priceTotal = self.totalPrice - model.couponMoney.floatValue;
                self.privelegeMoney = model.couponMoney;
                if (priceTotal <= 0) {
                    priceTotal = 0;
                }
                self.previlageLab.text = model.couponName;
                self.priceLab.text = [NSString stringWithFormat:@"总计￥%0.2f元",priceTotal];
                self.finalPrice = priceTotal;
                
            }
        }
    }
    if (!self.payPreBtn) {
        self.payPreBtn = paymentBtn;
    }else{
        [self.payPreBtn setImage:[UIImage imageNamed:@"圆"] forState:UIControlStateNormal];
    }
    [paymentBtn setImage:[UIImage imageNamed:@"确认"] forState:UIControlStateNormal];
    self.payPreBtn = paymentBtn;
    for (NSInteger i = 0; i < 3; i++) {
        UIButton *payBtn = (UIButton *)[self.view viewWithTag:1610 + i];
        [payBtn setImage:[UIImage imageNamed:@"圆"] forState:UIControlStateNormal];
    }
    self.payType = paymentBtn.tag - 1610;
   //  [self.tableView reloadData];

    
}
//是否需要发票
- (void)switchValueChange:(UISwitch *)switchChange{
    if (switchChange.on) {
        self.switchDebit = YES;
    }else{
        self.switchDebit = NO;
    }
    [self.tableView reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    // Do any additional setup after loading the view.
}
#pragma mark 展示送餐时间
- (void)showFoodTime{
//    UIView *actionView = [[UIView alloc] initWithFrame:CGRectMake(0, HEIGHT_CONTROLLER - 120 * self.numSingleVesion, WIDTH_CONTROLLER, 120 * self.numSingleVesion)];
//    actionView.backgroundColor = [UIColor redColor];
//    [self.view addSubview:actionView];
    //UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"" destructiveButtonTitle:nil otherButtonTitles:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"89",@"",@"",@"",@"", @"1",@"2",@"3",@"4",nil];
    if (self.timeListArr.count == 0) {
        [self makeHUd];
        return;
    }
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"送餐时间" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:nil];
    [actionSheet addButtonWithTitle:@"立即送餐"];

    for (NSInteger i = 0; i < self.timeListArr.count; i++) {
        GiveFoodTimeListModel *model = self.timeListArr[i];
        [actionSheet addButtonWithTitle:model.starttime];

    }
    
    [actionSheet showInView:self.view];
}
#pragma mark actionSheet的代理
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"buttonIndex:%ld",buttonIndex);
    if (buttonIndex != 1) {
        if (buttonIndex == 0) {
            return;
        }
        GiveFoodTimeListModel *model = self.timeListArr[buttonIndex - 2];
        self.giveFoodTimeStr = model.starttime;
        [self.tableView reloadData];

    }else{
        self.giveFoodTimeStr = @"立即送餐";
    }
}
#pragma mark makeUIPickDate
-(void)makePickDate{
    UIDatePicker *datePick = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, HEIGHT_CONTROLLER - 200 * self.numSingleVesion, WIDTH_CONTROLLER, 100 * self.numSingleVesion)];
    [datePick addTarget:self action:@selector(datePickDown) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:datePick];
    self.datePick = datePick;
    self.datePick.hidden = YES;
    NSDate *currentTime  = [NSDate date];
    // 设置当前显示
    [datePick setDate:currentTime animated:YES];
    // 设置显示最大时间（
   // [datePick setMaximumDate:@"21:30"];
    // 显示模式
    [datePick setDatePickerMode:UIDatePickerModeDateAndTime];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:MM"];
    NSDate* maxDate = [dateFormatter dateFromString:@"19:30"];
    [self.datePick setMaximumDate:maxDate];
}
-(void)datePickDown{
    NSDate *select = [self.datePick date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:MM"];
     NSDate* maxDate = [dateFormatter dateFromString:@"19:30"];
    [self.datePick setMaximumDate:maxDate];
    NSString *dateAndTime = [dateFormatter stringFromDate:select];
    NSLog(@"%@",dateAndTime);
}
#pragma mark 返回配送配注内容
-(void)returnSendDeatil:(NSString *)detail{
//    UILabel *remarkLab = (UILabel *)[self.view viewWithTag:3100];
//    remarkLab.text = detail;
//    [remarkLab sizeToFit];
//    
//    remarkLab.center = CGPointMake(WIDTH_CONTROLLER - 10 * self.numSingleVesion - remarkLab.frame.size.width * self.numSingleVesion / 2, 20 * self.numSingleVesion);
    if (detail.length == 0) {
        return;
    }
    self.remarkLabText = detail;
    //[self.remarkLab removeFromSuperview];
    //self.remarkLab = nil;
    self.remarkLab.text = detail;
    [self.tableView reloadData];

    //[self.dataArr addObject:@[@"配送时间",@"配送备注",@"需要发票"]];
}
#pragma mark 返回发票信息
-(void)retunDebitDeatil:(NSString *)detail{
//    UILabel *remarkLab = (UILabel *)[self.view viewWithTag:3150];
//    NSLog(@"for%@",remarkLab.text);
//    remarkLab.text = detail;
//    [remarkLab sizeToFit];
//    NSLog(@"pre%@",remarkLab.text);
    //remarkLab.center = CGPointMake(WIDTH_CONTROLLER - 10 * self.numSingleVesion - remarkLab.frame.size.width * self.numSingleVesion / 2, 20 * self.numSingleVesion);
    if (detail.length == 0) {
        return;
    }
    self.debiteDetail = detail;
    self.debitLab.text = detail;
    //[self.debitLab removeFromSuperview];
    //self.debitLab = nil;
    [self.tableView reloadData];

    //self.remarkLabText = detail;
    //[self.dataArr addObject:@[@"配送时间",@"配送备注",@"需要发票"]];
}
//返回优惠钱数
- (void)retunMoney:(NSString *)money{
    if (money.length == 0) {
        return;
    }
    self.discount = money;
    self.discountLab.text = money;
    //[self.debitLab removeFromSuperview];
    //self.debitLab = nil;
    //底部钱数相减
        CGFloat priceTotal = self.totalPrice - money.floatValue;
        if (priceTotal <= 0) {
            priceTotal = 0;
        }
    CGFloat privelegeMoney = money.floatValue + self.privelegeMoney.floatValue;
        self.previlageLab.text = [NSString stringWithFormat:@"以优惠%0.2f元 ",privelegeMoney];
        [self.previlageLab sizeToFit];
        self.previlageLab.center = CGPointMake(5 * self.numSingleVesion + self.previlageLab.frame.size.width / 2, 49 / 2 * self.numSingleVesion);
        self.priceLab.text = [NSString stringWithFormat:@"总计￥%0.2f元",priceTotal];
        self.finalPrice = priceTotal;
        
    

    
    [self.tableView reloadData];

}
//获取默认地址
- (void)gainDefaultAddress:(AddressModel *)model{
    [self.dataArr replaceObjectAtIndex:0 withObject:@[model]];
    [self cahngeAddress:model];
    [self.tableView reloadData];
}
//更换默认地址
- (void)cahngeAddress:(AddressModel *)model{
    AFNetworkTwoPackaging *twoPack = [[AFNetworkTwoPackaging alloc] init];

    [twoPack getUrl:[NSString stringWithFormat:DEFAULTADDRESS,[StoreageMessage getMessage][2],model.ID] andFinishBlock:^(id getResult) {
        
    }];
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
