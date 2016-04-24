//
//  OrderDeatilViewController.m
//  360du
//
//  Created by linghang on 15/8/6.
//  Copyright (c) 2015年 wangjian. All rights reserved.
//

#import "OrderDeatilViewController.h"
#import "AFNetworkTwoPackaging.h"
#import "OrderStatusModel.h"
#import "OrderDeatilModel.h"
#import "OrderStatusView.h"
#import "AFNetworking.h"
#import "UIView+Toast.h"
#import "OrderAddEvaluteViewController.h"
#import "AlipayViewController.h"
#import "OrderDeatilView.h"
#import "FoodBussinessListCollectionViewController.h"
@interface OrderDeatilViewController ()<UIActionSheetDelegate,UIGestureRecognizerDelegate>{
    AFHTTPRequestOperationManager *_rom;
}
@property(nonatomic,copy)NSString *orderId;
@property(nonatomic,copy)NSString *navTitle;
@property(nonatomic,copy)NSMutableArray *dataArr;
@property(nonatomic,strong)UILabel *statusBtnLab;
@property(nonatomic,strong)NSMutableArray *statueArr;
@property(nonatomic,strong)NSMutableArray *detailArr;
@property(nonatomic,strong)UITableView *detailTabView;
@property(nonatomic,strong)UITableView *statueTabview;
@property(nonatomic,strong)OrderStatusView *orderStateView;
@property(nonatomic,strong)OrderDeatilView *orderDetailView;
@property(nonatomic,assign)NSInteger panInt;

@end

@implementation OrderDeatilViewController
-(id)initWithOrderId:(NSString *)orderId andNavTitle:(NSString *)navTitle{
    self = [super init];
    if (self) {
        self.navTitle = navTitle;
        self.orderId = orderId;
        self.dataArr = [NSMutableArray arrayWithCapacity:0];
        self.statueArr = [NSMutableArray arrayWithCapacity:0];
        self.detailArr = [NSMutableArray arrayWithCapacity:0];
        self.panInt = 0;
        [self loadData];
        //[self requetOrderDeatil];
        [self makeUI];
        [self makeNav];
        [self makeHUd];

    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
}
-(void)loadData{
   __block NSInteger i = 0;
    //订单状态
    __block NSMutableArray *statusArr = [NSMutableArray arrayWithCapacity:0];
    //订单详情
    __block NSMutableArray *deatilArr = [NSMutableArray arrayWithCapacity:0];
    __unsafe_unretained typeof(self) vc = self;
    
    NSString *statusUrl = [NSString stringWithFormat:ORDERSTATUSSTATUS,self.orderId];
    //NSString *deatilUrl = [NSString stringWithFormat:ORDERDETAILDETAIL,self.orderId];
    _rom = [AFHTTPRequestOperationManager manager];
    _rom.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/json",@"text/html",@"application/json",@"text/plain",nil];
    //NSString *url = [NSString stringWithFormat:STUDY_CATEGORY_ITEM,self.categoryId,22];
    [_rom GET:statusUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [vc hudWasHidden:self.hudProgress];
        for (id temp in responseObject[@"infos"]) {
            OrderStatusModel *model = [[OrderStatusModel alloc] initWithDictionary:temp];
            [statusArr addObject:model];
        }
        [vc.statueArr addObjectsFromArray:statusArr];
        //if (![self.stateName isEqualToString:@"交易完成"]) {
            [self createOrderStateView];

        //}
       
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //[[NSURLCache sharedURLCache] removeAllCachedResponses];
        [vc hudWasHidden:self.hudProgress];

        NSLog(@"%@",[error description]);
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"警告" message:@"网络不流畅，请换个网络试试" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
        [alertView show];
        return ;
    }];
}
- (void)requetOrderDeatil{
    NSString *deatilUrl = [NSString stringWithFormat:ORDERDETAILDETAIL,self.orderId];
    AFNetworkTwoPackaging *twoPack = [[AFNetworkTwoPackaging alloc] init];
        [twoPack getUrl:deatilUrl andFinishBlock:^(id getResult) {
    #warning message
            NSLog(@"%@",getResult[@"items"]);
            [self hudWasHidden:self.hudProgress];
            NSMutableArray *detialArr = [NSMutableArray arrayWithCapacity:0];
            OrderDeatilModel *model = [[OrderDeatilModel alloc] initWithDictionary:getResult];
            [self.detailArr addObject:model];
            for (id temp in getResult[@"items"]) {
                OrderDeatilItemModel *model = [[OrderDeatilItemModel alloc] initWithDictionary:temp];
                [detialArr addObject:model];
            }
            [self.detailArr addObject:detialArr];
            [self createOrderDetailView:self.detailArr];
        }];

}
-(void)makeNav{
    [self setNavBarImage:@"landi.png"];
    //[self setBackgroud:@"lantiao x.png"];
    [self setBackImageStateName:@"fanhuijian02.png" AndHighlightedName:@""];
    
    [self setNavTitleItemWithName:self.navTitle];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    // Do any additional setup after loading the view.
}
//
-(void)makeUI{
    //[self makeUI];
    [self makeTwoBtn];
}
//两个btn
-(void)makeTwoBtn{
    NSArray *statusArr = @[@"订单状态",@"订单详情"];
    CGFloat width = WIDTH_CONTROLLER / statusArr.count;
    for (NSInteger i = 0; i < statusArr.count; i++) {
        UIButton *statusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        statusBtn.frame = CGRectMake(width * i, 64, width - 0.5 * self.numSingleVesion, 40 * self.numSingleVesion);
        [statusBtn setTitle:statusArr[i] forState:UIControlStateNormal];
        statusBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        statusBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [statusBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [statusBtn addTarget:self action:@selector(statusBtnDown:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:statusBtn];
        statusBtn.tag = 1200 + i;
        if (i == 1) {
            UILabel *verticalLine = [[UILabel alloc] initWithFrame:CGRectMake(width - 0.5 * self.numSingleVesion, 64, 1 * self.numSingleVesion, 40 * self.numSingleVesion)];
            verticalLine.backgroundColor = [UIColor lightGrayColor];
            [self.view addSubview:verticalLine];
        }
    }
    UILabel *bottomLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 64 + 39 * self.numSingleVesion, WIDTH_CONTROLLER, 1 * self.numSingleVesion)];
    bottomLab.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:bottomLab];
    //按钮下边的颜色
    self.statusBtnLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 64 + 39 * self.numSingleVesion, width, 1 * self.numSingleVesion)];
    self.statusBtnLab.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.statusBtnLab];
    
    UIPanGestureRecognizer *swipGes = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(swipGesture:)];
    swipGes.delegate = self;
    [self.view addGestureRecognizer:swipGes];
    
}
-(void)statusBtnDown:(UIButton *)statusBtn{
    if (statusBtn.tag == 1200) {
        self.statusBtnLab.frame = CGRectMake(0, 64 + 39 * self.numSingleVesion, WIDTH_CONTROLLER / 2, 1 * self.numSingleVesion);
    }else{
        self.statusBtnLab.frame = CGRectMake(WIDTH_CONTROLLER / 2, 64 + 39 * self.numSingleVesion, WIDTH_CONTROLLER / 2, 1 * self.numSingleVesion);
    }
    [self executeCreateDetailViewOrStateView:statusBtn.tag - 1200];
}
//根据不同tag值进行不同操作
- (void)executeCreateDetailViewOrStateView:(NSInteger)tag{
    [self removeStateOrDeatilView:self.orderStateView];
    [self removeStateOrDeatilView:self.orderDetailView];
    //0,状态View，1，详情
    if (tag == 0) {
        if (self.statueArr.count == 0) {
            [self loadData];
        }else{
            [self createOrderStateView];
        }
    }else{
        if (self.detailArr.count == 0) {
            [self makeHUd];
            [self requetOrderDeatil];
        }else{
            [self createOrderDetailView:self.detailArr];
            
        }
    }
}
//做uiscrollview
-(void)makeScrollView{
    
}
- (void)makeTable{
}
//创建订单状态View
- (void)createOrderStateView{
    self.orderStateView = [[OrderStatusView alloc] initWithFrame:CGRectMake(0, 64 + 40 * self.numSingleVesion, WIDTH_CONTROLLER, HEIGHT_CONTROLLER - 60 - 40 * self.numSingleVesion) andArr:self.statueArr andStatue:self.stateName andOrderId:self.orderId];
    self.orderStateView.target = self;
    [self.view addSubview:self.orderStateView];
//    UISwipeGestureRecognizer *swipGes = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipGesture:)];
//    swipGes.delegate = self;
//    [self.orderStateView addGestureRecognizer:swipGes];
}

////移除订单状态的View
//- (void)removeOrderStateView{
//    [self.orderStateView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
//    [self.orderStateView removeFromSuperview];
//    self.orderStateView = nil;
//}
//返回订单状态，点击的按钮
- (void)returnOrderStatueView:(NSString *)statue{
    if ([statue isEqual:@"去评价"]) {
        OrderAddEvaluteViewController *addEvalute = [[OrderAddEvaluteViewController alloc] initWithMerchantId:self.merchantId andStarCount:self.starCount];
        addEvalute.orderId = self.orderId;
        [self.navigationController pushViewController:addEvalute animated:YES];
    }else if ([statue isEqual:@"立即支付"]){
        [self createActionSheet];
    }else if([statue isEqual:@"取消订单"]){
        [self makeHUd];
        AFNetworkTwoPackaging *twoPack = [[AFNetworkTwoPackaging alloc] init];
        NSString *url = [NSString stringWithFormat:ORDERCANCEL,self.orderId];
        [twoPack getUrl:url andFinishBlock:^(id getResult) {
            [self hudWasHidden:self.hudProgress];
            if ([getResult isEqual:@"ok"]) {
                [self.navigationController popViewControllerAnimated:YES];
            }else if([getResult isEqual:@"no"]){
                [self.view makeToast:@"取消失败,请重新取消"];
            }else{
                [self.view makeToast:@"是已经取消过了，不能重复取消"];
            }
        }];
    }
}
- (void)createActionSheet{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"请选择支付方式" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"支付宝",@"微信", nil];
    sheet.delegate = self;
    [sheet showInView:self.view];
    
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    //0，为支付宝，1，为微信
    if (buttonIndex == 1) {
        [self.view makeToast:@"暂时不支持微信支付，请选择支付宝支付"];
    }else{
        if (self.finalPrice.integerValue == 0) {
            [self.view makeToast:@"购买成功,免支付"];
            return;
        }
        AlipayViewController *aliPay = [[AlipayViewController alloc] initPrice:[NSString stringWithFormat:@"%0.2f",self.finalPrice.floatValue] andDescMerchant:self.navTitle andTitle:self.navTitle andMerOrder:self.orderId];
        [self.navigationController pushViewController:aliPay animated:YES];
    }
}
#pragma mark 下边是订单详情
- (void)createOrderDetailView:(NSArray *)dataArr{
    self.orderDetailView = [[OrderDeatilView alloc] initWithFrame:CGRectMake(0, 64 + 40 * self.numSingleVesion, WIDTH_CONTROLLER, HEIGHT_CONTROLLER - 64 - 40 * self.numSingleVesion) andShopName:self.navTitle andPersonal:self.personalName andDeatilArr:dataArr];
    self.orderDetailView.target = self;
    [self.view addSubview:self.orderDetailView];
//    UISwipeGestureRecognizer *swipGes = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipGesture:)];
//    swipGes.delegate = self;
//    [self.orderDetailView addGestureRecognizer:swipGes];
}
#warning message 没有加配送费
//订单详情再来一单
- (void)comeAgainOrder{
    OrderDeatilModel *model = self.detailArr[0];
    FoodBussinessListCollectionViewController *merchant = [[FoodBussinessListCollectionViewController alloc] initWithId:self.merchantId andSendPrice:model.sendFee andDistributionPrice:@"0"];
    merchant.shopName = self.navTitle;
    merchant.shopDesc = self.navTitle;
    [self.navigationController pushViewController:merchant animated:YES];
}
#pragma mark 移除两个View的其中一个
- (void)removeStateOrDeatilView:(UIView *)view{
    [view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [view removeFromSuperview];
    view = nil;
}
#pragma makr 手势
- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer{
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        CGPoint point = CGPointMake(0, 0);
            point = [(UIPanGestureRecognizer *)gestureRecognizer translationInView:self.view];
//        }else{
//           point = [(UIPanGestureRecognizer *)gestureRecognizer translationInView:self.orderStateView];
//        }
        if ((fabs(point.y) / fabs(point.x)) < 1) {
            return YES;
        }
    }
    return NO;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer

{
    
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        
        // Find the current vertical scrolling velocity
        
        CGFloat velocity = [(UIPanGestureRecognizer *)gestureRecognizer velocityInView:gestureRecognizer.view].y;
        
        // Return YES if no scrolling up
        
        return fabs(velocity) <= 0.2;
        
    }
    
    return YES;
    
}
- (void)swipGesture:(UIPanGestureRecognizer *)swipGesture{
        NSLog(@"拖动");
    CGPoint point = CGPointMake(0, 0);
    point = [(UIPanGestureRecognizer *)swipGesture translationInView:self.view];
    NSLog(@"pointX:%lf",point.x);

    if((NSInteger)point.x < self.panInt){
        [self executeCreateDetailViewOrStateView:1];

    }else if((NSInteger)point.x > self.panInt){
        [self executeCreateDetailViewOrStateView:0];
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
