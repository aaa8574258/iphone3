//
//  PropertyNoticeViewController.m
//  360du
//
//  Created by linghang on 15/7/18.
//  Copyright (c) 2015年 wangjian. All rights reserved.
//

#import "PropertyNoticeViewController.h"
#import "PropertyNoticeModel.h"
#import "StoreageMessage.h"
#define PROERTYNOTICECELL @"proertyNoticeCell"
@interface PropertyNoticeViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,weak)UITableView *tableView;
@end

@implementation PropertyNoticeViewController
-(id)init{
    self = [super init];
    if (self) {
        self.dataArr = [NSMutableArray arrayWithCapacity:0];
        [self makeNav];
        [self loadData];
        [self makeTab];
    }
    return self;
}
-(void)makeNav{
    [self setNavBarImage:@"landi.png"];
    //[self setBackgroud:@"lantiao x.png"];
    [self setBackImageStateName:@"fanhuijian02.png" AndHighlightedName:@""];
    
    
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    //view.backgroundColor = MAINVIEWNAVBARCOLOR;
    //[self.view addSubview:view];
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectZero];
    lable.text = @"物业公告";
    lable.font = [UIFont systemFontOfSize:16 * self.numSingleVesion];
    lable.textColor = [UIColor whiteColor];
    [lable sizeToFit];
    lable.frame = CGRectMake(5 * self.numSingleVesion, 0 + (44 - 15) / 2, lable.frame.size.width, 15);
    [view addSubview:lable];
    view.frame = CGRectMake(0, 0, lable.frame.size.width, 44);
    //UIBarButtonItem *centerBar = [[UIBarButtonItem alloc] initWithCustomView:view];
    self.navigationItem.titleView = view;
}
-(void)loadData{
    [self makeHUd];
    AFNetworkTwoPackaging *twoPage = [[AFNetworkTwoPackaging alloc] init];
    [twoPage getUrl:[NSString stringWithFormat:PROERTYNOTICE,[StoreageMessage getCommuntityId]] andFinishBlock:^(id getResult) {
        
        [self hudWasHidden:self.hudProgress];
        for (id temp in getResult[@"datas"]) {
            PropertyNoticeModel *model = [[PropertyNoticeModel alloc] initWithDictionary:temp];
            [self.dataArr addObject:model];
        }
        [self.tableView reloadData];
    }];
}
-(void)makeTab{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, WIDTH_CONTROLLER, HEIGHT_CONTROLLER - 64) style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:PROERTYNOTICECELL];
    tableView.showsVerticalScrollIndicator = NO;
    self.tableView = tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    // Do any additional setup after loading the view.
}
#pragma mark tableView的代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50 * self.numSingleVesion;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PROERTYNOTICECELL forIndexPath:indexPath];
    [cell initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:indexPath];
    PropertyNoticeModel *model = self.dataArr[indexPath.row];
    cell.textLabel.text = model.anTitle;
    cell.detailTextLabel.text = model.anContent;
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:13];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
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
