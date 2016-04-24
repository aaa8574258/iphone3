//
//  MinePrivilageViewController.m
//  360du
//
//  Created by linghang on 15/12/11.
//  Copyright © 2015年 wangjian. All rights reserved.
//

#import "MinePrivilageViewController.h"
#import "AFNetworkTwoPackaging.h"
#import "StoreageMessage.h"
#import "MinePrivilageModel.h"
#import "UIView+Toast.h"
#import "MinePrivilageCollectionViewCell.h"
#import "PrivilegeCenterViewController.h"
#import "FoodBussinessListCollectionViewController.h"
#import "FoodMerchantGoodsDeatilViewController.h"
#import "FoodMerchatListModel.h"
#define MINEPRIVILEAGECOLLECTIONCELL @"minePrivileageCollectionCell"
@interface MinePrivilageViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong)UILabel *statusBtnLab;
@property(nonatomic,weak)UICollectionView *collectionView;
@property(nonatomic,strong)NSMutableArray *collectionArr;

@end

@implementation MinePrivilageViewController
-(id)init{
    self = [super init];
    if (self) {
        [self makeInit];
        [self loadData];
        [self makeNav];
        [self makeUI];
        [self makeHUd];
    }
    return self;
}
- (void)makeInit{
    self.collectionArr = [NSMutableArray arrayWithCapacity:0];
    for (NSInteger i = 0; i < 4; i++) {
        [self.collectionArr addObject:@"0"];
    }
}
- (void)loadData{
    AFNetworkTwoPackaging *twoPack = [[AFNetworkTwoPackaging alloc] init];
    [twoPack getUrl:[NSString stringWithFormat:MINEPRIVEILAGECNETER, [StoreageMessage getMessage][2],@"1"] andFinishBlock:^(id getResult) {
        [self hudWasHidden:self.hudProgress];
        if ([getResult[@"code"] isEqual:@"000000"] ) {
            NSMutableArray *tempArr = [NSMutableArray arrayWithCapacity:0];
            if ([getResult[@"datas"] count] == 0) {
                return ;
            }
            for (NSDictionary *temp in getResult[@"datas"]) {
                MinePrivilageModel *model = [[MinePrivilageModel alloc] initWithDictionary:temp];
                [tempArr addObject:model];
            }
            [self.collectionArr replaceObjectAtIndex:0 withObject:tempArr];
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
    
    [self setNavTitleItemWithName:@"优惠券"];
}
-(void)makeUI{
    [self makeFourHeadBtn];
    [self makeCollectionView];
    [self makeBottom];
}
- (void)makeFourHeadBtn{
    NSArray *statusArr = @[@"未使用",@"已使用",@"已过期"];
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
    [collectionView registerClass:[MinePrivilageCollectionViewCell class] forCellWithReuseIdentifier:MINEPRIVILEAGECOLLECTIONCELL];
    self.collectionView = collectionView;
}
- (void)makeBottom{
    UIButton *bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    bottomBtn.frame = CGRectMake(10 * self.numSingleVesion, HEIGHT_CONTROLLER - 50 * self.numSingleVesion, WIDTH_CONTROLLER - 20 * self.numSingleVesion, 40 * self.numSingleVesion);
    [bottomBtn setBackgroundColor:[UIColor redColor]];
    [bottomBtn setTitle:@"更多好劵，去领劵中心看看" forState:UIControlStateNormal];
    [bottomBtn addTarget:self action:@selector(bottomBtnDown:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bottomBtn];
    
}
- (void)bottomBtnDown:(UIButton *)bottomBtn{
    PrivilegeCenterViewController *privilegeView = [[PrivilegeCenterViewController alloc] init];
    [self.navigationController pushViewController:privilegeView animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    // Do any additional setup after loading the view.
}
#pragma mark collectionView的代理
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.collectionArr.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    //判读一下等于0就不执行下边的方法
    if ([self.collectionArr[indexPath.row] isEqual:@"0"]) {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:MINEPRIVILEAGECOLLECTIONCELL forIndexPath:indexPath];
        
        return cell;
    }
    MinePrivilageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:MINEPRIVILEAGECOLLECTIONCELL forIndexPath:indexPath];
    cell.dataArr = self.collectionArr[indexPath.row];
    cell.target = self;
    cell.num = indexPath.row;
    cell.userStatus = [NSString stringWithFormat:@"%ld",indexPath.row + 1];
    //cell.clickNum = indexPath.row;
    //cell.cellArr = self.collectionArr[indexPath.row];
    //cell.m
    
    return cell;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(WIDTH_CONTROLLER, HEIGHT_CONTROLLER - 64 - 40 * self.numSingleVesion - 50 * self.numSingleVesion);
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    UIEdgeInsets set = {0,0,0,0};
    return set;
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    float everWidth = WIDTH_CONTROLLER / 3;
    NSInteger num = scrollView.contentOffset.x / WIDTH_CONTROLLER;
    self.statusBtnLab.frame = CGRectMake(everWidth * num,39 * self.numSingleVesion, everWidth, 1 * self.numSingleVesion);
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
    AFNetworkTwoPackaging *twoPack = [[AFNetworkTwoPackaging alloc] init];
    NSString *numStr = [NSString stringWithFormat:@"%ld",num + 1];
    NSString *url = [NSString stringWithFormat:MINEPRIVEILAGECNETER,[StoreageMessage getMessage][2],numStr];
    [twoPack getUrl:url andFinishBlock:^(id getResult) {
        [self hudWasHidden:self.hudProgress];
        if ([getResult[@"code"] isEqual:@"000000"] ) {
            NSMutableArray *tempArr = [NSMutableArray arrayWithCapacity:0];
            if ([getResult[@"datas"] count] == 0) {
                return ;
            }
            for (NSDictionary *temp in getResult[@"datas"]) {
                MinePrivilageModel *model = [[MinePrivilageModel alloc] initWithDictionary:temp];
                [tempArr addObject:model];
            }
            [self.collectionArr replaceObjectAtIndex:num withObject:tempArr];
            [self.collectionView reloadData];
        }else{
            [self.view makeToast:getResult[@"message"]];
        }
    }];
}
//返回Model
- (void)returnPrivilageModel:(MinePrivilageModel *)model{
    NSDictionary *dict = model.didDatas;
//    yhLevel是2时没有产品参数"goodsId":"1562"
    if ([dict[@"yhLevel"] integerValue] == 2) {
        FoodBussinessListCollectionViewController *foodBusssiness = [[FoodBussinessListCollectionViewController alloc] initWithId:dict[@"did"] andSendPrice:dict[@"startSendPrice"] andDistributionPrice:dict[@"sendPrice"]];
        [self.navigationController pushViewController:foodBusssiness animated:YES];
    }else{//yhLevel是1时还有产品参数"goodsId":"1562"
        [self makeHUd];
        FoodMerchatListItemModel *itemModel = [[FoodMerchatListItemModel alloc] init];
        itemModel.name = model.businessName;
        AFNetworkTwoPackaging *twoPack = [[AFNetworkTwoPackaging alloc] init];
        [twoPack getUrl:[NSString stringWithFormat:MERCHANTPRODUCTDETAIL,dict[@"goodsId"]] andFinishBlock:^(id getResult) {
            [self hudWasHidden:self.hudProgress];
            if ([getResult count] != 0) {
                NSDictionary *dict1 = getResult[0];
               // [{"pid":1449,"name":"苹果","type":"","price":5.0,"imgs":["/Image/nopicture.jpg","/Image/nopicture.jpg","/Image/nopicture.jpg"],"desc":""}]
                itemModel.pid = dict1[@"pid"];
                itemModel.name = dict1[@"name"];
                //itemModel.price = [NSNumber numberWithDouble:[dict[@"price"] doubleValue]];
                itemModel.price = dict1[@"price"];
                itemModel.imgurl = dict1[@"imgs"][0];
                //itemModel.
                if ([dict1[@"desc"] respondsToSelector:@selector(count)]) {
                    itemModel.rule = dict1[@"desc"];
                }else{
                    itemModel.rule = @[];
                }
                FoodMerchantGoodsDeatilViewController *goodsMerchant = [[FoodMerchantGoodsDeatilViewController alloc] initWithItemModel:itemModel andPrudctId:dict[@"goodsId"]];
                goodsMerchant.merchantId = dict[@"did"];
                
                goodsMerchant.target = self;
                goodsMerchant.startPrice = dict[@"startSendPrice"];
                goodsMerchant.disPrice = dict[@"sendPrice"];
                [self.navigationController pushViewController:goodsMerchant animated:YES];
            }else{
                [self.view makeToast:@"网络不好，请换个网络"];
            }
            
        }];
        
        
       
        
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
