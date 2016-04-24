//
//  RobOrderCenterViewController.m
//  360du
//
//  Created by linghang on 15/8/15.
//  Copyright (c) 2015年 wangjian. All rights reserved.
//

#import "RobOrderCenterViewController.h"
#import "RobOderCollectionViewCell.h"
#import "AFNetworkTwoPackaging.h"
#import "AtOnceRobModel.h"
#import "OrderCenterFinishModel.h"
#import "AddAutoRobViewController.h"
#import "StoreageMessage.h"

#define ROBORDERCELL @"robOrderCell"
@interface RobOrderCenterViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong)UILabel *statusBtnLab;
@property(nonatomic,weak)UICollectionView *collectionView;
@property(nonatomic,strong)NSMutableArray *collectionArr;
@end

@implementation RobOrderCenterViewController
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
    [twoPack getUrl:[NSString stringWithFormat:ATONCEROBORDER, [StoreageMessage getMessage][2],@"4"] andFinishBlock:^(id getResult) {
        [self hudWasHidden:self.hudProgress];
    }];
}
-(void)makeNav{
    [self setNavBarImage:@"landi.png"];
    //[self setBackgroud:@"lantiao x.png"];
    [self setBackImageStateName:@"fanhuijian02.png" AndHighlightedName:@""];
    
    [self setNavTitleItemWithName:@"抢单中心"];
}
-(void)makeUI{
    [self makeFourHeadBtn];
    [self makeCollectionView];
}
- (void)makeFourHeadBtn{
    NSArray *statusArr = @[@"赶快抢",@"自动抢",@"快来抢",@"顺路快单"];
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
    self.statusBtnLab.frame = CGRectMake(WIDTH_CONTROLLER / 4 * (statusBtn.tag - 1200), 64 + 39 * self.numSingleVesion, WIDTH_CONTROLLER / 4, 1 * self.numSingleVesion);
    if ([self.collectionArr[statusBtn.tag - 1200] isEqual:@"0"]) {
        [self requestData:statusBtn.tag - 1200];
    }
    self.collectionView.contentOffset = CGPointMake(WIDTH_CONTROLLER * (statusBtn.tag - 1200), 0);
    
}
-(void)makeCollectionView{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    layout.minimumLineSpacing = 0;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64 + 40 * self.numSingleVesion, WIDTH_CONTROLLER, HEIGHT_CONTROLLER - 64 - 40 * self.numSingleVesion) collectionViewLayout:layout];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    //    collectionView.contentSize = CGSizeMake(WIDTH_CONTROLLER * 3, HEIGHT_CONTROLLER - self.high - 49);
    collectionView.pagingEnabled = YES;
    collectionView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:collectionView];
#pragma mark 内存泄露
    collectionView.backgroundColor = [UIColor whiteColor];
    [collectionView registerClass:[RobOderCollectionViewCell class] forCellWithReuseIdentifier:ROBORDERCELL];
    self.collectionView = collectionView;
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
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ROBORDERCELL forIndexPath:indexPath];
        
        return cell;
    }
    RobOderCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ROBORDERCELL forIndexPath:indexPath];
    cell.clickNum = indexPath.row;
    cell.cellArr = self.collectionArr[indexPath.row];
    cell.target = self;
    [cell makeUI];
    
    return cell;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(WIDTH_CONTROLLER, HEIGHT_CONTROLLER - 64 - 40 * self.numSingleVesion);
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    UIEdgeInsets set = {0,0,0,0};
    return set;
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    float everWidth = WIDTH_CONTROLLER / 4;
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
    switch (num) {
        case 0:{
            [twoPack getUrl:[NSString stringWithFormat:ATONCEROBORDER, [StoreageMessage getMessage][2],@"4"] andFinishBlock:^(id getResult) {
                [self hudWasHidden:self.hudProgress];
            }];
            break;
        }
        case 1:{
            [twoPack getUrl:[NSString stringWithFormat:AUTOROBORDER,[StoreageMessage getMessage][2]] andFinishBlock:^(id getResult) {
                [self hudWasHidden:self.hudProgress];
                if ([getResult respondsToSelector:@selector(allKeys)]) {
                    NSMutableArray *onceArr = [NSMutableArray arrayWithCapacity:0];
                    for (id temp in getResult[@"datas"]) {
                        AutoRobModel *model = [[AutoRobModel alloc] initWithDictionary:temp];
                        [onceArr addObject:model];
                    }
                    [self.collectionArr replaceObjectAtIndex:num withObject:onceArr];
                    [self.collectionView reloadData];
                }
            }];
            break;
        }
        case 2:{
            [twoPack getUrl:[NSString stringWithFormat:QUICKROBORDER,[StoreageMessage getMessage][2]] andFinishBlock:^(id getResult) {
                [self hudWasHidden:self.hudProgress];
                if ([getResult respondsToSelector:@selector(allKeys)]) {
                    NSMutableArray *onceArr = [NSMutableArray arrayWithCapacity:0];
                    for (id temp in getResult[@"datas"]) {
                        OrderCenterFinishModel *model = [[OrderCenterFinishModel alloc] initWithDictionary:temp];
                        [onceArr addObject:model];
                    }
                    [self.collectionArr replaceObjectAtIndex:num withObject:onceArr];
                    [self.collectionView reloadData];
                }
            }];
            break;
        }
        case 3:{
            //26227&location=39.8766600000,116.4634490000
            [twoPack getUrl:[NSString stringWithFormat:ONTHEWAYROBORDER,[StoreageMessage getMessage][2],@"39.8766600000,116.4634490000"] andFinishBlock:^(id getResult) {
                [self hudWasHidden:self.hudProgress];
                if ([getResult respondsToSelector:@selector(allKeys)]) {
                    NSMutableArray *onceArr = [NSMutableArray arrayWithCapacity:0];
                    for (id temp in getResult[@"datas"]) {
                        OrderCenterFinishModel *model = [[OrderCenterFinishModel alloc] initWithDictionary:temp];
                        [onceArr addObject:model];
                    }
                    [self.collectionArr replaceObjectAtIndex:num withObject:onceArr];
                    [self.collectionView reloadData];
                }
            }];
            break;
        }
        default:
            break;
    }
}
//添加自动抢
- (void)addAutoRob{
    AddAutoRobViewController *addAuto = [[AddAutoRobViewController alloc] init];
    [self.navigationController pushViewController:addAuto animated:YES];
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
