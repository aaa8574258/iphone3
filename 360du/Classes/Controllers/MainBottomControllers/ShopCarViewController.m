//
//  ShopCarViewController.m
//  360du
//
//  Created by 利美 on 16/9/20.
//  Copyright © 2016年 wangjian. All rights reserved.
//

#import "ShopCarViewController.h"
#import "ShopCarCell.h"
#import "JSCartModel.h"
#import "CommitOrderViewController.h"
#import "StoreageMessage.h"
#import "NFPickerView.h"
#import "shopCarsModel.h"
#import "WeChantViewViewController.h"
#import "JSCartViewController.h"
#import "UIView+Toast.h"
#import "FoodsYHQModel.h"

@interface ShopCarViewController ()<UITableViewDelegate,UITableViewDataSource,sendNewAddress,NFPickerViewDelegete,viewDelegate>
@property (nonatomic ,copy) NSString *fpStr;
@property (nonatomic ,assign) float allPirce;

@property (nonatomic ,copy ) NSString *name,*ID;
@property (nonatomic ,copy) NSString *address;
@property (nonatomic ,copy) NSString *phoneNumber;
@property (nonatomic ,copy) NSString *timeBtn;
@property (nonatomic ,strong) UIButton *btnT;
@property (nonatomic ,strong) NSArray *lastArr;
//@property (nonatomic ,strong) NSMutableDictionary *SJDic;
//@property( nonatomic ,copy) NSString *IDStr;
@property (nonatomic ,strong) NSMutableArray *OtherData;
@property (nonatomic ,strong) NSMutableDictionary *OtherDic;
//@property (nonatomic ,strong) NSIndexPath *tableIndexPath;
@property (nonatomic ,assign) NSInteger sectionIndex;
@property (nonatomic ,copy) NSString *tagStr;
@property (nonatomic ,strong) NSMutableArray *tagImgArr;
@property (nonatomic ,strong) UILabel *yhLab;
@property (nonatomic ,strong) UILabel *totalLab;

@property (nonatomic ,copy) NSString *yhMoney;
@property (nonatomic, assign) float paymoney;
@end

@implementation ShopCarViewController

- (instancetype)initWithData:(NSMutableArray *)arr
{
    self = [super init];
    if (self) {
        self.Strdelegate = self;
        self.OtherDic = [NSMutableDictionary dictionaryWithCapacity:0];
        [self loadAddressAtIndex:0];
        self.dataArr = arr;
        NSLog(@"121212121212%@",self.dataArr);
        [self makeUI];
    }
    return self;
}


-(void)viewDidAppear:(BOOL)animated{
    [self sendNewAddressAtIndex:0];
    self.tagStr = @"0";
    [self makeYH];

//    [self makeUI];
}


-(void)makeYH{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, HEIGHT_CONTENTVIEW - 50, WIDTH_CONTENTVIEW, 50)];
    view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:view];
    [self.view bringSubviewToFront:view];
    
    FoodsYHQModel *model = self.yhqArr[0];
    self.yhMoney = model.ysMoney;
    
    
    
    UILabel *laby = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 110, 30)];
    laby.font = [UIFont systemFontOfSize:17];
    [view addSubview:laby];
    if (self.yhMoney.length != 0) {
        laby.text = [NSString stringWithFormat:@"已优惠 %@元",self.yhMoney];
    }
    self.yhLab = laby;
    
    
    UILabel *lab1 = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH_CONTENTVIEW/2-50, 10, 50, 30)];
    lab1.text = @"合计: ";
    lab1.font = [UIFont systemFontOfSize:17];
    [view addSubview:lab1];
    UILabel *lab2 = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH_CONTENTVIEW/2, 10, 100, 30)];
    lab2.text = [NSString stringWithFormat:@"¥%0.1f",self.allPirce - self.yhMoney.floatValue];
    self.paymoney = self.allPirce - self.yhMoney.floatValue;
    lab2.font = [UIFont systemFontOfSize:17];
    lab2.textColor = [UIColor orangeColor];
    [view addSubview:lab2];
    self.totalLab = lab2;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(WIDTH_CONTENTVIEW - 100 , 0, 100, 50);
    [btn setTitle:@"提交订单" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor redColor];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(makeOKAction:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];
    
}



-(void) makeUI{
    
    self.tabelView = [[UITableView alloc] initWithFrame:self.view.frame];
//    self.tabelView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.tabelView];
    self.tabelView.backgroundColor = [UIColor whiteColor];
    self.tabelView.delegate = self;
    self.tabelView.dataSource = self;
//    self.tabelView.contentSize = CGSizeMake(WIDTH_CONTENTVIEW, self.tabelView.frame.size.height + 100 * self.numSingleVesion);
    self.allPirce = 0;
    NSLog(@"%@",self.dataArr);
    for (int i = 0; i < self.dataArr.count ; i ++) {
        
        for (NSInteger j = 0; j < [self.dataArr[i] count] ; j++) {

            JSCartModel *model = self.dataArr[i][j];
            self.allPirce += model.unitPrice * model.count;
        }
    }
    
    
    
    
 
    
    
    
    
    [self newModel];
//    [self setBackImageStateName:@"fanhuijian02.png" AndHighlightedName:@""];
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTENTVIEW, 20 *self.numSingleVesion)];
    v.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:v];
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(WIDTH_CONTROLLER - 32 , (44 - 2) / 2, 30, 40);
    [leftBtn setImage:[UIImage imageNamed:@"fanhuijian2222.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(setBack) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setImageEdgeInsets:UIEdgeInsetsMake(6, 5, 6, 5)];
    UIBarButtonItem *leftSecondItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftSecondItem;
//    view.backgroundColor = [UIColor redColor];
}

-(void) newModel{

    self.OtherData = [NSMutableArray arrayWithCapacity:self.dataArr.count];
//    NSLog(@"%lu",(unsigned long)self.dataArr.count);
    for (int i = 0; i < self.dataArr.count ; i ++) {
        shopCarsModel *shopModel = [shopCarsModel new];
        shopModel.isArrivedPay = @"2";
        shopModel.SendEndTime = @"";
        shopModel.remark = @"";
        shopModel.faPiao = @"";
        
        [self.OtherData addObject:shopModel];
    }
}



-(void)setBack{
    if (![self.target isKindOfClass:[JSCartViewController class]]) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        JSCartViewController *js = [[JSCartViewController alloc] init];
        [self.navigationController pushViewController:js animated:YES];
    }
}

-(void) makeOKAction:(UIButton *)center{
    
    NSString *istimeok;
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i < self.dataArr.count ; i ++) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:1];
        NSMutableArray *arr1 = [NSMutableArray arrayWithCapacity:0];
        NSString *did = @"";
        NSString *shopType = @"";
        NSString *remark = @"";
        NSString *faPiao = @"";
        NSString *remark1 = @"";
        NSString *SendEndTime = @"";
        for (int j = 0; j < [self.dataArr[i] count]; j ++) {
            
            JSCartModel *model = self.dataArr[i][j];
            shopType = model.shopType;
            did = model.did;
            [arr1 addObject:model.shopCarId];
            remark = model.isArrivedPay;
            faPiao = model.faPiao;
            remark1 = model.remark;
                SendEndTime = model.SendEndTime;
            if ([model.isXuni isEqualToString:@"N"]) {
                istimeok = @"1";
            }else{
                istimeok = @"2";
            }
            
        }
        
        shopCarsModel *model1 = self.OtherData[i];

        //        if (model1.SendEndTime.length == 0) {
        //            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请选择自提或者送货时间!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
        //            [alertView show];
        //            return;
        //        }
//        NSLog(@"%@",model1.SendEndTime);
        NSString *ns =[arr1 componentsJoinedByString:@","];
        [dic setValue:[StoreageMessage getMessage][2] forKey:@"memberId"];
        [dic setValue:shopType forKey:@"shopType"];
        [dic setValue:did forKey:@"did"];
        [dic setValue:ns forKey:@"shopCarIds"];
        [dic setValue:model1.isArrivedPay forKey:@"isArrivedPay"];
        [dic setValue:model1.faPiao forKey:@"faPiao"];
        [dic setValue:model1.remark forKey:@"remark"];
        if ([istimeok isEqualToString:@"1"]) {
            [dic setValue:@"zt" forKey:@"SendEndTime"];
        }else{
            [dic setValue:model1.SendEndTime forKey:@"SendEndTime"];
            
        }
        [dic setValue:@"" forKey:@"yhCode"];
        
        
        
        
        
        [arr addObject:dic];
    }
    self.lastArr = arr;
    NSLog(@"%@",_lastArr);
    
    for (NSDictionary *dic in arr) {
        NSString *str = dic[@"SendEndTime"];
        NSString *str1 = dic[@"shopType"];
        NSLog(@"666666：%@",dic);

        if (str1.integerValue == 1 ) {
            if (str.length == 0 ) {
                [self.view makeToast:@"请选择送货时间"];
                return;
            }
        }
        
        
       
    }
    if (![StoreageMessage getMessage][2]) {
        [self.view makeToast:@"获取登录信息失败"];
        return;
    }else if (!self.ID) {
        [self.view makeToast:@"请选择送货地址等信息"];
        return;
    }
        UIAlertView*alert = [[UIAlertView alloc]initWithTitle:@"提示"
                             
                                                      message:@"请选择支付方式："
                             
                                                     delegate:self
                             
                                            cancelButtonTitle:@"取消"
                             
                                            otherButtonTitles:@"使用微信支付",
                             @"使用支付宝支付",
                             nil];
        [alert show];

}

//#import "UIView+Toast.h"
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex

{
     if (buttonIndex == 1) {
//        NSString *jsonString = [[NSString alloc] initWithData:[self toJSONData:self.lastArr] encoding:NSUTF8StringEncoding];
//        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//        manager.responseSerializer = [AFJSONResponseSerializer serializer];
//
//        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/json",@"text/html",@"application/json",@"text/plain",nil];
//        NSDictionary *dic = [[NSDictionary alloc]init];
//        dic = @{@"serviceName":@"ShopCarAndOrder",@"medthodName":@"commitOrder",@"addressID":self.ID,@"PaymentType":[NSString stringWithFormat:@"%ld",(long)buttonIndex],@"orderData":jsonString};
//
//        NSString *url = [NSString stringWithFormat:COMMITORDE];
//        [manager POST:url parameters:dic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//                [StoreageMessage getErrorMessage:@"NULL" fromUrl:url];
//
//                if ([responseObject[@"code"] isEqualToString:@"000000"]) {
//
//                [WeChantViewViewController payName:@"快快猫购物车付款" andMoney:[NSString stringWithFormat:@"%0.2f",self.allPirce *100] andOder:[NSString stringWithFormat:@"%@",responseObject[@"orderId     "]]];
//                [self.navigationController popToRootViewControllerAnimated:YES];
//            }
//        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//            NSLog(@"Error: %@", error);
//        }];
         [self.view makeToast:@"暂不支持微信支付"];
        
    }else if (buttonIndex == 2){
        NSString *jsonString = [[NSString alloc] initWithData:[self toJSONData:self.lastArr] encoding:NSUTF8StringEncoding];

        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        //申明返回的结果是json类型
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        //申明请求的数据是json类型
        //    manager.requestSerializer=[AFJSONRequestSerializer serializer];
        //如果报接受类型不一致请替换一致text/html或别的
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/json",@"text/html",@"application/json",@"text/plain",nil];
        //传入的参数  十八里店横街子
        NSDictionary *dic = [[NSDictionary alloc]init];
        dic = @{@"serviceName":@"ShopCarAndOrder",@"medthodName":@"commitOrder",@"addressID":self.ID,@"PaymentType":[NSString stringWithFormat:@"%ld",buttonIndex],@"orderData":jsonString};
//        NSLog(@"%@",[NSString stringWithFormat:@"%@,%@",_longitude,_latitude]);
        //你的接口地址
        NSLog(@"%@",dic);
        NSString *url = [NSString stringWithFormat:COMMITORDE];
        [manager POST:url parameters:dic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [StoreageMessage getErrorMessage:@"NULL" fromUrl:url];
            NSLog(@"%0.2f",self.paymoney);
            if ([responseObject[@"code"] isEqualToString:@"000000"]) {
               [WeChantViewViewController payTHeMoneyUseAliPayWithOrderId:[NSString stringWithFormat:@"%@",responseObject[@"orderId"]] totalMoney:[NSString stringWithFormat:@"%0.2f",self.paymoney] payTitle:@"快快猫购物车支付"];
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"Error: %@", error);
        }];

    }
    
    
}



- (NSData *)toJSONData:(id)theData{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:theData options:NSJSONWritingPrettyPrinted error:nil];
    if ([jsonData length] ){
        return jsonData;
    }else{
        return nil;
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
//    self.OtherDic = [[NSMutableDictionary alloc] init];
//    self.OtherData[10000][10000] = @{};
    // Do any additional setup after loading the view.

    
    
}



-(void)removeViewWithSendEndTimeString:(NSString *)string atIndex:(NSInteger)index{
    shopCarsModel *model = self.OtherData[index-1];
    model.SendEndTime = string;
//    NSLog(@"%ld",(long)self.sectionIndex);
//    [self.tabelView reloadData];
}

-(void)removeViewWithFaPiaoString:(NSString *)string atIndex:(NSInteger)index{
    shopCarsModel *model = self.OtherData[index-1];
    model.faPiao = string;
//    NSLog(@"%ld",(long)self.sectionIndex);

//    [self.tabelView reloadData];
}-(void)removeViewWithIsArrivePayString:(NSString *)string atIndex:(NSInteger)index{
    shopCarsModel *model = self.OtherData[index -1];
    model.isArrivedPay = string;
//    NSLog(@"%ld",(long)self.sectionIndex);

//    [self.tabelView reloadData];
}-(void)removeViewWithRemarkString:(NSString *)string atIndex:(NSInteger)index{
    shopCarsModel *model = self.OtherData[index -1];
    model.remark = string;
}






-(NSInteger ) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if (section == self.dataArr.count){
        return 8;
    }
    return 7;
}

-(NSInteger ) numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArr.count +1;
}

//-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
//    return view;
//    
//}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 4;
    }
    return 10;//section头部高度
}


-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    self.tableIndexPath = indexPath;

    if (indexPath.section == 0) {
        return 100 + (self.yhqArr.count * 40);
    }else{

        
        NSArray *sectionArr = self.dataArr[indexPath.section - 1];
        NSLog(@"%@",sectionArr);
        JSCartModel *model = self.dataArr[indexPath.section - 1][0];

        if (indexPath.row == 0) {
            return 48;
        }else if (indexPath.row == 1){
            

            return sectionArr.count * 117 ;
        }else if (indexPath.row == 2){
            if (model.shopType.integerValue == 2 || [model.isXuni isEqualToString:@"N"]) {
                return 0;
            }
            
            return 50;
        }else if (indexPath.row == 3){
            if (model.shopType.integerValue == 2 || [model.isXuni isEqualToString:@"N"]) {
                return 0;
            }
            return 50;
        
        }else if (indexPath.row == 4){
            if ([model.isXuni isEqualToString:@"N"]) {
                return 0;
            }
            return 50;
        }
        
        
        return 50;
    }
    return 100;
}






-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *CellIdentifier = [NSString stringWithFormat:@"shopCarCell%ld%ld", (long)[indexPath section], (long)[indexPath row]];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier ];
    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    cell.contentView.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0) {
        UILabel *labName = [[UILabel alloc] initWithFrame:CGRectMake(20, 8, WIDTH_CONTENTVIEW - 40 / 2 , 30)];
        labName.numberOfLines = 0;
        labName.text = self.address;
        [cell.contentView addSubview:labName];
        UILabel *labName1 = [[UILabel alloc] initWithFrame:CGRectMake(128, 8, WIDTH_CONTENTVIEW - 40 / 2 , 30)];
        labName1.numberOfLines = 0;
        labName1.text = self.name;
        [cell.contentView addSubview:labName1];
        UILabel *labName2 = [[UILabel alloc] initWithFrame:CGRectMake(20, 38, WIDTH_CONTENTVIEW - 40, 60)];
        labName2.numberOfLines = 0;
        labName2.text = self.phoneNumber;
        [cell.contentView addSubview:labName2];
        UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(event:)];
        
        
        //将手势添加到需要相应的view中去
        
        //    [payView1 addGestureRecognizer:tapGesture1];
        labName.userInteractionEnabled = YES;
        labName1.userInteractionEnabled = YES;
        labName2.userInteractionEnabled = YES;

        [labName1 addGestureRecognizer:tapGesture];
        [labName2 addGestureRecognizer:tapGesture];
        [labName addGestureRecognizer:tapGesture];
        self.tagImgArr = [NSMutableArray arrayWithCapacity:0];
        
        for (NSInteger i = 0; i < self.yhqArr.count; i++) {
            FoodsYHQModel *model = self.yhqArr[i];
            
            UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 99 +(i * 40), WIDTH_CONTENTVIEW, 1)];
            view1.backgroundColor = [UIColor lightGrayColor];
            [cell.contentView addSubview:view1];
            UILabel *labName11 = [[UILabel alloc] initWithFrame:CGRectMake(20, 100 + (i * 43), WIDTH_CONTENTVIEW - 40 , 30)];
            labName11.numberOfLines = 0;
            labName11.text = [NSString stringWithFormat:@"%@-%@:%@",model.yhName,model.ysTypeName,model.ysMoney];
            [cell.contentView addSubview:labName11];
            UIImageView *image11 = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH_CONTENTVIEW - 60, 100 + (i * 43), 30 , 30)];
            //    image12.backgroundColor = [UIColor redColor];
            if (self.tagStr.integerValue == i) {
                [image11 setImage:[UIImage imageNamed:@"lbspay_bg_custom_checkbox_on.png"]];

            }else{
                [image11 setImage:[UIImage imageNamed:@"lbspay_bg_custom_checkbox_off.png"]];
            }
            [cell.contentView addSubview:image11];
            labName11.tag = 10086+i;
            image11.tag = 10010+i;
            labName11.userInteractionEnabled = YES;
            UITapGestureRecognizer * tapGesture1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(event1:)];
            [labName11 addGestureRecognizer:tapGesture1];
            [self.tagImgArr addObject:image11];

        }
        
    }else{
        shopCarsModel *model1 = self.OtherData[indexPath.section -1];
        NSArray *sectionArr = self.dataArr[indexPath.section - 1];
        if (indexPath.row == 0) {
            JSCartModel *model = sectionArr[indexPath.row];
            UILabel *label  = [[UILabel alloc] initWithFrame:cell.contentView.frame];
            label.backgroundColor = [UIColor whiteColor];
            label.text = model.shopName;
            [cell.contentView addSubview:label];
            
            if (model.isArrivedPay.integerValue == 1) {
                UILabel *label1  = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH_CONTENTVIEW- 180, 8, 120, 30)];
                label1.text = @"是否货到付款";
                [cell.contentView addSubview:label1];
                UISwitch *switchButton = [[UISwitch alloc] initWithFrame:CGRectMake(WIDTH_CONTENTVIEW - 60, 8, 30, 50)];
                switchButton.backgroundColor = [UIColor whiteColor];
                if (model1.isArrivedPay.integerValue == 1) {
                    [switchButton setOn:YES];

                }else{
                    [switchButton setOn:NO];

                }
                switchButton.tag = 100001;
                [switchButton addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
                [cell.contentView addSubview:switchButton];
            }
        }else if (indexPath.row == 1){
            for (NSInteger i = 0; i < sectionArr.count; i++) {
                JSCartModel *model = sectionArr[i];
                UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 117*i, WIDTH_CONTENTVIEW, 116)];
                [self makeProViewWithimageURL:model.picUrl andProName:model.proName andRule:model.proRule andPrice:[NSString stringWithFormat:@"%f",model.unitPrice] andNumber:[NSString stringWithFormat:@"%ld",(long)model.count] inView:view];
                [cell.contentView addSubview:view];
            }
        }else if (indexPath.row == 3){
            JSCartModel *model = sectionArr[0];
            NSLog(@"%@",model.shopType);
            if (model.shopType.integerValue == 2 || [model.isXuni isEqualToString:@"N"]) {
                [cell removeFromSuperview];
            }else{
                
            UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(8, 8, 100, 30)];
            lab.text = @"配送时间";
            [cell.contentView addSubview:lab];
            
            
//            NSLog(@"%@",self.timeBtn);
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
            button.backgroundColor = [UIColor whiteColor];
            button.frame = CGRectMake(WIDTH_CONTENTVIEW - 120, 8, 104, 30);
            
            NSLog(@"11%@",model1.SendEndTime);
                if ([model1.SendEndTime isEqualToString:@"zt"]) {
                    [button setTitle:@"" forState:UIControlStateNormal];
                }else{
            [button setTitle:model1.SendEndTime forState:UIControlStateNormal];
                }
            [button setTintColor:[UIColor colorWithRed:209/255.0 green:209/255.0 blue:214/255.0 alpha:1]];
            [button addTarget:self action:@selector(timeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            button.tag =  model.did.integerValue;
            [cell.contentView addSubview:button];
        }
        }else if (indexPath.row == 4){
            JSCartModel *model = sectionArr[0];
            NSLog(@"%@",model.shopType);
            if ( [model.isXuni isEqualToString:@"N"]) {
                [cell removeFromSuperview];
            }else{

            UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(8, 8, 100, 30)];
            lab.text = @"配送备注";
            
            [cell.contentView addSubview:lab];
            UITextField * textF = [[UITextField alloc] initWithFrame:CGRectMake(108, 8, WIDTH_CONTENTVIEW - 124, 30)];
            textF.font = [UIFont systemFontOfSize:15];
            textF.backgroundColor = [UIColor whiteColor];
            textF.placeholder = @"(选填)可输入要求";
            if (model1.remark.length == 0) {
                textF.placeholder = @"(选填)可输入要求";

            }else{
                textF.text = model1.remark;
            }
            
            
            [textF addTarget:self action:@selector(textFAction:) forControlEvents:UIControlEventEditingChanged];
            textF.textAlignment = UITextAlignmentRight;
            [cell.contentView addSubview:textF];
            }
        }else if (indexPath.row == 5){
            UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(8, 8, 100, 30)];
            lab.text = @"需要发票";
            [cell.contentView addSubview:lab];
            UISwitch *switchButton = [[UISwitch alloc] initWithFrame:CGRectMake(WIDTH_CONTENTVIEW - 60, 8, 30, 50)];
            if (model1.faPiao.length == 0) {
                [switchButton setOn:NO];
                
            }else{
                [switchButton setOn:YES];
                
            }
            [switchButton addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
            switchButton.tag = 100002;
            switchButton.backgroundColor = [UIColor whiteColor];
            [cell.contentView addSubview:switchButton];
        
        }
        else if (indexPath.row == 6){
            NSLog(@"%@",model1.faPiao);
            if (model1.faPiao.length != 0) {
                UILabel *lab1 = [[UILabel alloc] initWithFrame:CGRectMake(8 , 8, 80, 30)];
                lab1.text = @"发票抬头";
                [cell.contentView addSubview:lab1];
                UITextField *textF = [[UITextField alloc] initWithFrame:CGRectMake(WIDTH_CONTENTVIEW/3, 8, WIDTH_CONTENTVIEW/3 * 2 - 16, 30)];
            [textF addTarget:self action:@selector(textFAction1:) forControlEvents:UIControlEventEditingChanged];

                [cell.contentView addSubview:textF];
            }else{
               cell.hidden = YES ;
            }
        }
        else if (indexPath.row == 2){
            JSCartModel *model = self.dataArr[indexPath.section - 1][0];
            if (model.shopType.integerValue == 2 || [model.isXuni isEqualToString:@"N"]) {
                [cell removeFromSuperview];
                cell.hidden = YES;
            }else{
                UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(8, 8, 100, 30)];
                lab.text = @"是否自提";
            
                [cell.contentView addSubview:lab];
                UISwitch *switchButton = [[UISwitch alloc] initWithFrame:CGRectMake(WIDTH_CONTENTVIEW - 60, 8, 30, 50)];
                NSLog(@"jjjjjjjjj：%@",model1.SendEndTime);
                if ([model1.SendEndTime isEqualToString:@"zt"]) {
                    [switchButton setOn:YES];
                }else{
                    if ([switchButton isOn]) {
//                        [switchButton setOn:YES];
                        [self.btnT setTitle:@"" forState:UIControlStateNormal];
                        
                    }else{
//                        switchButton.userInteractionEnabled = NO;
//                        [switchButton setOn:NO];
                        
                    }
                }
                switchButton.tag = 100003;
                [switchButton addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
                switchButton.backgroundColor = [UIColor whiteColor];
                [cell.contentView addSubview:switchButton];

            }
        }
    }
    return cell;
}

-(void)switchAction:(id)sender
{
//    [self.tabelView reloadData];

    UISwitch *switchButton = (UISwitch*)sender;
    BOOL isButtonOn = [switchButton isOn];
    if (switchButton.tag == 100001) {

        UITableViewCell *cell = (UITableViewCell *)[[switchButton superview] superview];
        NSIndexPath *indexPath = [self.tabelView indexPathForCell:cell];
        if (isButtonOn) {
            [self removeViewWithIsArrivePayString:@"1" atIndex:indexPath.section];
        }else {
            [self removeViewWithIsArrivePayString:@"2" atIndex:indexPath.section];
        }
    }
    if (switchButton.tag == 100003) {
        UITableViewCell *cell = (UITableViewCell *)[[switchButton superview] superview];
        NSIndexPath *indexPath = [self.tabelView indexPathForCell:cell];
        if (isButtonOn) {
            [self removeViewWithSendEndTimeString:@"zt" atIndex:indexPath.section];
//            [self.btnT setTitle:@"" forState:UIControlStateNormal];
            [self.tabelView reloadData];
        }else {
//            [self.btnT setTitle:@"1" forState:UIControlStateNormal];
//            [switchButton setOn:NO];
//            [self.tabelView reloadData];
            [self removeViewWithSendEndTimeString:@"" atIndex:indexPath.section];
            [self.tabelView reloadData];

        }
    }
    if (switchButton.tag == 100002) {
        UITableViewCell *cell = (UITableViewCell *)[[switchButton superview] superview];
        NSIndexPath *indexPath = [self.tabelView indexPathForCell:cell];
        if (isButtonOn) {
            [self removeViewWithFaPiaoString:@"1" atIndex:indexPath.section];
            [self.tabelView reloadData];

        }else {
            [self removeViewWithFaPiaoString:@"" atIndex:indexPath.section];
            [self.tabelView reloadData];

        }

    }

}
//model.did.integerValue + 123456 + indexPath.section - 1

-(void)timeBtnAction:(UIButton *)center {
    NFPickerView *picker = [[NFPickerView alloc] initWithFrame:CGRectMake(0, HEIGHT_CONTENTVIEW - 200 , WIDTH_CONTENTVIEW, 200)];
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
    AFNetworkTwoPackaging *twoPacking = [[AFNetworkTwoPackaging alloc] init];
//    NSLog(@"%@",[NSString stringWithFormat:WMTIMELIST,[NSString stringWithFormat:@"%ld",(long)center.tag]]);
    [twoPacking getUrl:[NSString stringWithFormat:WMTIMELIST,[NSString stringWithFormat:@"%ld",(long)center.tag ]] andFinishBlock:^(id getResult) {
//        NSLog(@"%@",getResult);
        for (NSDictionary *dic in getResult) {
            [arr addObject:dic[@"starttime"]];
            picker.city = [arr mutableCopy];
//            NSLog(@"%@",picker.city);
            
        }
        picker.country = nil;
        picker.province = nil;
        picker.delegate = self;
        
        [picker show];
    }];
    self.btnT = center;
    
}


-(void)pickerDidSelectWithSelfView:(UIView *)view ProvinceName:(NSString *)provinceName cityName:(NSString *)cityName countrys:(NSString *)countrys{
    self.timeBtn = cityName;
    NSString *seee = cityName;

//    for (int i = 0;  i < self.dataArr.count; i++) {
    UITableViewCell *cell = (UITableViewCell *)[[self.btnT superview] superview];
    NSIndexPath *indexPath = [self.tabelView indexPathForCell:cell];
    [self  removeViewWithSendEndTimeString:seee atIndex:indexPath.section];
        
        [self.btnT setTitle:seee forState:UIControlStateNormal];

//    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:3 inSection:self.tableIndexPath.section];
//    [self.tabelView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
    
//    [self.btnT setTitle:seee forState:UIControlStateNormal];
    
//    NSLog(@"%ld----%ld",(long)self.btnT.tag,(long)self.tableIndexPath.section);
    [self.tabelView reloadData];
}

-(void)textFAction:(UITextField *)sender{
    UITableViewCell *cell = (UITableViewCell *)[[sender superview] superview];
    NSIndexPath *indexPath = [self.tabelView indexPathForCell:cell];
    [self removeViewWithRemarkString:sender.text atIndex:indexPath.section];
}


-(void)textFAction1:(UITextField *)sender{
    UITableViewCell *cell = (UITableViewCell *)[[sender superview] superview];
    NSIndexPath *indexPath = [self.tabelView indexPathForCell:cell];
    [self removeViewWithFaPiaoString:sender.text atIndex:indexPath.section];
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

-(void)event:(UITapGestureRecognizer *)sender{
    CommitOrderViewController *orderViewController = [[CommitOrderViewController alloc] initWithAddressArr:nil];
    orderViewController.delegate = self;
    orderViewController.target = self;
    [self.navigationController pushViewController:orderViewController animated:YES];

}

-(void)event1:(UITapGestureRecognizer *)sender{
//    sender.view.tag - 10086;
//    NSLog(@"%ld----%ld",self.tagImg.tag - 10010,sender.view.tag - 10086);
    self.tagStr = [NSString stringWithFormat:@"%ld",sender.view.tag - 10086];
    NSLog(@"%@",self.tagStr);
  //  [self.tagImgArr[sender.view.tag - 10086] setImage:[UIImage imageNamed:@"lbspay_bg_custom_checkbox_off.png"]];
    for (NSInteger i = 0; i < self.tagImgArr.count; i ++) {
        if (i == sender.view.tag - 10086) {
            [self.tagImgArr[i] setImage:[UIImage imageNamed:@"lbspay_bg_custom_checkbox_on.png"]];
        }else{
            [self.tagImgArr[i] setImage:[UIImage imageNamed:@"lbspay_bg_custom_checkbox_off.png"]];
        }
    }
    FoodsYHQModel *model = self.yhqArr[_tagStr.integerValue];
    self.yhLab.text = [NSString stringWithFormat:@"已优惠 %@元",model.ysMoney];
    self.yhMoney = model.ysMoney;
    self.totalLab.text = [NSString stringWithFormat:@"¥%0.1f",self.allPirce - self.yhMoney.floatValue];
    self.paymoney = self.allPirce - self.yhMoney.floatValue;
//    if (self.tagImgArr.tag == sender.view.tag - 10086 + 10010) {
//        [self.tagImg setImage:[UIImage imageNamed:@"lbspay_bg_custom_checkbox_on.png"]];
//    }
    
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
//        NSLog(@"选取了地址栏");
           }else{
//        NSLog(@"%ld",_tabelView.indexPathForSelectedRow.section );
    }
}


-(void)sendNewAddress:(NSString *)AddressStr andNumber:(NSString *)number andName:(NSString *)name andSex:(NSString *)sex andPhone:(NSString *)phone{
    self.name = name;
    self.address = AddressStr;
    self.phoneNumber = phone;
    self.ID = AddressStr;
}

-(void)sendNewAddressAtIndex:(NSInteger )index{
    [self loadAddressAtIndex:index];
}

- (void)loadAddressAtIndex:(NSInteger )index{    
    AFNetworkTwoPackaging *twoPacking = [[AFNetworkTwoPackaging alloc] init];
    [twoPacking getUrl:[NSString stringWithFormat:ADDRESSLIST,[StoreageMessage getMessage][2],(long)1,(long)5] andFinishBlock:^(id getResult) {
        if ([getResult[@"code"] isEqualToString:@"000001"]) {
        }else{
            if ([getResult[@"datas"] count] == 0) {
                self.address = @"请输入地址";
                self.phoneNumber = [NSString stringWithFormat:@""];
                self.name = @"";
                self.ID = @"";
            }
            NSDictionary *dic = getResult[@"datas"][index];
                self.address = dic[@"name"];
                self.phoneNumber = [NSString stringWithFormat:@"%@-%@",dic[@"xqName"],dic[@"address"]];
                self.name = dic[@"phone"];
                self.ID = dic[@"ID"];
        }
                [self.tabelView reloadData];
        
    }];
}


//-(void)changeString1:(NSString *)string{
//    NSLog(@"%@",string);
//}


-(void)changeString:(NSString *)string{
//    NSLog(@"%@",string);
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
