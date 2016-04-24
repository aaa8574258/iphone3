//
//  MerchantViewController.m
//  360du
//
//  Created by linghang on 15/12/12.
//  Copyright © 2015年 wangjian. All rights reserved.
//

#import "MerchantViewController.h"
#import "MainBottomView.h"
#import "UIView+Toast.h"
#import "StoreageMessage.h"
#import "MerchantOrderDetailModel.h"
#import "MercahntMangerOrderDealCollectionViewCell.h"
#import "MerchantSystemSettingViewController.h"
#define MERCHANTMANGERCELL @"merchantMangerCell"
@interface MerchantViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong)UILabel *statusBtnLab;
@property(nonatomic,weak)UICollectionView *collectionView;
@property(nonatomic,strong)NSMutableArray *collectionArr;
@property(nonatomic,assign)NSInteger page;
@property(nonatomic,assign)NSInteger page1;
@property(nonatomic,assign)NSInteger page2;

@end

@implementation MerchantViewController
- (id)init{
    self = [super init];
    if (self) {
        [self makeInit];
        [self loadData];
        [self makeUI];
        [self makeNav];
        [self makeHUd];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    // Do any additional setup after loading the view.
}
- (void)makeBottom{
    NSArray *imgArr = @[@"order_deal_n.png",@"order_find_n.png",@"order_manager_n.png",@"设置灰.png"];
    NSArray *lightArr = @[@"order_deal_p.png",@"order_find_p.png",@"order_manager_p.png",@"设置红.png"];
    NSArray *titleArr = @[@"订单处理",@"订单查询",@"门店管理",@"设置"];
    
    MainBottomView *bottomView = [[MainBottomView alloc] initWithFrame:CGRectMake(0, HEIGHT_CONTROLLER - 49 * self.numSingleVesion, WIDTH_CONTROLLER, 49 * self.numSingleVesion) andImgArr:imgArr andTitleArr:titleArr andBgImg:@"" andHeilightImg:lightArr];
    bottomView.target = self;
    bottomView.backgroundColor = SMSColor(55, 50, 51);
    //bottomView.userInteractionEnabled = NO;
    [self.view addSubview:bottomView];
}
//返回底部点击哪一个
-(void)returnBottomTag:(NSInteger)numbottomBtn{
   
    BaseViewController *ctrl = nil;
    switch (numbottomBtn) {
        case 0:{
            [self.view makeToast:@"正在开发,敬请期待!"];
            //            LogInViewController *logIn = [[LogInViewController alloc] init];
            //            [self.navigationController pushViewController:logIn animated:YES];
           // ctrl = [[MenberViewController alloc] init];
            break;
        }
        case 1:{
            [self.view makeToast:@"正在开发,敬请期待!"];

           // ctrl = [[MenberOrderViewController alloc] init];
            break;
        }
        case 2:{
            [self.view makeToast:@"正在开发,敬请期待!"];

           // ctrl = [[MemberFavoriteViewController alloc] init];
            break;
        }
        case 3:{
            ctrl = [[MerchantSystemSettingViewController alloc] init];
            break;
        }
        default:
            break;
    }
    [self.navigationController pushViewController:ctrl animated:YES];
}
- (void)makeInit{
    self.page = 1;
    self.page1 = 1;
    self.page2 = 1;
    self.collectionArr = [NSMutableArray arrayWithCapacity:0];
    for (NSInteger i = 0; i < 4; i++) {
        [self.collectionArr addObject:@"0"];
    }
}
- (void)loadData{
    AFNetworkTwoPackaging *twoPack = [[AFNetworkTwoPackaging alloc] init];
    NSLog(@"url:%@",[NSString stringWithFormat:MERCHANTORDERDEAL, [StoreageMessage gainMerchantUserNameAndPasswordAndMemerId][2],@"0",self.page]);
    // 订单状态：0未完成；1已完成；2已取消
    [twoPack getUrl:[NSString stringWithFormat:MERCHANTORDERDEAL, [StoreageMessage gainMerchantUserNameAndPasswordAndMemerId][2],@"0",self.page] andFinishBlock:^(id getResult) {
        [self hudWasHidden:self.hudProgress];
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
            [self.collectionArr replaceObjectAtIndex:0 withObject:@[tempArr,itemArr]];
            [self.collectionView reloadData];
        }else{
            [self.view makeToast:getResult[@"message"]];
        }
    }];
}
-(void)makeNav{
    [self setNavBarImage:@"landi.png"];
    //[self setBackgroud:@"lantiao x.png"];
    [self setBackImageStateName:@"fanhuijian02.png" AndHighlightedName:@""];
    
    [self setNavTitleItemWithName:@"商家管理中心"];
}
-(void)makeUI{
    [self makeFourHeadBtn];
    [self makeCollectionView];
    [self makeBottom];
}
- (void)makeFourHeadBtn{
    NSArray *statusArr = @[@"未完成订单",@"已完成订单",@"已取消"];
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
        if (i != statusArr.count - 1) {
            UILabel *verticalLine = [[UILabel alloc] initWithFrame:CGRectMake(width - 0.5 * self.numSingleVesion + width * i, 64, 1 * self.numSingleVesion, 40 * self.numSingleVesion)];
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
    
}
-(void)statusBtnDown:(UIButton *)statusBtn{
    self.statusBtnLab.frame = CGRectMake(WIDTH_CONTROLLER / 3 * (statusBtn.tag - 1200), 64 + 39 * self.numSingleVesion, WIDTH_CONTROLLER / 3, 1 * self.numSingleVesion);
    if ([self.collectionArr[statusBtn.tag - 1200] isEqual:@"0"]) {
        [self requestData:statusBtn.tag - 1200];
    }
    self.collectionView.contentOffset = CGPointMake(WIDTH_CONTROLLER * (statusBtn.tag - 1200), 0);
    
}
-(void)makeCollectionView{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    layout.minimumLineSpacing = 0;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64 + 40 * self.numSingleVesion, WIDTH_CONTROLLER, HEIGHT_CONTROLLER - 64 - 40 * self.numSingleVesion - 50 * self.numSingleVesion) collectionViewLayout:layout];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    //    collectionView.contentSize = CGSizeMake(WIDTH_CONTROLLER * 3, HEIGHT_CONTROLLER - self.high - 49);
    collectionView.pagingEnabled = YES;
    collectionView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:collectionView];
#pragma mark 内存泄露
    collectionView.backgroundColor = [UIColor whiteColor];
    [collectionView registerClass:[MercahntMangerOrderDealCollectionViewCell class] forCellWithReuseIdentifier:MERCHANTMANGERCELL];
    self.collectionView = collectionView;
}
#pragma mark collectionView的代理
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.collectionArr.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    //判读一下等于0就不执行下边的方法
    if ([self.collectionArr[indexPath.row] isEqual:@"0"]) {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:MERCHANTMANGERCELL forIndexPath:indexPath];
        
        return cell;
    }
    MercahntMangerOrderDealCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:MERCHANTMANGERCELL forIndexPath:indexPath];
   // [cell initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER, HEIGHT_CONTROLLER - 64 - 49) andClickNum:indexPath.row];
    cell.target = self;
    if (indexPath.row == 0) {
        cell.page = self.page;
    }else if (indexPath.row == 1){
        cell.page = self.page1;
    }else if (indexPath.row == 2){
        cell.page = self.page2;
    }
   
    cell.tempClickNum = [NSString stringWithFormat:@"%ld",indexPath.row];
    cell.tempArr = self.collectionArr[indexPath.row];
    cell.target = self;
//    cell.userStatus = [NSString stringWithFormat:@"%ld",indexPath.row + 1];
    //cell.clickNum = indexPath.row;
    //cell.cellArr = self.collectionArr[indexPath.row];
    //cell.m
    
    return cell;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(WIDTH_CONTROLLER, HEIGHT_CONTROLLER - 64 - 40 * self.numSingleVesion - 49 * self.numSingleVesion);
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    UIEdgeInsets set = {0,0,0,0};
    return set;
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    float everWidth = WIDTH_CONTROLLER / 3;
    NSInteger num = scrollView.contentOffset.x / WIDTH_CONTROLLER;
    self.statusBtnLab.frame = CGRectMake(everWidth * num,64 + 39 * self.numSingleVesion, everWidth, 1 * self.numSingleVesion);
    //先清空view
    //[self reminderView];
    if ([self.collectionArr[num] isEqual:@"0"]) {
        [self requestData:num];
        //[self makeHUd];
    }
    
}
#pragma mark 请求数据
- (void)requestData:(NSInteger)num{
    [self makeHUd];
    NSInteger page = 0;
    if (num == 0) {
        page = self.page;
    }else if (num == 1){
        page = self.page1;
    }else if (num == 2){
        page = self.page2;
    }
    AFNetworkTwoPackaging *twoPack = [[AFNetworkTwoPackaging alloc] init];
    NSString *url = [NSString stringWithFormat:MERCHANTORDERDEAL, [StoreageMessage gainMerchantUserNameAndPasswordAndMemerId][2],[NSString stringWithFormat:@"%ld",num],page] ;
    // 订单状态：0未完成；1已完成；2已取消
    [twoPack getUrl:[NSString stringWithFormat:MERCHANTORDERDEAL, [StoreageMessage gainMerchantUserNameAndPasswordAndMemerId][2],[NSString stringWithFormat:@"%ld",num],page] andFinishBlock:^(id getResult) {
        [self hudWasHidden:self.hudProgress];
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
            [self.collectionArr replaceObjectAtIndex:num withObject:@[tempArr,itemArr]];
            [self.collectionView reloadData];
        }else{
            [self.view makeToast:getResult[@"message"]];
        }
    }];
}

//点击确认，配送方式，返回数据
//点击确认，配送方式，返回数据
- (void)returnData:(NSArray *)dataArr andPage:(NSInteger)page andClickNum:(NSInteger)clickNum{
    [self.collectionArr replaceObjectAtIndex:clickNum withObject:dataArr];
    switch (clickNum) {
        case 0:{
            self.page = page;
            break;
        }
        case 1:{
            self.page1 = page;
            break;
        }
        case 2:{
            self.page2 = page;
            break;
        }
        default:
            break;
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
