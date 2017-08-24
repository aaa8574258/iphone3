//
//  ShoppingCarViewController.m
//  360du
//
//  Created by linghang on 15/7/6.
//  Copyright (c) 2015年 wangjian. All rights reserved.
//

#import "ShoppingCarViewController.h"
#import "ShoplistCarCell.h"
#import "ShoplistModel.h"
#import "FoodBussinessListCollectionViewController.h"

#define SHOPLISTCARCELL @"shopListCarCell"
@interface ShoppingCarViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,strong)NSMutableArray *dataModelArr;
@property(nonatomic,weak)UITableView *tableView;
@property(nonatomic,assign)CGRect frame;
@end

@implementation ShoppingCarViewController
-(id)initWithPrice:(NSArray *)priceArr withFrame:(CGRect)frame{
    self = [super init];
    if (self) {
        self.view.bounds = frame;
        self.frame = frame;
        self.dataModelArr = [priceArr mutableCopy];
        self.dataArr  = [NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *temp in priceArr) {
            ShoplistModel *model = [[ShoplistModel alloc] initWithDictionary:temp];
            [self.dataArr addObject:model];
        }
        [self makeTable];
        
    }
    return self;
}
-(void)makeTable{
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.frame style:UITableViewStyleGrouped];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    [tableView registerClass:[ShoplistCarCell class] forCellReuseIdentifier:SHOPLISTCARCELL];
    tableView.showsVerticalScrollIndicator = NO;
    self.tableView = tableView;
    
}
#pragma mark tableView的协议代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ShoplistCarCell *cell = [tableView dequeueReusableCellWithIdentifier:SHOPLISTCARCELL forIndexPath:indexPath];
//    for (id temp in cell.subviews) {
//        [temp removeFromSuperview];
//    }
//    [cell init];
    cell.target = self;
    ShoplistModel *model = self.dataArr[indexPath.row];
    [cell refreshModel:model andRow:indexPath.row];
    //cell.textLabel.text = @"1";
    return cell;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30 * self.numSingleVesion;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER, 30 * self.numSingleVesion)];
    UILabel *leftLable = [[UILabel alloc] initWithFrame:CGRectZero];
    leftLable.textColor = [UIColor lightGrayColor];
    leftLable.font = [UIFont systemFontOfSize:13];
    leftLable.text = @"购物车";
    [view addSubview:leftLable];
    [leftLable sizeToFit];
    leftLable.center = CGPointMake(2 * self.numSingleVesion + leftLable.frame.size.width, 15 * self.numSingleVesion);
    UIButton *clearButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [clearButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [clearButton setTitle:@"清空全部" forState:UIControlStateNormal];
    [clearButton addTarget:self action:@selector(clearAll) forControlEvents:UIControlEventTouchUpInside];
    clearButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [clearButton sizeToFit];
    clearButton.frame = CGRectMake(WIDTH_CONTROLLER - 2 * self.numSingleVesion - clearButton.frame.size.width, 5 * self.numSingleVesion, clearButton.frame.size.width, 20 * self.numSingleVesion);
    clearButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [view addSubview:clearButton];
    return view;
}
-(void)clearAll{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    // Do any additional setup after loading the view.
}
//
-(void)returnAddBtn:(NSInteger)number andAddAndReduce:(NSInteger)addAndReduce{
    ShoplistModel *listModel = self.dataArr[number];
    if ([self.target isKindOfClass:[FoodBussinessListCollectionViewController class]]) {
        if (addAndReduce == 1) {
            for (NSInteger i = 0; i < self.dataArr.count; i++) {
                ShoplistModel *model = self.dataArr[i];
                if ([model isEqual:listModel]) {
//                    model.count.integerValue + 1
                    [self.dataModelArr replaceObjectAtIndex:i withObject:@{@"count":[NSString stringWithFormat:@"%ld",model.count.integerValue + 1],@"model":model.model}];
                    [self.target returnBuyCar:listModel.model andAddAndReduce:[NSString stringWithFormat:@"%ld",addAndReduce] andBuyCount:[NSString stringWithFormat:@"%ld",model.count.integerValue + 1]];

                }
            }
        }else{
            for (NSInteger i = 0; i < self.dataArr.count; i++) {
                ShoplistModel *model = self.dataArr[i];
                if ([model isEqual:listModel]) {
                    //                    model.count.integerValue + 1
                    if (model.count.integerValue != 0) {
                        [self.dataModelArr replaceObjectAtIndex:i withObject:@{@"count":[NSString stringWithFormat:@"%ld",model.count.integerValue - 1],@"model":model.model}];
                        [self.target returnBuyCar:listModel.model andAddAndReduce:[NSString stringWithFormat:@"%ld",addAndReduce] andBuyCount:[NSString stringWithFormat:@"%ld",model.count.integerValue - 1]];

                    }
                    
                }
            }
        }
        //刷新、先清空
        [self.dataArr removeAllObjects];
        for (NSInteger i = 0; i < self.dataModelArr.count; i++) {
            ShoplistModel *model = [[ShoplistModel alloc] initWithDictionary:self.dataModelArr[i]];
            [self.dataArr addObject:model];
        }
        [self.tableView reloadData];
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
