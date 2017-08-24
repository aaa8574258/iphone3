//
//  RobOrderCenterViewController.m
//  360du
//
//  Created by linghang on 15/8/15.
//  Copyright (c) 2015年 wangjian. All rights reserved.
//





///                    _ooOoo_
///                   o8888888o
///                   88" . "88
///                   (| -_- |)
///                   O\  =  /O
///                ____/`---'\____
///              .'  \\|     |//  `.
///             /  \\|||  :  |||//  \
///            /  _||||| -:- |||||-  \
///            |   | \\\  -  /// |   |
///            | \_|  ''\---/''  |   |
///            \  .-\__  `-`  ___/-. /
///          ___`. .'  /--.--\  `. . __
///       ."" '<  `.___\_<|>_/___.'  >'"".
///      | | :  `- \`.;`\ _ /`;.`/ - ` : | |
///      \  \ `-.   \_ __\ /__ _/   .-` /  /
/// ======`-.____`-.___\_____/___.-`____.-'======
///                     `=---='
/// ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
///              佛祖保佑       永无BUG

#import "RobOrderCenterViewController.h"
#import "RobOderCollectionViewCell.h"
#import "AFNetworkTwoPackaging.h"
#import "AtOnceRobModel.h"
#import "OrderCenterFinishModel.h"
#import "AddAutoRobViewController.h"
#import "OrderCenterFinishAndUnFinishCell.h"
#import "UIView+Toast.h"
#import "StoreageMessage.h"

#define ROBORDERCELL @"robOrderCell"
@interface RobOrderCenterViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UILabel *statusBtnLab;
@property(nonatomic,weak)UICollectionView *collectionView;
@property (nonatomic ,weak) UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *collectionArr;

@property (nonatomic ,assign) NSInteger *num;


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
    for (NSInteger i = 0; i < 4; i++) {
        [self.collectionArr addObject:@"0"];
    }
}
- (void)loadData{
    AFNetworkTwoPackaging *twoPack = [[AFNetworkTwoPackaging alloc] init];
    [twoPack getUrl:[NSString stringWithFormat:PUSHORDERLIST, [StoreageMessage getMessage][2],100,1] andFinishBlock:^(id getResult) {
        [self hudWasHidden:self.hudProgress];
        NSLog(@"%@",getResult);
        self.collectionArr = [NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *temp in getResult[@"datas"]) {
            OrderCenterFinishModel *model = [[OrderCenterFinishModel alloc] initWithDictionary:temp];
            [self.collectionArr addObject:model];
        }
        [self hudWasHidden:self.hudProgress];
        NSLog(@"%@",self.collectionArr);
        [self.tableView reloadData];
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
//    ,@"自动抢",@"快来抢"
    NSArray *statusArr = @[@"当前消息",@"全部快单"];
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
    self.statusBtnLab.frame = CGRectMake(WIDTH_CONTROLLER / 2 * (statusBtn.tag - 1200), 64 + 39 * self.numSingleVesion, WIDTH_CONTROLLER / 2, 1 * self.numSingleVesion);
//    if ([self.collectionArr[statusBtn.tag - 1200] isEqual:@"0"]) {
        [self requestData:statusBtn.tag - 1200];
//    }
    self.collectionView.contentOffset = CGPointMake(WIDTH_CONTROLLER * (statusBtn.tag - 1200), 0);
    
}
-(void)makeCollectionView{
//    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
//    layout.minimumLineSpacing = 0;
//    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64 + 40 * self.numSingleVesion, WIDTH_CONTROLLER, HEIGHT_CONTROLLER - 64 - 40 * self.numSingleVesion) collectionViewLayout:layout];
//    collectionView.dataSource = self;
//    collectionView.delegate = self;
//    //    collectionView.contentSize = CGSizeMake(WIDTH_CONTROLLER * 3, HEIGHT_CONTROLLER - self.high - 49);
//    collectionView.pagingEnabled = YES;
//    collectionView.showsHorizontalScrollIndicator = NO;
//    [self.view addSubview:collectionView];
//#pragma mark 内存泄露
//    collectionView.backgroundColor = [UIColor whiteColor];
//    [collectionView registerClass:[RobOderCollectionViewCell class] forCellWithReuseIdentifier:ROBORDERCELL];
//    self.collectionView = collectionView;
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64+ 40 *self.numSingleVesion, WIDTH_CONTENTVIEW, HEIGHT_CONTENTVIEW - 64 - 40 *self.numSingleVesion)];
    tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    // Do any additional setup after loading the view.
}
#pragma mark collectionView的代理
//-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
//    return self.collectionArr.count;
//}
//-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
//    //判读一下等于0就不执行下边的方法
//    if ([self.collectionArr[indexPath.row] isEqual:@"0"]) {
//        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ROBORDERCELL forIndexPath:indexPath];
//        return cell;
//    }
//    RobOderCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ROBORDERCELL forIndexPath:indexPath];
//    cell.clickNum = indexPath.row;
//    cell.cellArr = self.collectionArr[indexPath.row];
//    cell.target = self;
//    [cell makeUI];
//    
//    return cell;
//}
//-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
//    return CGSizeMake(WIDTH_CONTROLLER, HEIGHT_CONTROLLER - 64 - 40 * self.numSingleVesion);
//}
//-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
//    UIEdgeInsets set = {0,0,0,0};
//    return set;
//}
//-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//    float everWidth = WIDTH_CONTROLLER / 4;
//    NSInteger num = scrollView.contentOffset.x / WIDTH_CONTROLLER;
//    self.statusBtnLab.frame = CGRectMake(everWidth * num,39 * self.numSingleVesion, everWidth, 1 * self.numSingleVesion);
//    //先清空view
//    //[self reminderView];
//    if ([self.collectionArr[num] isEqual:@"0"]) {
//        [self requestData:num];
//        //[self makeHUd];
//    }
//
//}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.collectionArr.count;
}

-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 88;
}


-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"222"];
//    if (!cell) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"222"];
//    }
//    NSLog(@"%ld",(long)self.num);
//    if (self.num == 1) {
//        OrderCenterFinishAndUnFinishCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderCenterCell"];
//        cell = [[OrderCenterFinishAndUnFinishCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"OrderCenterCell"];
//        OrderCenterFinishModel *model = self.collectionArr[indexPath.row];
//        [cell refreshUI:model andRow:indexPath.row andSection:3];
//        return cell;
//    }else if (self.num == 0) {
        OrderCenterFinishAndUnFinishCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderCenterCell"];
        cell = [[OrderCenterFinishAndUnFinishCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"OrderCenterCell"];
        OrderCenterFinishModel *model = self.collectionArr[indexPath.row];
        [cell refreshUI:model andRow:indexPath.row andSection:3];
    cell.statusBtn.tag = 10086 +indexPath.row;
        [cell.statusBtn addTarget:self action:@selector(statusBtnDown1:) forControlEvents:UIControlEventTouchUpInside];
    
    
//    }
    
    
    
//    self.collectionArr.count > 0;
//
//    cell =OrderCenterFinishAndUnFinishCell *cell = [tableView dequeueReusableCellWithIdentifier:ORDERCENTERCELL forIndexPath:indexPath];
//    OrderCenterFinishModel *model = self.cellArr[indexPath.row];
//    [cell refreshUI:model andRow:indexPath.row andSection:3];
//    return cell;

    
    
    return cell;
}

-(void)statusBtnDown1:(UIButton *) cender{
    OrderCenterFinishModel *model = self.collectionArr[cender.tag - 10086];

    AFNetworkTwoPackaging *twoPacking = [[AFNetworkTwoPackaging alloc] init];
    [twoPacking getUrl:[NSString stringWithFormat:QUICJROBORDERBTN,[StoreageMessage getMessage][2],model.expressId] andFinishBlock:^(id getResult) {
        if (![getResult[@"code"] isEqualToString:@"000000"]) {
            [self.view makeToast:getResult[@"message"]];
        }
        [self.tableView reloadData];
    }];
}

#pragma mark 请求数据
- (void)requestData:(NSInteger)num{
    [self makeHUd];
    AFNetworkTwoPackaging *twoPack = [[AFNetworkTwoPackaging alloc] init];
    NSLog(@"%ld",num);
    
    switch (num) {
        case 1:{
            [twoPack getUrl:ORDERCENTERALL andFinishBlock:^(id getResult) {
                NSLog(@"%@",getResult);
                self.num = 1;
                self.collectionArr = [NSMutableArray arrayWithCapacity:0];
                for (NSDictionary *temp in getResult[@"datas"]) {
                    OrderCenterFinishModel *model = [[OrderCenterFinishModel alloc] initWithDictionary:temp];
                    [self.collectionArr addObject:model];
                }
                [self hudWasHidden:self.hudProgress];
                [self.tableView reloadData];
            }];
            break;
        }
        case 0:{
            [twoPack getUrl:[NSString stringWithFormat:PUSHORDERLIST, [StoreageMessage getMessage][2],100,1] andFinishBlock:^(id getResult) {
                [self hudWasHidden:self.hudProgress];
                NSLog(@"%@",getResult);
                self.num = 0;
                self.collectionArr = [NSMutableArray arrayWithCapacity:0];
                for (NSDictionary *temp in getResult[@"datas"]) {
                    OrderCenterFinishModel *model = [[OrderCenterFinishModel alloc] initWithDictionary:temp];
                    [self.collectionArr addObject:model];
                }
                [self hudWasHidden:self.hudProgress];
                [self.tableView reloadData];
            }];
            break;
        }
//        case 2:{
//            [twoPack getUrl:[NSString stringWithFormat:QUICKROBORDER,[StoreageMessage getMessage][2]] andFinishBlock:^(id getResult) {
//                [self hudWasHidden:self.hudProgress];
//                if ([getResult respondsToSelector:@selector(allKeys)]) {
//                    NSMutableArray *onceArr = [NSMutableArray arrayWithCapacity:0];
//                    for (id temp in getResult[@"datas"]) {
//                        OrderCenterFinishModel *model = [[OrderCenterFinishModel alloc] initWithDictionary:temp];
//                        [onceArr addObject:model];
//                    }
//                    [self.collectionArr replaceObjectAtIndex:num withObject:onceArr];
//                    [self.collectionView reloadData];
//                }
//            }];
//            break;
//        }
//        case 3:{
//            //26227&location=39.8766600000,116.4634490000
//            [twoPack getUrl:[NSString stringWithFormat:ONTHEWAYROBORDER,[StoreageMessage getMessage][2],@"39.8766600000,116.4634490000"] andFinishBlock:^(id getResult) {
//                [self hudWasHidden:self.hudProgress];
//                if ([getResult respondsToSelector:@selector(allKeys)]) {
//                    NSMutableArray *onceArr = [NSMutableArray arrayWithCapacity:0];
//                    for (id temp in getResult[@"datas"]) {
//                        OrderCenterFinishModel *model = [[OrderCenterFinishModel alloc] initWithDictionary:temp];
//                        [onceArr addObject:model];
//                    }
//                    [self.collectionArr replaceObjectAtIndex:num withObject:onceArr];
//                    [self.collectionView reloadData];
//                }
//            }];
//            break;
//        }
        default:
            break;
    }
}
//添加自动抢
//- (void)addAutoRob{
//    AddAutoRobViewController *addAuto = [[AddAutoRobViewController alloc] init];
//    [self.navigationController pushViewController:addAuto animated:YES];
//}
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
