//
//  UniversalViewController.m
//  360du
//
//  Created by 利美 on 16/6/15.
//  Copyright © 2016年 wangjian. All rights reserved.
//

#import "UniversalViewController.h"
#import "RentSSModel.h"
#import "CleanerViewController.h"
#import "RentSearchViewController.h"
#import "NSString+URLEncoding.h"
#import "AFURLRequestSerialization.h"

@interface UniversalViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong) NSMutableArray *nameArr;
@property (nonatomic ,strong) NSMutableArray *codeArr;
@property (nonatomic ,copy) NSString *url;
@end

@implementation UniversalViewController

- (instancetype)initWithUrl:(NSString *)url
{
    self = [super init];
    if (self) {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"0.png"] forBarMetrics:UIBarMetricsDefault];
        UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        leftBtn.frame = CGRectMake(WIDTH_CONTROLLER - 32 , (44 - 2) / 2, 25, 25);
        [leftBtn setImage:[UIImage imageNamed:@"fanhuijian2222.png"] forState:UIControlStateNormal];
        [leftBtn addTarget:self action:@selector(setBack) forControlEvents:UIControlEventTouchUpInside];
        [leftBtn setImageEdgeInsets:UIEdgeInsetsMake(6, 5, 6, 5)];
        UIBarButtonItem *leftSecondItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
        self.navigationItem.leftBarButtonItem = leftSecondItem;
        self.url = url;
        [self reloadDataFromURL:self.url];
    }
    return self;
}

-(void)reloadDataFromURL:(NSString *)url{
    if ([url isEqualToString:@"guiZe"]) {
        [self.tabelView removeFromSuperview];
        
//        [self guiZeReload];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(8, 100, WIDTH_CONTENTVIEW - 16, self.view.frame.size.height - 100)];
        label.text = @"    预付订金：100%提交订单后，支付总房费的100%作为预付订金交付平台 以下费用由房东线下额外收取，不包含在房费中。 加床：不收费做饭：不收费无调料清洁费：不收取清洁费通常由房东一次性收取。 如果入住过程中需要清扫产生额外费用，请参考房东相关规定。 温馨提示：房东提供的服务可能会收费，不在以上费用中。请谨慎核对，以免发生纠纷";
        label.numberOfLines = 0;
        [label sizeToFit];
        [self.view addSubview:label];
        
        
    }else if ([url isEqualToString:@"floorCount"]) {
        _nameArr = [[NSMutableArray alloc] initWithObjects:@"不限",@"一层",@"两层",@"三层",@"四层",@"四层以上", nil];
        _codeArr = [[NSMutableArray alloc] initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5", nil];
        [self.tabelView reloadData];
    }else if ([url isEqualToString:@"from"]) {
        _nameArr = [[NSMutableArray alloc] initWithObjects:@"不限",@"个人",@"物业", nil];
        _codeArr = [[NSMutableArray alloc] initWithObjects:@"0",@"1",@"2", nil];
        [self.tabelView reloadData];
    }else if ([url isEqualToString:@"rentRoomCount"]) {
        _nameArr = [[NSMutableArray alloc] initWithObjects:@"不限",@"一室",@"两室",@"三室",@"四室",@"四室以上", nil];
        _codeArr = [[NSMutableArray alloc] initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5", nil];
        [self.tabelView reloadData];
    }else if ([url isEqualToString:@"rentMoneyChoose"]) {
        _nameArr = [[NSMutableArray alloc] initWithObjects:@"不限",@"600元以下",@"600-1000元",@"1000-1500元",@"1500-2000元",@"2000-3000元", @"3000-5000元",@"5000-8000元",@"8000元以上", nil];
        _codeArr = [[NSMutableArray alloc] initWithObjects:@"0",@"0-600",@"600-1000",@"1000-1500",@"1500-2000",@"2000-3000",@"3000-5000",@"5000-8000",@"8000-0", nil];
        [self.tabelView reloadData];
    }else if([url isEqualToString:@"yjfs"]) {
        _nameArr = [[NSMutableArray alloc]initWithObjects:@"不限",@"押一付一",@"押一付三", nil];
        _codeArr = [[NSMutableArray alloc] initWithObjects:@"0",@"1",@"2", nil];
        [self.tabelView reloadData];
    }else if ([url isEqualToString:@"dzfp"]) {
        _nameArr = [[NSMutableArray alloc]initWithObjects:@"提供",@"不提供", nil];
        _codeArr = [[NSMutableArray alloc] initWithObjects:@"1",@"2", nil];
        [self.tabelView reloadData];
    }else if([url isEqualToString:@"dzzf"]) {
        _nameArr = [[NSMutableArray alloc]initWithObjects:@"能",@"不能", nil];
        _codeArr = [[NSMutableArray alloc] initWithObjects:@"1",@"2", nil];
        [self.tabelView reloadData];
    }else{
        AFNetworkTwoPackaging *twoPacking = [[AFNetworkTwoPackaging alloc] init];
        [twoPacking getUrl:url andFinishBlock:^(id getResult) {
//            NSLog(@"%@",getResult);
            _nameArr = [NSMutableArray arrayWithCapacity:0];
            _codeArr = [NSMutableArray arrayWithCapacity:0];
            if ([getResult[@"code"] isEqualToString:@"000000"]) {
                for (NSMutableDictionary *dic in getResult[@"datas"]) {
                    RentSSModel *model = [[RentSSModel alloc]initWithDictionary:dic];
                    [_nameArr addObject:model.CodeName];
                    [_codeArr addObject:model.CodeValue];
//                    NSLog(@"%@",model.CodeName);
                }
            }
            [self.tabelView reloadData];
    }];

    }
}



-(void) guiZeReload{
//    AFNetworkTwoPackaging *twoPacking = [[AFNetworkTwoPackaging alloc] init];
//    NSString *str = @"http://www.360duang.net/360duang/360du/rule.json";
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    //发送网络请求
//    [manager GET:@"http://www.360duang.net/360duang/360du/rule.json" parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"responseObject==%@,%@",responseObject,[NSThread currentThread]);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"error==%@",error);
//    }];


}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (![self.url isEqualToString:@"guiZe"]) {
    self.tabelView = [[UITableView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:self.tabelView];
    self.tabelView.delegate = self;
    self.tabelView.dataSource = self;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"landi.png"] forBarMetrics:UIBarMetricsDefault];
    }
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(WIDTH_CONTROLLER - 32 , (44 - 2) / 2, 30, 40);
    [leftBtn setImage:[UIImage imageNamed:@"返回.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(setBack) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setImageEdgeInsets:UIEdgeInsetsMake(6, 5, 6, 5)];
    UIBarButtonItem *leftSecondItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftSecondItem;
    // Do any additional setup after loading the view.
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellStr = @"cell_UniversalViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
    }
    cell.textLabel.center = cell.contentView.center;
    cell.textLabel.textAlignment = UITextAlignmentCenter;
    cell.textLabel.text = self.nameArr[indexPath.row];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.nameArr.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.target isKindOfClass:[RentSearchViewController class]]) {
        if ([self.url isEqualToString:@"rentMoneyChoose"]) {
            [self.target returnRentyjName:self.nameArr[indexPath.row] andCode:self.codeArr[indexPath.row]];
        }if ([self.url isEqualToString:@"rentRoomCount"]) {
            [self.target returnRenthxName:self.nameArr[indexPath.row] andCode:self.codeArr[indexPath.row]];
        }if ([self.url isEqualToString:@"from"]) {
            [self.target returnRentlyName:self.nameArr[indexPath.row] andCode:self.codeArr[indexPath.row]];
        }
        
        
        if ([self.url isEqualToString:[NSString stringWithFormat:RENTPUBLISHSS,@"ZHHouseType"]]) {
            [self.target returnRentlxName:self.nameArr[indexPath.row] andCode:self.codeArr[indexPath.row]];
        }
        if ([self.url isEqualToString:RENTDZHOMETYPE]) {
            [self.target returnRentlxName:self.nameArr[indexPath.row] andCode:self.codeArr[indexPath.row]];
        }
        
        
        if ([self.url isEqualToString:@"floorCount"]) {
            [self.target returnRentlcName:self.nameArr[indexPath.row] andCode:self.codeArr[indexPath.row]];
        }if ([self.url isEqualToString:[NSString stringWithFormat:RENTPUBLISHSS,@"face"]]) {
            [self.target returnRentcxName:self.nameArr[indexPath.row] andCode:self.codeArr[indexPath.row]];
        }
        [self.navigationController popViewControllerAnimated:YES];

    }else{
//    if ([self.target isKindOfClass:[RentPublishViewController class]]) {
        if ([self.url isEqualToString:@"yjfs"]) {
            [self.target returnyjfsWithName:self.nameArr[indexPath.row] andcode:self.codeArr[indexPath.row]];
        }
        if ([self.url isEqualToString:[NSString stringWithFormat:RENTPUBLISHSS,@"ZHHouseType"]]) {
            [self.target returnfwlxWithName:self.nameArr[indexPath.row] andcode:self.codeArr[indexPath.row]];
        }
        if ([self.url isEqualToString:[NSString stringWithFormat:RENTPUBLISHSS,@"face"]]) {
            [self.target returnfaceWithName:self.nameArr[indexPath.row] andcode:self.codeArr[indexPath.row]];
        }
        if ([self.url isEqualToString:[NSString stringWithFormat:RENTPUBLISHSS,@"RoommateType"]]) {
            [self.target returnhzWithName:self.nameArr[indexPath.row] andcode:self.codeArr[indexPath.row]];
        }
        if ([self.url isEqualToString:RENTDZHOMETYPE]) {
            [self.target returnfwlxWithName:self.nameArr[indexPath.row] andcode:self.codeArr[indexPath.row]];
        }
        if ([self.url isEqualToString:@"dzfp"]) {
            [self.target returndzfpWithName:self.nameArr[indexPath.row] andcode:self.codeArr[indexPath.row]];
        }if ([self.url isEqualToString:@"dzzf"]) {
            [self.target returndzzfWithName:self.nameArr[indexPath.row] andcode:self.codeArr[indexPath.row]];
        }

        if ([self.url isEqualToString:@"rentMoneyChoose"]) {
//            NSLog(@"%@",self.target);
            [self.target returnchooseAddrbuttonTitle:self.nameArr[indexPath.row] andCode:self.codeArr[indexPath.row]];
        }
        if ([self.url isEqualToString:@"rentRoomCount"]) {
//            NSLog(@"%@",self.target);
            [self.target returnchoosePaibuttonTitle:self.nameArr[indexPath.row] andCode:self.codeArr[indexPath.row]];
        }
        
        [self.navigationController popViewControllerAnimated:YES];
//    }

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
