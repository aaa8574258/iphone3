//
//  FoodBussinessListCollectionViewController.m
//  360du
//
//  Created by linghang on 15/7/3.
//  Copyright (c) 2015年 wangjian. All rights reserved.
//

#import "FoodBussinessListCollectionViewController.h"
#import "FoodMerchatListModel.h"
#import "CommonBusinessListCollectionViewCell.h"
#import "MerchantDeatilModel.h"
#import "BuyFoodCarViewController.h"
#import "ShoppingCarViewController.h"
#import "ShoplistModel.h"
#import "NSString+URLEncoding.h"
#import "ShopListView.h"
#import "UIView+Toast.h"
#import "FoodMerchatListModel.h"
#import "StoreageMessage.h"
#import "FoodMerchantGoodsDeatilViewController.h"
#import "LogInViewController.h"
#define FOODLISTCOLLECTIONCELL @"foodListCollectionCell"
@interface FoodBussinessListCollectionViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,MBProgressHUDDelegate>
@property(nonatomic,copy)NSString *memchantId;
@property(nonatomic,weak)UICollectionView *collectionView;
@property(nonatomic,weak)UIScrollView *scrollView;
@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,strong)NSMutableArray *sectionArr;
@property(nonatomic,strong)MBProgressHUD *hudProgress;
@property(nonatomic,weak)UILabel *buyNumLable;//左边显示购买几个的数字
@property(nonatomic,weak)UILabel *priceLable;//左边显示价格
@property(nonatomic,weak)UILabel *selectLable;//右边显示选好了得价格
@property(nonatomic,strong)NSMutableArray *buyArr;//已经购买的东西
@property(nonatomic,assign)CGFloat priceAll;
@property(nonatomic,strong)NSMutableArray *shopPriceCountArr;//买的数量
@property(nonatomic,strong)ShopListView *listView;
@property(nonatomic,assign)BOOL carLiast;
@property(nonatomic,strong)NSMutableArray *rlidArr;//储存可选规格的购物车
@property(nonatomic,assign)BOOL isReload;//是否刷新
@property(nonatomic,copy)NSString *sendPrice;//起送价
@property(nonatomic,copy)NSString *distributionprice;//配送价
@property(nonatomic,weak)UILabel *selectConfirmLab;
@property(nonatomic,strong)UIView *bgView;//背景
@property(nonatomic,weak)UIButton *favBtn;//收藏按钮
@end

@implementation FoodBussinessListCollectionViewController
-(id)initWithId:(NSString *)merchantId andSendPrice:(NSString *)price andDistributionPrice:(NSString *)distributionPrice{
    self = [super init];
    if (self) {
        self.memchantId = merchantId;
        self.sendPrice = price;
        self.distributionprice = distributionPrice;
        [self makeInit];
        [self loadData];
        //加载收藏数据
        [self makeNav];
        [self makeUI];
        [self makeBottom];
        //判断是否收藏数据
        [self jugeCollectionMerchant];
        [self makeHUd];

       // [self loodGoodCars];
    }
    return self;
}
-(void)makeInit{
    self.carLiast = NO;
    self.priceAll = 0;
    self.dataArr = [NSMutableArray arrayWithCapacity:0];
    self.sectionArr = [NSMutableArray arrayWithCapacity:0];
    self.buyArr = [NSMutableArray arrayWithCapacity:0];
    self.shopPriceCountArr = [NSMutableArray arrayWithCapacity:0];
    for (NSInteger i = 0; i < 3; i++) {
        [self.dataArr addObject:@"0"];
        [self.sectionArr addObject:@"0"];
    }
    self.rlidArr = [NSMutableArray arrayWithCapacity:0];
    self.isReload = NO;
}
//导航条
-(void)makeNav{
    [self setNavBarImage:@"landi.png"];
    //[self setBackgroud:@"lantiao x.png"];
    [self setBackImageStateName:@"fanhuijian02.png" AndHighlightedName:@""];
    //商品、商家、评价
    UIView *navView = [[UIView alloc] initWithFrame:CGRectMake(WIDTH_CONTROLLER / 2 - 90 * self.numSingleVesion, 0, 180 * self.numSingleVesion, 44)];
    NSArray *navArr = @[@"商品",@"商家",@"评价"];
    for (NSInteger i = 0; i < navArr.count; i++) {
        UIButton *navBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        navBtn.frame = CGRectMake(60 * self.numSingleVesion * i, 5, 60 * self.numSingleVesion, 34);
        [navBtn setTitle:navArr[i] forState:UIControlStateNormal];
        navBtn.titleLabel.font = [UIFont systemFontOfSize:15 * self.numSingleVesion];
        [navBtn addTarget:self action:@selector(navBtnDown:) forControlEvents:UIControlEventTouchUpInside];
        [navView addSubview:navBtn];
        [navBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        navBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        navBtn.tag = 1200 + i;
        if(i == 0){
            [navBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        }
    }
    navView.center = CGPointMake(WIDTH_CONTROLLER / 2, 22);
    self.navigationItem.titleView = navView;
    //收藏按钮
    UIButton *favoriteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    favoriteBtn.frame = CGRectMake(WIDTH_CONTROLLER - 0 * self.numSingleVesion - 0 * self.numSingleVesion, 5, 50 * self.numSingleVesion, 34);
    [favoriteBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [favoriteBtn setTitle:@"收藏" forState:UIControlStateNormal];
    //[favoriteBtn setImageEdgeInsets:UIEdgeInsetsMake(5 , 7 , 14, 7)];
    //[favoriteBtn setTitleEdgeInsets:UIEdgeInsetsMake(30, 5, 2, 0)];
    favoriteBtn.titleLabel.font = [UIFont systemFontOfSize:15 * self.numSingleVesion];
    favoriteBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [favoriteBtn addTarget:self action:@selector(navBtnDown:) forControlEvents:UIControlEventTouchUpInside];
    favoriteBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    favoriteBtn.tag = 1250;
    self.favBtn = favoriteBtn;
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithCustomView:favoriteBtn];
    self.navigationItem.rightBarButtonItem = rightBar;
}
-(void)navBtnDown:(UIButton *)navBtn{
    [self removeView];
    if (navBtn.tag <= 1202) {
        for (NSInteger i = 0; i < 3; i++) {
            UIButton *btn = (UIButton *)[self.navigationItem.titleView viewWithTag:1200 + i];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        [navBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        
         self.collectionView.contentOffset = CGPointMake(WIDTH_CONTROLLER * (navBtn.tag - 1200), 0);
        if ([self.dataArr[navBtn.tag - 1200] isEqual:@"0"]) {
            [self makeHUd];
            [self loadDataNum:navBtn.tag - 1200];
        }else{
           
        }
    }else{
        NSString *url = @"http://211.152.8.99/360duang/serviceServlet?serviceName=dlshopmag&medthodName=dlsprolist&did=38";
        url = [NSString stringWithFormat:COLLECTMERCHANT,self.memchantId,@"3900"];
        
        AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
        manger.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/json",@"text/html",@"application/json",nil];
        manger.requestSerializer = [[AFHTTPRequestSerializer alloc] init];
        manger.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
        [manger GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSString *str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//            NSString *tempStr =  [str substringFromIndex:1];
//            NSString *fianlStr = [tempStr substringToIndex:tempStr.length - 1];
            if ([str isEqual:@"&取消收藏！"]) {
                NSLog(@"1");
                [self cancelFavBtnName];
            }else{
                NSLog(@"2");
                [self mendFavBtnName];
            }
            [self.view makeToast:str];

        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          //  [[NSURLCache sharedURLCache] removeAllCachedResponses];
            NSLog(@"%@",[error description]);
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"警告" message:@"网络不流畅，请换个网络试试" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
            [alertView show];
            return ;
        }];
    }
}
-(void)loadData{
    NSString *url = @"http://211.152.8.99/360duang/serviceServlet?serviceName=dlshopmag&medthodName=dlsprolist&did=38";
    url = [NSString stringWithFormat:MERCHANTGOODSLIST,self.memchantId];

    AFNetworkTwoPackaging *twoPageing = [[AFNetworkTwoPackaging alloc] init];
    [twoPageing getUrl:url andFinishBlock:^(id getResult) {
        [self hudWasHidden:self.hudProgress];
//        if([getResult[0] isEqualToString:@"该商家没有创建产品栏目"]){
        NSString *str  = [NSString stringWithFormat:@"%@",getResult];
        if (str.length <= 11) {
            
            [self.view makeToast:@"该商家还没有上传商品"];
            return ;
        }else{
        
        NSMutableArray *sectionArr = [NSMutableArray arrayWithCapacity:0];
        NSMutableArray *itemArrAll = [NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *temp in getResult) {
            
            
            
            FoodMerchatListModel *model = [[FoodMerchatListModel alloc] initWithDictionary:temp];
            
            [sectionArr addObject:model];
            NSMutableArray *itemArr = [NSMutableArray arrayWithCapacity:0];
            for (NSDictionary *tempItem in model.item) {
                FoodMerchatListItemModel *itemModel = [[FoodMerchatListItemModel alloc] initWithDictionary:tempItem];
                [itemArr addObject:itemModel];
                
            }
            [itemArrAll addObject:itemArr];
            
        }
       // self.buyArr =
        [self.dataArr replaceObjectAtIndex:0 withObject:itemArrAll];
        [self.sectionArr replaceObjectAtIndex:0 withObject:sectionArr];
        [self loodGoodCars];
        //[self.collectionView reloadData];
        }
}];
}
-(void)makeUI{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    layout.minimumLineSpacing = 0;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, WIDTH_CONTROLLER, HEIGHT_CONTROLLER - 64 - 49 * self.numSingleVesion) collectionViewLayout:layout];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.pagingEnabled = YES;
    collectionView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:collectionView];
    collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView = collectionView;
    
    [collectionView registerClass:[CommonBusinessListCollectionViewCell class] forCellWithReuseIdentifier:FOODLISTCOLLECTIONCELL];
    
}
-(void)makeBottom{
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, HEIGHT_CONTROLLER - 49 * self.numSingleVesion, WIDTH_CONTROLLER / 3*2, 49 * self.numSingleVesion)];
    leftView.backgroundColor = SMSColor(56, 50, 52);
    [self.view addSubview:leftView];
    
    UIImageView *buyImg = [[UIImageView alloc] initWithFrame:CGRectMake(2 * self.numSingleVesion, -1 * self.numSingleVesion, 40 * self.numSingleVesion, 40 * self.numSingleVesion)];
    buyImg.image = [UIImage imageNamed:@"购物车"];
    [leftView addSubview:buyImg];
    
    UIImageView *buyNum = [[UIImageView alloc] initWithFrame:CGRectMake((68 - 16) / 2 * self.numSingleVesion, -2 * self.numSingleVesion, 16 * self.numSingleVesion, 16 * self.numSingleVesion)];
    buyNum.image = [UIImage imageNamed:@"数量色块"];
    [leftView addSubview:buyNum];
    //显示购买几个
    UILabel *buyLableNum = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 12 * self.numSingleVesion, 12 * self.numSingleVesion)];
    buyLableNum.font = [UIFont systemFontOfSize:12];
    buyLableNum.textColor = [UIColor whiteColor];
    buyLableNum.center = CGPointMake(8 * self.numSingleVesion, 8 * self.numSingleVesion);
    [buyNum addSubview:buyLableNum];
    self.buyNumLable = buyLableNum;
    //总共价格
    UILabel *prcieLable = [[UILabel alloc] initWithFrame:CGRectMake(45 * self.numSingleVesion, (49 - 15) / 2 * self.numSingleVesion, WIDTH_CONTROLLER / 3*2 - 45 * self.numSingleVesion, 15 * self.numSingleVesion)];
    prcieLable.textColor = [UIColor whiteColor];
    prcieLable.font = [UIFont systemFontOfSize:14];
    [leftView addSubview:prcieLable];
    self.priceLable = prcieLable;
//    if(self.sendPrice.integerValue == 0){
//        self.priceLable.text = @"起送价0元";
//    }else{
//        self.priceLable.text = [NSString stringWithFormat:@"%@元起送",self.sendPrice];
//    }
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = leftView.bounds;
    [leftBtn setTitle:@"" forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(selectBtnDown:) forControlEvents:UIControlEventTouchUpInside];
    [leftView addSubview:leftBtn];
    leftBtn.tag = 1620;
    
    //右边选好了
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(WIDTH_CONTROLLER / 3*2 , HEIGHT_CONTROLLER - 49 * self.numSingleVesion, WIDTH_CONTROLLER / 3, 49 * self.numSingleVesion)];
    [self.view addSubview:rightView];
    rightView.backgroundColor = SMSColor(230, 62, 61);
    
    UILabel *selectLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 15 * self.numSingleVesion)];
    selectLable.textColor = [UIColor whiteColor];
    selectLable.font = [UIFont systemFontOfSize:14];
    [rightView addSubview:selectLable];
    selectLable.text = [NSString stringWithFormat:@"差%@元起送",self.sendPrice];
    [selectLable sizeToFit];
    selectLable.frame = CGRectMake((rightView.frame.size.width - selectLable.frame.size.width) / 2, (49 - 15) / 2 * self.numSingleVesion, selectLable.frame.size.width, 15 * self.numSingleVesion);
    self.selectConfirmLab = selectLable;
    UIButton *selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    selectBtn.frame = rightView.bounds;
    [selectBtn addTarget:self action:@selector(selectBtnDown:) forControlEvents:UIControlEventTouchUpInside];
    [selectBtn setTitle:@"" forState:UIControlStateNormal];
    [rightView addSubview:selectBtn];
    selectBtn.tag = 1601;
}
-(void)selectBtnDown:(UIButton *)selectBtn{
    if (selectBtn.tag == 1601) {
        if (self.priceLable.text.length == 0) {
            [self.view makeToast:@"购物车不能为空,请添加购物!"];
            return;
        }else if (self.priceAll < self.sendPrice.integerValue){
            return;
        }
        
        if (![StoreageMessage isStoreMessage]) {
            [self.view makeToast:@"请先登录!"];
            LogInViewController *logIN = [[LogInViewController alloc] init];
            [self.navigationController pushViewController:logIN animated:YES];
            return;
        }
        selectBtn.userInteractionEnabled = NO;
        //上传购物车
        [self makeHUd];
        [self requestJoinGoodsCar];
        selectBtn.userInteractionEnabled = YES;
        
        [self.listView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self.listView removeFromSuperview];
        self.listView = nil;
        [self removeBgView];
//   商家 did:self.memchantId
        //self.priceAll += self.distributionprice.integerValue;
        
    }else{
        if (!self.carLiast) {
            CGFloat height = [[self returnNextArr] count] * 30 * self.numSingleVesion + 30 * self.numSingleVesion + 20 * self.numSingleVesion;
            CGFloat initHeight = HEIGHT_CONTROLLER - 49 * self.numSingleVesion - height;
            self.listView = [[ShopListView alloc] initWithFrame:CGRectMake(0, initHeight, WIDTH_CONTROLLER, height) andArr:[self returnNextArr]];
            self.listView.target = self;
          //  self.view.backgroundColor = [UIColor lightGrayColor];
            self.listView.backgroundColor = [UIColor whiteColor];
            [self.view addSubview:self.listView];
            [self createBgViewHeight:initHeight];
            //[self iOS8blurAction];
        }else{
            for (id temp in self.listView.subviews) {
                [temp removeFromSuperview];
            }
            [self.listView removeFromSuperview];
            [self removeBgView];
        }
        self.carLiast = !self.carLiast;
//        ShoppingCarViewController *shopCar = [[ShoppingCarViewController alloc] initWithPrice:[self returnNextArr] withFrame:CGRectMake(0, 264, WIDTH_CONTROLLER, HEIGHT_CONTROLLER - 64 - 49 * self.numSingleVesion)];
//        shopCar.target = self;
//        //[self.view addSubview:shopCar.view];
//        [self.navigationController pushViewController:shopCar animated:YES];
    }
    
}
//创建背景图
- (void)createBgViewHeight:(NSInteger)height{
    self.bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, WIDTH_CONTROLLER, height - 64)];
    self.bgView.backgroundColor = SMSColor(221, 221, 221);
    [self.view addSubview:self.bgView];
}
//移除背景图
- (void)removeBgView{
    [self.bgView removeFromSuperview];
    self.bgView = nil;
}
- (void)iOS8blurAction{
    
    UIBlurEffect *beffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
    
    UIVisualEffectView *view = [[UIVisualEffectView alloc]initWithEffect:beffect];
    
    view.frame = self.view.bounds;
    
    [self.view addSubview:view];
    
}
- (void)requestJoinGoodsCar{
    NSMutableArray *upLoadDataArr = [NSMutableArray arrayWithCapacity:0];
    NSArray *keyArr = @[@"productID",@"count",@"rlid"];

    for (NSInteger i = 0; i < [[self returnUploadGoodsCar] count] - 1; i++) {
        NSDictionary *tempDict = [self returnUploadGoodsCar][i];
        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
        
        FoodMerchatListItemModel *model = tempDict[@"ItemModel"];
        //[upLoadArr addObject:@{@"rlid":@"",@"count":dict[@"count"],@"descName":@"",@"ItemModel":dict[@"model"]}];
        [dict setValue:model.pid forKey:@"productID"];
        [dict setValue:tempDict[@"count"] forKey:@"count"];
        NSString *tempStr = [NSString stringWithFormat:@"%ld",[tempDict[@"rlid"] integerValue]] ;

        if([tempStr integerValue] == 0){
            tempStr = @"";
        }
        [dict setValue:tempStr forKey:@"rlid"];
        [upLoadDataArr addObject:dict];
        
    }
    //生成json字符串
    NSMutableString *jsonString = [NSMutableString stringWithCapacity:0];
    [jsonString appendString:@"["];
    NSLog(@"jsonString:%@",jsonString);
    for (NSDictionary *temp in upLoadDataArr) {
        NSString *string ;//遍历数组，取出键值对并按json格式存放
        string = [NSString stringWithFormat:@"{\"productID\":\"%@\",\"count\":\"%@\",\"rlid\":\"%@\"}",temp[@"productID"],temp[@"count"],temp[@"rlid"]];
        [jsonString appendString:string];
        [jsonString appendString:@","];
    }

    //获取末尾逗号所在位置
    NSUInteger location = [jsonString length] - 1;
    NSRange range = NSMakeRange(location, 1);
    [jsonString replaceCharactersInRange:range withString:@"]"];

    NSString *url =  [jsonString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *_rom = [AFHTTPRequestOperationManager manager];
    _rom.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/json",@"text/html",@"application/json",nil];
    _rom.requestSerializer = [[AFHTTPRequestSerializer alloc] init];
    _rom.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    NSString *tempUrl = [NSString stringWithFormat:AddAllGoodsCar,[StoreageMessage getMessage][2],self.memchantId,url];
    [_rom GET:tempUrl parameters:nil      success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self hudWasHidden:self.hudProgress];
        NSString *tempStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSData *strData = [tempStr dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:strData options:NSJSONReadingMutableLeaves error:nil];
        if ([dict[@"code"] isEqual:@"000000"]) {
            BuyFoodCarViewController *buyFood = [[BuyFoodCarViewController alloc] initWithArr:[self returnUploadGoodsCar] andPrice:self.priceAll andFoodTypeArr:self.rlidArr andMerchantId:self.memchantId andSendPrice:self.sendPrice andDistrutionPrice:self.distributionprice];
            buyFood.shopDesc = self.shopDesc;
            buyFood.shopName = self.shopName;
            [self.navigationController pushViewController:buyFood animated:YES];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self hudWasHidden:self.hudProgress];
        NSLog(@"error:%@",error);
        [self.view makeToast:@"由于网络原因,请重新确认"];
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    // Do any additional setup after loading the view.
}
#pragma mark collectionViewCell
//-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
//    return 1;
//}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 3;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CommonBusinessListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:FOODLISTCOLLECTIONCELL forIndexPath:indexPath];
    if (!cell) {
        NSArray *xibs = [[NSBundle mainBundle] loadNibNamed:FOODLISTCOLLECTIONCELL owner:self options:nil];
        cell = xibs[0];
    }
    [cell.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [cell init];
    cell.target = self;

    if (![self.dataArr[indexPath.row] isEqual:@"0"]) {
        if(indexPath.row == 2){
            cell.evaluateDic = self.dataArr[indexPath.row];
            [cell makeUINum:indexPath.row];

        }else if(indexPath.row == 0){
            cell.dataArr = self.dataArr[indexPath.row];
            cell.sectionArr = self.sectionArr[indexPath.row];
            [cell makeUINum:indexPath.row];

        }else{
            cell.detailModel = self.dataArr[indexPath.row];
            [cell makeUINum:indexPath.row];

        }
    }
    
    return cell;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(WIDTH_CONTROLLER, HEIGHT_CONTROLLER - 64 - 49 * self.numSingleVesion - 0 * self.numSingleVesion);
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    UIEdgeInsets set = {0,0,0,0};
    return set;
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger num = scrollView.contentOffset.x / WIDTH_CONTROLLER;
    for (NSInteger i = 0; i < 3; i++) {
        UIButton *btn = (UIButton *)[self.navigationItem.titleView viewWithTag:1200 + i];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    UIButton *navBtn = (UIButton *)[self.navigationItem.titleView viewWithTag:1200 + num];
    [navBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    if ([self.dataArr[num] isEqual:@"0"]) {
        [self makeHUd];
        [self loadDataNum:navBtn.tag - 1200];
    }
}
-(void)loadDataNum:(NSInteger)num{
    AFNetworkTwoPackaging *twoPage = [[AFNetworkTwoPackaging alloc] init];
    switch (num) {
        case 0:{
            [self loadData];
            break;
        }
        case 1:{
            [twoPage getUrl:[NSString stringWithFormat:MERCHANTLISTDEATIL,self.memchantId] andFinishBlock:^(id getResult) {
                [self hudWasHidden:self.hudProgress];
//                NSMutableArray *tempDataArr = [NSMutableArray arrayWithCapacity:0];
//                for (id temp in getResult) {
                    MerchantDeatilModel *model = [[MerchantDeatilModel alloc] initWithDictionary:getResult];
                   // [tempDataArr addObject:model];
                //}
                [self.dataArr replaceObjectAtIndex:num withObject:model];
                [self.collectionView reloadData];
            }];
            break;
        }
        case 2:{
            [twoPage getUrl:[NSString stringWithFormat:MERCHANTEVALUATE,@"2",self.memchantId,1,5]andFinishBlock:^(id getResult) {
                [self hudWasHidden:self.hudProgress];
                [self.dataArr replaceObjectAtIndex:num withObject:getResult];
                [self.collectionView reloadData];
            }];
            break;
        }
        default:
            break;
    }
}
#pragma mark 加载动画效果
//加载图片
-(void)makeHUd{
    self.hudProgress = [[MBProgressHUD alloc] initWithView:self.view];
    self.hudProgress.delegate = self;
    //self.hudProgress.color = [UIColor clearColor];
    self.hudProgress.labelText = @"loading";
    self.hudProgress.dimBackground = YES;
    //self.hudProgress.margin = 80.f;
    //self.hudProgress.yOffset = 150.f;
    [self.view addSubview:self.hudProgress];
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
#pragma mark 返回数据
-(void)returnBuyCar:(FoodMerchatListItemModel *)model andAddAndReduce:(NSString *)addAndReduce andBuyCount:(NSString *)buyCount{
    model.buyCount = buyCount;
    if ([addAndReduce isEqualToString:@"1"]) {
        [self.buyArr addObject:model];
        self.priceAll += model.price.floatValue;
        if (self.priceAll < self.sendPrice.integerValue) {
            self.selectConfirmLab.text = [NSString stringWithFormat:@"差%ld元起送",(self.sendPrice.integerValue - (NSInteger)self.priceAll)];
        }else{
            self.selectConfirmLab.text = @"选好了";
        }
        self.priceLable.text = [NSString stringWithFormat:@"共￥%0.2f",self.priceAll];

        if (self.buyNumLable.text.length == 0) {
            self.buyNumLable.text = @"1";
        }else{
            //self.buyNumLable.text.integerValue++;
            self.buyNumLable.text = [NSString stringWithFormat:@"%ld",self.buyNumLable.text.integerValue + 1];
        }
    }else{
        [self.buyArr removeObject:model];
        self.priceAll -= model.price.floatValue;
        if (self.priceAll  <= 0) {
            self.priceAll = 0;
            self.selectConfirmLab.text = [NSString stringWithFormat:@"差%ld元起送",(self.sendPrice.integerValue - (NSInteger)self.priceAll)];

        }else if (self.priceAll < self.sendPrice.integerValue) {
            self.selectConfirmLab.text = [NSString stringWithFormat:@"差%ld元起送",(self.sendPrice.integerValue - (NSInteger)self.priceAll)];
        }else{
            self.selectConfirmLab.text = @"选好了";
        }
        self.priceLable.text = [NSString stringWithFormat:@"共￥%0.2f",self.priceAll];
        
        if (self.buyNumLable.text.length == 0) {
            self.buyNumLable.text = @"1";
        }else{
            //self.buyNumLable.text.integerValue++;
            self.buyNumLable.text = [NSString stringWithFormat:@"%ld",self.buyNumLable.text.integerValue - 1];
        }
    }
    if (self.isReload) {
        [self.collectionView reloadData];
    }
    self.isReload = NO;
    //model.buyCount =
}
#pragma mark 整理数据
-(NSArray *)returnNextArr{
    NSMutableArray *tempArr = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray *buyTempArr = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray *buyNameTempArr = [NSMutableArray arrayWithCapacity:0];
       for (NSInteger i = 0; i < self.buyArr.count; i++) {
        FoodMerchatListItemModel *model = self.buyArr[i];
        if (![buyNameTempArr containsObject:[NSString stringWithFormat:@"%ld",[model.pid integerValue]]]) {
            [buyTempArr addObject:model];
            [buyNameTempArr addObject:[NSString stringWithFormat:@"%ld",[model.pid integerValue]]];
        }
    }
    NSMutableArray *buyFinalTempArr = [self.buyArr mutableCopy];
    if ([buyTempArr isEqual:self.buyArr]) {
        for (NSInteger i = 0; i < buyTempArr.count; i++) {
            FoodMerchatListItemModel *model = buyTempArr[i];
            [tempArr addObject:@{@"count":@"1",@"model":model}];
        }
    }else{
        for (NSInteger i = 0; i < buyTempArr.count; i++) {
            FoodMerchatListItemModel *model = buyTempArr[i];
            NSInteger count = 0;
            for (NSInteger j = 0; j < buyFinalTempArr.count; j++) {
                FoodMerchatListItemModel *temoModel = self.buyArr[j];
                if ([model.pid intValue] == [temoModel.pid intValue]) {
                    count++;
                }
            }
            [tempArr addObject:@{@"count":[NSString stringWithFormat:@"%ld",count],@"model":model}];
        }
    }
    return tempArr;
}
//清空数据
-(void)clearAllBuyCar{
    [self.buyArr removeAllObjects];
    //[self.dataArr replaceObjectAtIndex:0 withObject:@"0"];
    self.buyNumLable.text = @"";
    self.priceAll = 0;
    self.priceLable.text = @"";
    for (id temp in self.listView.subviews) {
        [temp removeFromSuperview];
    }
    [self.listView removeFromSuperview];
    [self.collectionView reloadData];
}
//返回评论加载更多
- (void)returnCommentArr:(NSArray *)commentArr{
    [self.dataArr replaceObjectAtIndex:2 withObject:commentArr];
    [self.collectionView reloadData];

}
//进入产品详情
- (void)returnGoods:(FoodMerchatListItemModel *)model andProcudeId:(NSString *)produceId{
    FoodMerchantGoodsDeatilViewController *goodsMerchant = [[FoodMerchantGoodsDeatilViewController alloc] initWithItemModel:model andPrudctId:produceId];
    goodsMerchant.merchantId = self.memchantId;
    goodsMerchant.target = self;
    [self.navigationController pushViewController:goodsMerchant animated:YES];
//    FoodMerchantGoodsDeatilViewController *foodMerGoods = [[FoodMerchantGoodsDeatilViewController alloc] inii]
}
//加入购物车，选择样式
- (void)addFoodCarRlid:(NSString *)rlid andCount:(NSInteger)count andName:(NSString *)foodName andModel:(FoodMerchatListItemModel *)model andAddOrReduce:(NSString *)type{
    if ([rlid isEqual:@"0"]) {
    }else{
        [self.rlidArr addObject:@{@"rlid":rlid,@"count":[NSString stringWithFormat:@"%ld",count],@"descName":foodName,@"ItemModel":model}];

    }
    for (NSInteger i = 0; i < count; i++) {
        self.isReload = YES;
        [self returnBuyCar:model andAddAndReduce:@"1" andBuyCount:[NSString stringWithFormat:@"%ld",1 + model.buyCount.integerValue]];
 
    }
}
#pragma makr 购物车和描述
- (NSArray *)returnUploadGoodsCar{
    NSMutableArray *upLoadArr = [NSMutableArray arrayWithCapacity:0];
    NSArray *tempArr = [self returnNextArr];
    if (self.rlidArr.count != 0) {
        [upLoadArr addObjectsFromArray:self.rlidArr];
        NSMutableArray *modelArr = [NSMutableArray arrayWithCapacity:0];
        //把有描述的里边的itemModel放在一个数组里边，后边会有是否包含在内
        for (NSDictionary *temp in upLoadArr) {
            [modelArr addObject:temp[@"ItemModel"]];
        }
        
        for (NSInteger i = 0; i < tempArr.count; i++) {
            NSDictionary *dict = tempArr[i];
            if (![modelArr containsObject:dict[@"model"]]) {
                [upLoadArr addObject:@{@"rlid":@"",@"count":dict[@"count"],@"descName":@"",@"ItemModel":dict[@"model"]}];
            }
        }

    }else{
        for (NSInteger i = 0; i < tempArr.count; i++) {
            NSDictionary *dict = tempArr[i];
            [upLoadArr addObject:@{@"rlid":@"",@"count":dict[@"count"],@"descName":@"",@"ItemModel":dict[@"model"]}];
        }
 
    }
  if (self.distributionprice.integerValue > 0) {
        [upLoadArr addObject:@{@"name":@"配送费",@"distrution":self.distributionprice}];

    }
    return upLoadArr;
}
//加载购物车
- (void)loodGoodCars{
    if (![StoreageMessage isStoreMessage]) {
        [self.view makeToast:@"请先登录!"];
        LogInViewController *logIN = [[LogInViewController alloc] init];
        [self.navigationController pushViewController:logIN animated:YES];
        return;
    }
    NSLog(@"url:%@",[NSString stringWithFormat:LAODGOODSCAR,[StoreageMessage getMessage][2],self.memchantId] );
    AFNetworkTwoPackaging *twoPack = [[AFNetworkTwoPackaging alloc] init];
    [twoPack getUrl:[NSString stringWithFormat:LAODGOODSCAR,[StoreageMessage getMessage][2],self.memchantId] andFinishBlock:^(id getResult) {
        NSInteger count = 0;//购物车有的数目
        NSArray *keyArr1 = @[@"carid",@"pid",@"name",@"unit",@"unitPrice",@"goodsNum",@"goodsRuleId",@"goodsRuleName",@"shoppingcarPrice",@"",@"",@""];
        NSArray *keyArr = @[@"pid",@"indeximg",@"requrl",@"name",@"sendCount",@"tuijianCount",@"price",@"typeCount",@"imgurl",@"inventory",@"rule",@"buyCount"];
        NSArray *resultArr = [getResult objectForKey:@"xitem"];
        if ([resultArr count] == 0) {
                    [self.collectionView reloadData];
            return ;
        }
    
        for (NSInteger j = 0; j <[resultArr count]; j++) {
            NSDictionary *temp = getResult[@"xitem"][j];
            //添加描述
            
            for (NSInteger m = 0; m < [temp[@"goodsNum"] integerValue]; m++) {
                NSArray *valueArr = @[temp[@"pid"],@"",@"",temp[@"name"],@"",@"",temp[@"unitPrice"],temp[@"goodsNum"]];
                NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
                for (NSInteger h = 0; h < valueArr.count; h++) {
                    [dict setValue:valueArr[h] forKey:keyArr[h]];
                }
                FoodMerchatListItemModel *itemModel = [[FoodMerchatListItemModel alloc] initWithDictionary:dict];
                itemModel.buyCount = temp[@"goodsNum"];
                [self.buyArr addObject:itemModel];
                if(m == [temp[@"goodsNum"] integerValue] - 1){
                    [self.rlidArr addObject:@{@"rlid":temp[@"goodsRuleId"],@"count":temp[@"goodsNum"],@"descName":temp[@"goodsRuleName"],@"ItemModel":itemModel}];

                }
                if(m == 0){
                    //改变显示的数字
                    NSArray *dataArr = self.dataArr[0];
                    for (NSInteger h = 0; h < [dataArr count]; h++) {
                        //NSArray *detailArr = dataArr[h];
                        for (NSInteger s = 0; s < [(NSArray *)dataArr[h] count]; s++) {
                            FoodMerchatListItemModel *detailModel = dataArr[h][s];
                            NSLog(@"pid%@",detailModel.pid);
                            if([detailModel.pid integerValue] == [itemModel.pid integerValue]){
                                if (!detailModel.buyCount) {
                                    detailModel.buyCount = @"0";
                                }
                                detailModel.buyCount = [NSString stringWithFormat:@"%ld",([itemModel.buyCount integerValue] + [detailModel.buyCount integerValue])];
                                NSLog(@"%@",detailModel.buyCount);
                            }
                        }
                    }

                }
            }
            count += [temp[@"goodsNum"] integerValue];
            
        }
        //几个数目
        self.buyNumLable.text = [NSString stringWithFormat:@"%ld",count];
        //一共多少元
        self.priceLable.text = [NSString stringWithFormat:@"共￥%0.2f",self.priceAll + [getResult[@"totalPrice"] floatValue]];
        //差多少元起送
        self.priceAll += [getResult[@"totalPrice"] floatValue];
        if (self.priceAll < self.sendPrice.integerValue) {
            self.selectConfirmLab.text = [NSString stringWithFormat:@"差%ld元起送",(self.sendPrice.integerValue - (NSInteger)self.priceAll)];
        }else{
            self.selectConfirmLab.text = @"选好了";
        }
//       [self.dataArr replaceObjectAtIndex:0 withObject:itemArrAll];
//        [self.sectionArr replaceObjectAtIndex:0 withObject:sectionArr];
//        [self.collectionView reloadData];
        [self.collectionView reloadData];
        NSLog(@"getResult:%@",getResult);
        NSLog(@"url:%@",[NSString stringWithFormat:LAODGOODSCAR,[StoreageMessage getMessage][2],self.memchantId]);
    }];
}
//触摸
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    if ([touch.view isEqual:self.bgView]) {
        //
        [self removeView];
    }
}
- (void)removeView{
    [self.listView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.listView removeFromSuperview];
    self.listView = nil;
    [self removeBgView];
}
//判断是否收藏
- (void)jugeCollectionMerchant{
    if (![StoreageMessage isStoreMessage]) {
        return;
    }
    AFNetworkTwoPackaging *twoPack = [[AFNetworkTwoPackaging alloc] init];
    [twoPack getUrl:[NSString stringWithFormat:ISORNOTFAVORITEMERCHANT,[StoreageMessage getMessage][2],self.memchantId] andFinishBlock:^(id getResult) {
        if ([getResult[@"status"] isEqual:@"1"]) {
            //已经收藏
            [self mendFavBtnName];
        }
    }];
}
//收藏成功
- (void)mendFavBtnName{
    [self.favBtn setTitle:@"已收藏" forState:UIControlStateNormal];
    //[self.favBtn setImage:[UIImage imageNamed:@"shoucang02"] forState:UIControlStateNormal];
    //[self.favBtn setImageEdgeInsets:UIEdgeInsetsMake(5 , 7 , 14, 7)];
    //[self.favBtn setTitleEdgeInsets:UIEdgeInsetsMake(30, 5, 2, 0)];

}
//取消收藏
- (void)cancelFavBtnName{
    [self.favBtn setTitle:@"收藏" forState:UIControlStateNormal];
//    [self.favBtn setImage:[UIImage imageNamed:@"main_shoucang_n"] forState:UIControlStateNormal];
//    [self.favBtn setImageEdgeInsets:UIEdgeInsetsMake(5 , 7 , 14, 7)];
//    [self.favBtn setTitleEdgeInsets:UIEdgeInsetsMake(30, 5, 2, 0)];

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
