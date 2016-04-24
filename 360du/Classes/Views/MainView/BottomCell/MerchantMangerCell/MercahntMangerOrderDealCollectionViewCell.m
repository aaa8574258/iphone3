//
//  MercahntMangerOrderDealCollectionViewCell.m
//  360du
//
//  Created by linghang on 15/12/12.
//  Copyright © 2015年 wangjian. All rights reserved.
//

#import "MercahntMangerOrderDealCollectionViewCell.h"
#import "MerchantMangerOrderDealTableViewCell.h"
#import "MerchantOrderDetailModel.h"
#import "AFNetworkTwoPackaging.h"
#import "StoreageMessage.h"
#import "UIView+Toast.h"
#import "MBProgressHUD.h"
#import "MerchantViewController.h"
#import "MJRefresh.h"
#import "UIScrollView+MJRefresh.h"
#import "MJRefreshHeaderView.h"
#import "MJRefreshBaseView.h"
#define MERCHANTMANGERORDERDEALTABLEVIEWCELL @"merchantMangerOrderDealTableviewCell"
@interface MercahntMangerOrderDealCollectionViewCell()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,MBProgressHUDDelegate>
@property(nonatomic,weak)UITableView *tableView;
@property(nonatomic,assign)CGFloat numSingleVesion;
@property(nonatomic,strong)NSArray *dataArr;
@property(nonatomic,strong)NSMutableArray *stateArr;
@property(nonatomic,strong)MBProgressHUD *hudProgress;
@property(nonatomic,strong)NSMutableArray *devilerArr;
@property(nonatomic,weak)MerchantOrderDetailModel *devilerModel;
@property(nonatomic,assign)NSInteger clickNum;
@end

@implementation MercahntMangerOrderDealCollectionViewCell
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {

        self.numSingleVesion = [VersionTranlate returnVersionRateAnyIphone:1];
        self.stateArr  = [NSMutableArray arrayWithCapacity:0];
        [self makeUI];
    }return self;
}
- (void)setTempClickNum:(NSString *)tempClickNum{
    self.clickNum = tempClickNum.integerValue;
}
- (void)setTempArr:(NSArray *)tempArr{
    self.dataArr = tempArr;
    [self.tableView reloadData];
}
-(void)makeUI{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTENTVIEW, HEIGHT_CONTENTVIEW - 64 - 49 * self.numSingleVesion) style:UITableViewStyleGrouped];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.separatorStyle = NO;
    [self.contentView addSubview:tableView];
    tableView.showsVerticalScrollIndicator = NO;
    tableView.backgroundColor = [UIColor whiteColor];
    //[tableView registerClass:[MinePrivilegeTabCell class] forCellReuseIdentifier:MINEPRIVILAGETABCELL];
    //[tableView registerClass:[StudyDetailTableViewCell class] forCellReuseIdentifier:STUDYD_EATILTABVIEWCELL];
    self.tableView = tableView;
    [self.tableView addFooterWithTarget:self action:@selector(addFooter)];
    self.tableView.footerPullToRefreshText = @"上拉可以加载更多数据了";
    self.tableView.footerReleaseToRefreshText = @"松开马上加载更多数据";
    self.tableView.footerRefreshingText = @"正在加载，请稍后";
    [self.tableView addHeaderWithTarget:self action:@selector(addHeader)];
    self.tableView.headerRefreshingText = @"正在帮你刷新";}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if([(NSArray *)self.dataArr[0] count] == 0)
        return 0;
    return 4;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 70 * self.numSingleVesion;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (self.clickNum == 0) {
        MerchantOrderDetailModel *model = self.dataArr[0][section];
        
        if ([model.statusName isEqual:@"未确认"] || [model.statusName isEqual:@"确认"]) {
            if (section == [(NSArray *)self.dataArr[0] count] - 1) {
                return 90 * self.numSingleVesion;
            }
            return 50 * self.numSingleVesion;
        }
        return 0;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  [self returnEverRowHeightRow:indexPath.row andSection:indexPath.section];

//    if (self.clickNum == 0) {
//       return  [self returnEverRowHeightRow:indexPath.row andSection:indexPath.section];
//    }
//    return 150 * self.numSingleVesion;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTENTVIEW, 70 * self.numSingleVesion)];
   view.backgroundColor = SMSColor(246, 246, 246);
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, WIDTH_VIEW, 1 * self.numSingleVesion)];
    line.backgroundColor = SMSColor(211, 211, 211);
    [view addSubview:line];
    MerchantOrderDetailModel *model = self.dataArr[0][section];
    //左边序列号
    UILabel *serialNum = [[UILabel alloc] initWithFrame:CGRectZero];
    serialNum.text = model.number;
    serialNum.textColor = SMSColor(231, 64, 64);
    serialNum.font = [UIFont systemFontOfSize:18];
    [serialNum sizeToFit];
    serialNum.center = CGPointMake(5 * self.numSingleVesion + serialNum.frame.size.width / 2, 35 * self.numSingleVesion);
    [view addSubview:serialNum];
    //号
    UILabel *markLab = [[UILabel alloc] initWithFrame:CGRectZero];
    markLab.text = @"号";
    markLab.textColor = SMSColor(231, 64, 64);
    markLab.font = [UIFont systemFontOfSize:22];
    [markLab sizeToFit];
    markLab.center = CGPointMake(5 * self.numSingleVesion + serialNum.frame.size.width  + markLab.frame.size.width / 2, 35 * self.numSingleVesion);
    [view addSubview:markLab];

//    215,60,59
    //订单状态
    UILabel *orderLab = [[UILabel alloc] initWithFrame:CGRectMake(serialNum.frame.size.width + 20 * self.numSingleVesion + markLab.frame.size.width, 15 * self.numSingleVesion, WIDTH_CONTENTVIEW - (serialNum.frame.size.width + 20 * self.numSingleVesion), 15 * self.numSingleVesion)];
    orderLab.textColor = SMSColor(215, 60, 59);
    orderLab.font = [UIFont systemFontOfSize:15];
    orderLab.text = [NSString stringWithFormat:@"订单状态:%@",model.statusName];
    [view addSubview:orderLab];
    //下单时间
    UILabel *timeLab = [[UILabel alloc] initWithFrame:CGRectMake(serialNum.frame.size.width + 20 * self.numSingleVesion + markLab.frame.size.width, 45 * self.numSingleVesion, WIDTH_CONTENTVIEW - (serialNum.frame.size.width + 20 * self.numSingleVesion), 15 * self.numSingleVesion)];
    timeLab.textColor = SMSColor(215, 60, 59);
    timeLab.font = [UIFont systemFontOfSize:15];
    timeLab.text = [NSString stringWithFormat:@"下单时间:%@",model.orderTime];
    [view addSubview:timeLab];
    UILabel *lineLast = [[UILabel alloc] initWithFrame:CGRectMake(0, 67 * self.numSingleVesion, WIDTH_VIEW, 3 * self.numSingleVesion)];
    lineLast.backgroundColor = SMSColor(221, 221, 221);
    [view addSubview:lineLast];

    return view;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [(NSArray *)self.dataArr[0] count];
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (self.clickNum == 0) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTENTVIEW, 50 * self.numSingleVesion)];
        //view.backgroundColor = [UIColor blueColor];
        MerchantOrderDetailModel *model = self.dataArr[0][section];
        NSLog(@"statusNmae:%@",model.statusName);
        if ([model.statusName isEqual:@"待配送"]) {
            return nil;
//            UIButton *tempBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//            tempBtn.frame = CGRectMake((WIDTH_CONTENTVIEW - 80 * self.numSingleVesion) / 2, 5 * self.numSingleVesion, 80 * self.numSingleVesion, 40 * self.numSingleVesion);
//            tempBtn.tag = 1500 + section;
//            [tempBtn addTarget:self action:@selector(sectionBtnDown:) forControlEvents:UIControlEventTouchUpInside];
//            [tempBtn setTitle:@"待配送" forState:UIControlStateNormal];
//            [tempBtn setBackgroundColor:SMSColor(215, 60, 59)];
//            [view addSubview:tempBtn];
//            [tempBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }else if ([model.statusName isEqual:@"未确认"]){
            for (NSInteger i = 0; i < 2; i++) {
                UIButton *tempBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                tempBtn.frame = CGRectMake((WIDTH_CONTENTVIEW / 2 - 10 * self.numSingleVesion - 80 * self.numSingleVesion) + 90 * self.numSingleVesion * i, 5 * self.numSingleVesion, 80 *self.numSingleVesion, 40 * self.numSingleVesion);
                [tempBtn addTarget:self action:@selector(sectionBtnDown:) forControlEvents:UIControlEventTouchUpInside];
                tempBtn.tag = 1600 + i + 10 * section;
                [tempBtn addTarget:self action:@selector(sectionBtnDown:) forControlEvents:UIControlEventTouchUpInside];
                if (i == 0) {
                    [tempBtn setTitle:@"取消订单" forState:UIControlStateNormal];

                }else{
                    [tempBtn setTitle:@"确认订单" forState:UIControlStateNormal];

                }
                [tempBtn setBackgroundColor:SMSColor(215, 60, 59)];
                [view addSubview:tempBtn];
                [tempBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            }
        }else if ([model.statusName isEqual:@"确认"]){
            //配送订单
            UIButton *tempBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            tempBtn.frame = CGRectMake((WIDTH_CONTENTVIEW - 80 * self.numSingleVesion) / 2, 5 * self.numSingleVesion, 80 * self.numSingleVesion, 40 * self.numSingleVesion);
            tempBtn.tag = 1600 + 10 * section;
            [tempBtn addTarget:self action:@selector(sectionBtnDown:) forControlEvents:UIControlEventTouchUpInside];
            [tempBtn setTitle:@"配送订单" forState:UIControlStateNormal];
            [tempBtn setBackgroundColor:SMSColor(215, 60, 59)];
            [view addSubview:tempBtn];
            [tempBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

        }else{
            view.backgroundColor = SMSColor(246, 246, 246);

            return view;
        }
        return view;

    }
    
        UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
        view.backgroundColor = SMSColor(246, 246, 246);

    
    return view;
}
- (void)sectionBtnDown:(UIButton *)sectionBtn{
    NSInteger temp =  sectionBtn.tag - 1600;
    NSInteger tempSec = temp / 10;//一共有几段
    MerchantOrderDetailModel *model = self.dataArr[0][tempSec];
    self.devilerModel = model;
    AFNetworkTwoPackaging *twoPack = [[AFNetworkTwoPackaging alloc] init];
    NSString *url = nil;
    NSInteger btnInt = 0;
    if([sectionBtn.currentTitle isEqual:@"配送订单"]){//配送方式
        url = [NSString stringWithFormat:DELIVERYLISTORDERMERCHANT,[StoreageMessage gainMerchantUserNameAndPasswordAndMemerId][2],model.orderId];
        

    }
    else if ([sectionBtn.currentTitle isEqual:@"确认订单"]){
        url = [NSString stringWithFormat:CONFIRMORDERMERCHANT,model.orderId];
        btnInt = 1;

    }else if ([sectionBtn.currentTitle isEqual:@"取消订单"]){
        url = [NSString stringWithFormat:CANCELORDERMERCAHNT,model.orderId];
        btnInt = 2;
    }
    [self makeHUd];
    [twoPack getUrl:url andFinishBlock:^(id getResult) {
        [self hudWasHidden:self.hudProgress];

        switch (btnInt) {
            case 0:{
          
                    if ([getResult[@"code"] isEqual:@"000001"]) {
                        [self.contentView makeToast:getResult[@"message"]];
                        return ;

                    }else{
                        NSMutableArray *dataArr = [NSMutableArray arrayWithCapacity:0];
                        for (id temp in getResult[@"datas"]) {
                            [dataArr addObject:temp];
                        }
                        self.devilerArr = [dataArr copy];
                        [self deliveryOrder:dataArr];
 
                    }
                break;
            }
            case 1:{
                if([getResult[@"code"] isEqual:@"000000"]){
                    [self devilerModel:model andName:@"确认"];
                }
                [self.contentView makeToast:getResult[@"message"]];
                break;
            }

            case 2:{
                
                if([getResult[@"code"] isEqual:@"000000"]){
                    [self devilerModel:model andName:@"取消"];
                }
                [self.contentView makeToast:getResult[@"message"]];
                break;
            }

            default:
                break;
        }
    }];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //StudyDetailTableViewCell *cell = nil;
    MerchantMangerOrderDealTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MERCHANTMANGERORDERDEALTABLEVIEWCELL];
    if (!cell) {
        cell = [[MerchantMangerOrderDealTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MERCHANTMANGERORDERDEALTABLEVIEWCELL];
    }
    [cell.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [cell init];
    cell.detailModel = self.dataArr[0][indexPath.section];
    cell.clickNum = indexPath.row;
    if(indexPath.row == 0){
        cell.backgroundColor = SMSColor(246, 246, 246);
    }else if (indexPath.row == 1){
        cell.backgroundColor = SMSColor(255, 255, 255);
    }else{
        cell.backgroundColor = SMSColor(246, 246, 246);
 
    }
//    cell.model = self.tempArr[indexPath.row];
//    cell.userStatus = self.userStatustep;
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (self.num == 0) {
//        MinePrivilageModel *model = self.tempArr[indexPath.row];
//        if ([self.target isKindOfClass:[MinePrivilageViewController class]]) {
//            [self.target returnPrivilageModel:model];
//        }
//    }
}
//计算每一行的高度
- (CGFloat)returnEverRowHeightRow:(NSInteger)row andSection:(NSInteger)section{
    CGFloat height = 0;
    switch (row) {
        case 0:{
            height = 85 * self.numSingleVesion;
            break;
        }
        case 1:{
            MerchantOrderDetailModel *model = self.dataArr[0][section];
            height =  model.goodsInfo.count * 30 * self.numSingleVesion;
            break;
        }
        case 2:{
            height = 50 * self.numSingleVesion;
            break;
        }case 3:{
            height = 30 * self.numSingleVesion;
            break;
        }
        default:
            break;
    }
    return height;
}
#pragma mark 订单处理
//配送方式选取
- (void)deliveryOrder:(NSArray *)deliverArr{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"配送方式" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:nil, nil];
    for (NSInteger i = 0; i < deliverArr.count; i++) {
        NSDictionary *dict = deliverArr[i];
        [actionSheet addButtonWithTitle:dict[@"sendName"]];
    }
    [actionSheet showInView:self.contentView];

}
#pragma mark actionSheet的代理
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"buttonIndex:%ld",buttonIndex);
    NSDictionary *dict = self.devilerArr[buttonIndex - 1];
    NSString *url = [NSString stringWithFormat:DELIVEETORDERMERCHANT,self.devilerModel.orderId,dict[@"sendValue"]];
    [self makeHUd];
    AFNetworkTwoPackaging *twoPack = [[AFNetworkTwoPackaging alloc] init];
    [twoPack getUrl:url andFinishBlock:^(id getResult) {
        if ([getResult[@"code"] isEqual:@"000000"]) {
            //重新请求数据
            [self devilerModel:self.devilerModel andName:dict[@"sendName"]];
        }
        [self.contentView makeToast:getResult[@"message"]];

    }];
    
}
#pragma mark 修改数组数据
- (void)devilerModel:(MerchantOrderDetailModel*)model andName:(NSString *)name{
    NSMutableArray *tempArr = [NSMutableArray arrayWithCapacity:0];
    
    for (MerchantOrderDetailModel *temp in self.dataArr[0]) {
        if ([temp.orderId isEqual:model.orderId] && ![name isEqual:@"取消"]) {
            temp.statusName = name;
        }
        if(![name isEqual:@"取消"]){
            [tempArr addObject:temp];
        }
    }
    
    self.dataArr = @[tempArr, (NSArray *)self.dataArr[1]];
    [self.tableView reloadData];
    if ([self.target isKindOfClass:[MerchantViewController class]]) {
        [self.target returnData:self.dataArr andPage:self.page andClickNum:self.clickNum];
    }
}
#pragma mark laodData
//下拉刷新
//加载更多
- (void)addHeader{
    __unsafe_unretained typeof(self) vc = self;
    [vc.tableView addHeaderWithCallback:^{
        vc.page = 1;
        AFNetworkTwoPackaging *twoPackaging = [[AFNetworkTwoPackaging alloc] init];
        //    "serviceServlet?serviceName=dlshopmag&medthodName=dlshoplist&codename=%@&xqid=%d&sort=%d&gotoPage=%d&pageSize=%d"
        NSString *url = [NSString stringWithFormat:MERCHANTORDERDEAL, [StoreageMessage gainMerchantUserNameAndPasswordAndMemerId][2],[NSString stringWithFormat:@"%ld",vc.clickNum]
                         ,vc.page];
        //url = @"http://211.152.8.99/360duang/serviceServlet?serviceName=dlshopmag&medthodName=dlshoplist&codename=2&xqid=86420010000004&sort=1&gotoPage=1&pageSize=5";
        [twoPackaging getUrl:url andFinishBlock:^(id getResult) {
            [vc.tableView headerEndRefreshing];
            
            //先清空，后者刷新
            if ([getResult[@"code"] isEqual:@"000000"] ) {
                if ([(NSArray *)getResult[@"datas"] count] == 0) {
                    return ;
                }
                NSMutableArray *tempArr = [NSMutableArray arrayWithCapacity:0];
                NSMutableArray *itemArr = [NSMutableArray arrayWithCapacity:0];
                for (NSDictionary *temp in getResult[@"datas"]) {
                    MerchantOrderDetailModel *model = [[MerchantOrderDetailModel alloc] initWithDictionary:temp];
                    [tempArr addObject:model];
                    NSMutableArray *goodsArr = [NSMutableArray arrayWithCapacity:0];
                    for (NSDictionary *itemTemp in temp[@"goodsInfo"]) {
                        MerchantOrderDetailGoodsInfoModel *infoModel = [[MerchantOrderDetailGoodsInfoModel alloc] initWithDictionary:itemTemp];
                        [goodsArr addObject:infoModel];
                    }
                    [itemArr addObject:goodsArr];
                }
                vc.dataArr = @[tempArr,itemArr];
                [vc.tableView reloadData];
                if ([vc.target isKindOfClass:[MerchantViewController class]]) {
                    [vc.target returnData:vc.dataArr andPage:vc.page andClickNum:vc.clickNum];
                }

            }else{
                [vc.contentView makeToast:getResult[@"message"]];
            }

            
        }];
    }];
}
//上拉加载更多
- (void)addFooter
{
    
    self.page++;
    __unsafe_unretained typeof(self) vc = self;
    // 添加上拉刷新尾部控
        
        
    AFNetworkTwoPackaging *twoPack = [[AFNetworkTwoPackaging alloc] init];
    // 订单状态：0未完成；1已完成；2已取消
    [twoPack getUrl:[NSString stringWithFormat:MERCHANTORDERDEAL, [StoreageMessage gainMerchantUserNameAndPasswordAndMemerId][2],[NSString stringWithFormat:@"%ld",self.clickNum]
,self.page] andFinishBlock:^(id getResult) {
        [vc.tableView footerEndRefreshing];

        if ([getResult[@"code"] isEqual:@"000000"] ) {
            if ([(NSArray *)getResult[@"datas"] count] == 0) {
                return ;
            }
            
            NSMutableArray *tempArr = [NSMutableArray arrayWithCapacity:0];
            NSMutableArray *itemArr = [NSMutableArray arrayWithCapacity:0];
            [tempArr addObjectsFromArray:self.dataArr[0]];
            [itemArr addObjectsFromArray:self.dataArr[1]];
            for (NSDictionary *temp in getResult[@"datas"]) {
                MerchantOrderDetailModel *model = [[MerchantOrderDetailModel alloc] initWithDictionary:temp];
                [tempArr addObject:model];
                NSMutableArray *goodsArr = [NSMutableArray arrayWithCapacity:0];
                for (NSDictionary *itemTemp in temp[@"goodsInfo"]) {
                    MerchantOrderDetailGoodsInfoModel *infoModel = [[MerchantOrderDetailGoodsInfoModel alloc] initWithDictionary:itemTemp];
                    [goodsArr addObject:infoModel];
                }
                [itemArr addObject:goodsArr];
            }
            vc.dataArr = @[tempArr,itemArr];
            [vc.tableView reloadData];
            if ([vc.target isKindOfClass:[MerchantViewController class]]) {
                [vc.target returnData:vc.dataArr andPage:vc.page andClickNum:vc.clickNum];
            }

        }else{
            [vc.contentView makeToast:getResult[@"message"]];
        }
    }];
}

#pragma mark hud的代理
//加载图片
-(void)makeHUd{
    self.hudProgress = [[MBProgressHUD alloc] initWithView:self.contentView];
    self.hudProgress.delegate = self;
    //self.hudProgress.color = [UIColor clearColor];
    self.hudProgress.labelText = @"loading";
    self.hudProgress.dimBackground = YES;
    //self.hudProgress.margin = 80.f;
    //self.hudProgress.yOffset = 150.f;
    [self.contentView addSubview:self.hudProgress];
    [self.hudProgress showWhileExecuting:@selector(myProgressTask) onTarget:self withObject:nil animated:YES];
}

#pragma mark HUD的代理方法,关闭HUD时执行
-(void)hudWasHidden:(MBProgressHUD *)hud
{
    [hud removeFromSuperview];
    hud = nil;
}
-(void) myProgressTask{
    float progress = 0.0f;
    while (progress < 1.0f) {
        progress += 0.01f;
        self.hudProgress.progress = progress;
        usleep(50000);
    }
    
}

@end
