//
//  LogisticsViewController.m
//  360du
//
//  Created by 利美 on 16/8/23.
//  Copyright © 2016年 wangjian. All rights reserved.
//

#import "LogisticsViewController.h"
#import "StoreageMessage.h"
#import "LogistiscModel.h"
@interface LogisticsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic , strong) NSMutableArray *dataArr;
@property (nonatomic ,copy) NSString *codeName;
@property (nonatomic ,copy) NSString *expNo;
@end

@implementation LogisticsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self makeHUd];
    [self setNavBarImage:@"landi.png"];
    //[self setBackgroud:@"lantiao x.png"];
    [self setBackImageStateName:@"fanhuijian02.png" AndHighlightedName:@""];
    
    
    [self getMessage];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    // Do any additional setup after loading the view.
}


-(void)viewWillAppear:(BOOL)animated{
    NSLog(@"%@",self.imageUrl);
}




-(void)getMessage{
    self.dataArr = [NSMutableArray arrayWithCapacity:0];
    AFNetworkTwoPackaging *twoPack = [[AFNetworkTwoPackaging alloc] init];
    NSString *url = nil;
    url = [NSString stringWithFormat:LOGISTICS,self.cpid];
//    NSLog(@"1212%@",url);
    
    [twoPack getUrl:url andFinishBlock:^(id getResult) {
        NSLog(@"getResult::%@",getResult);
        [self hudWasHidden:self.hudProgress];
       
//        [model setValue:model.codeName forKey:getResult[@"codeName"]];
//        [model setValue:model.expNo forKey:getResult[@"expNo"]];
        for (NSDictionary *dic in getResult[@"datas"]) {
             LogistiscModel *model = [[LogistiscModel alloc] initWithDictionary:dic];
            [self.dataArr addObject:model];

        }

        self.codeName = getResult[@"codeName"];
        self.expNo = getResult[@"expNo"];
    
        [self.tableView reloadData];
    }];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cxwl"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cxwl1"];
    }
    
    if (indexPath.section == 0) {
        if (self.codeName == nil) {
            self.codeName = @"";
        }
        if (self.expNo == nil) {
            self.expNo = @"";
        }
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 80, 80)];
        [imageView sd_setImageWithURL:[NSURL URLWithString:self.imageUrl]];
        [cell.contentView addSubview:imageView];
        UILabel *lab1 = [[UILabel alloc] initWithFrame:CGRectMake(120, 20, 200, 30)];
        lab1.text = @"物流状态:";
        [cell.contentView addSubview:lab1];
        UILabel *lab2 = [[UILabel alloc] initWithFrame:CGRectMake(120, 50, 200, 30)];
        lab2.text = [NSString stringWithFormat:@"承运公司:%@",self.codeName];
        lab2.font = [UIFont systemFontOfSize:15];
        lab2.textColor = [UIColor lightGrayColor];
        [cell.contentView addSubview:lab2];
        UILabel *lab3 = [[UILabel alloc] initWithFrame:CGRectMake(120, 80, 200, 30)];
        lab3.text = [NSString stringWithFormat:@"运单编号:%@",self.expNo];
        lab3.font = [UIFont systemFontOfSize:15];
        lab3.textColor = [UIColor lightGrayColor];
        [cell.contentView addSubview:lab3];
        
    }
    if (indexPath.section == 1) {
        LogistiscModel *model = self.dataArr[indexPath.row];
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, WIDTH_CONTENTVIEW-40, 40)];
        label1.numberOfLines = 0;
        label1.text = model.AcceptStation;
        label1.font = [UIFont systemFontOfSize:15];
        label1.textColor = [UIColor lightGrayColor];
        [cell.contentView addSubview:label1];
        UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(20, 50, WIDTH_CONTENTVIEW-40, 30)];
        label2.text = model.AcceptTime;
        label2.font = [UIFont systemFontOfSize:15];
        label2.textColor = [UIColor lightGrayColor];
        [cell.contentView addSubview:label2];
        
    }
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
//        NSLog(@"%lu",(unsigned long)self.dataArr.count);
        return self.dataArr.count;
        }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return 10;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 120;
    }
    return 100;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
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
