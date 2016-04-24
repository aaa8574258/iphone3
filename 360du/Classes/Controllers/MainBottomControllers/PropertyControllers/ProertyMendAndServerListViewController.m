//
//  ProertyMendAndServerListViewController.m
//  360du
//
//  Created by linghang on 15/7/19.
//  Copyright (c) 2015年 wangjian. All rights reserved.
//

#import "ProertyMendAndServerListViewController.h"
#import "PropertyMendAndServiceListModel.h"
#import "ProertyMendAndServiecListCell.h"
#import "CommitOrderViewController.h"
#import "FileOperation.h"
#import "ProertyAddMendAndServerViewController.h"
#import "ProertyMendDeatilViewController.h"
#define PROERTYMENDANDSERVIECLISTCEL @"proertyMendAndServiceListCell"
@interface ProertyMendAndServerListViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,strong)NSMutableArray *imageAndVoiceAndVideoArr;
@property(nonatomic,strong)NSMutableArray *imageAndVoiceAndVideoHeightArr;
@property(nonatomic,weak)UITableView *tableView;
@end

@implementation ProertyMendAndServerListViewController
-(id)initWithUrl:(NSString *)url andNavTitle:(NSString *)title{
    self = [super init];
    if (self) {
        //[self makeUI]
        self.dataArr = [NSMutableArray arrayWithCapacity:0];
        self.imageAndVoiceAndVideoArr = [NSMutableArray arrayWithCapacity:0];
        self.imageAndVoiceAndVideoHeightArr = [NSMutableArray arrayWithCapacity:0];
        [self loadData:url];
        [self makeNav:title];
        [self makeTable];
    }
    return self;
    
}
-(void)makeNav:(NSString *)navTitle{
    [self setNavBarImage:@"landi.png"];
    //[self setBackgroud:@"lantiao x.png"];
    [self setBackImageStateName:@"fanhuijian02.png" AndHighlightedName:@""];
    
    
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    //view.backgroundColor = MAINVIEWNAVBARCOLOR;
    //[self.view addSubview:view];
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectZero];
    lable.text = navTitle;
    lable.font = [UIFont systemFontOfSize:16 * self.numSingleVesion];
    lable.textColor = [UIColor whiteColor];
    [lable sizeToFit];
    lable.frame = CGRectMake(5 * self.numSingleVesion, 0 + (44 - 15) / 2, lable.frame.size.width, 15);
    [view addSubview:lable];
    view.frame = CGRectMake(0, 0, lable.frame.size.width, 44);
    //UIBarButtonItem *centerBar = [[UIBarButtonItem alloc] initWithCustomView:view];
    self.navigationItem.titleView = view;
    
    
    UIButton *commit = [UIButton buttonWithType:UIButtonTypeCustom];
    commit.frame = CGRectMake(WIDTH_CONTROLLER - 60 * self.numSingleVesion, 5 * self.numSingleVesion, 50 * self.numSingleVesion, 34 * self.numSingleVesion);
    [commit setTitle:@"新增" forState:UIControlStateNormal];
    [commit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [commit addTarget:self action:@selector(commitBtnDown:) forControlEvents:UIControlEventTouchUpInside];
    commit.titleLabel.font = [UIFont systemFontOfSize:15];
    
    UIBarButtonItem *commitItem = [[UIBarButtonItem alloc] initWithCustomView:commit];
    self.navigationItem.rightBarButtonItem = commitItem;
}
-(void)commitBtnDown:(UIButton *)commitBtn{
    ProertyAddMendAndServerViewController *proertyAddMendAndServer = [[ProertyAddMendAndServerViewController alloc] initWithNavTitle:@"维修列表"];
    proertyAddMendAndServer.classification = [NSString stringWithFormat:@"%ld",self.classId];
    proertyAddMendAndServer.baseType = [NSString stringWithFormat:@"%ld",self.tag];
    [self.navigationController pushViewController:proertyAddMendAndServer animated:YES];
}
-(void)makeTable{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, WIDTH_CONTROLLER, HEIGHT_CONTROLLER - 64) style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    [tableView registerClass:[ProertyMendAndServiecListCell class] forCellReuseIdentifier:PROERTYMENDANDSERVIECLISTCEL];
    tableView.showsVerticalScrollIndicator = NO;
    self.tableView = tableView;
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    // Do any additional setup after loading the view.
}
-(void)loadData:(NSString *)url{
    [self makeHUd];
    AFNetworkTwoPackaging *twoPack = [[AFNetworkTwoPackaging alloc] init];
    [twoPack getUrl:url andFinishBlock:^(id getResult) {
        [self hudWasHidden:self.hudProgress];
        for (NSInteger i = 0; i < [getResult[@"datas"] count]; i++) {
            PropertyMendAndServiceListModel *model = [[PropertyMendAndServiceListModel alloc] initWithDictionary:getResult[@"datas"][i]];
            [self.dataArr addObject:model];
            NSInteger imageCount = 0;
            NSInteger voiceCount = 0;
            NSInteger videoCount = 0;
            NSMutableArray *imageArr = [NSMutableArray arrayWithCapacity:0];
            NSMutableArray *voiceArr = [NSMutableArray arrayWithCapacity:0];
            NSMutableArray *videoArr = [NSMutableArray arrayWithCapacity:0];
            CGFloat allHeight = 0;
//            for (NSInteger i = 0; i < model.url.count; i++) {
//                if ([model.url[i] hasSuffix:@"jpg"] || [model.url[i] hasSuffix:@"png"]) {
//                    imageCount++;
//                    [imageArr addObject:model.url[i]];
//                }else if ([model.url[i] hasSuffix:@"video"]){
//                    videoCount++;
//                    [videoArr addObject:model.url[i]];
//                }else{
//                    voiceCount++;
//                    [voiceArr addObject:model.url[i]];
//                }
//                
//            }
            allHeight += 15 * self.numSingleVesion;
            //文字高度
            NSString *content = model.repairTime;
            if(model.RepairContent.length != 0){
                content = [NSString stringWithFormat:@"%@  %@",model.repairTime,model.RepairContent];
            }
            allHeight += [self returnCellHeight:content];
            allHeight += 15 * self.numSingleVesion;
            //图片高度
            if(model.images.count != 0){
                allHeight += 72 * self.numSingleVesion;
                allHeight += 15 * self.numSingleVesion;
                for (NSInteger i = 0; i < model.images.count; i++) {
                    [imageArr addObject:model.images[i]];
                }
            }
            if (model.voices.count != 0){
                allHeight += 34 * self.numSingleVesion;
                allHeight += 15 * self.numSingleVesion;
                [voiceArr addObject:model.voices[0]];
            }
            if (model.videos.count != 0) {
                allHeight += 34 * self.numSingleVesion;
                allHeight += 15 * self.numSingleVesion;
                [videoArr addObject:model.videos[0]];
            }
            [self.imageAndVoiceAndVideoArr addObject:@[[NSString stringWithFormat:@"%lf",[self returnCellHeight:content]],imageArr,voiceArr,videoArr]];
            [self.imageAndVoiceAndVideoHeightArr addObject:[NSString stringWithFormat:@"%lf",allHeight]];
        }
        [self.tableView reloadData];
    }];
}
#pragma mark tableView的协议代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self.imageAndVoiceAndVideoHeightArr[indexPath.row] integerValue];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ProertyMendAndServiecListCell *cell = [tableView dequeueReusableCellWithIdentifier:PROERTYMENDANDSERVIECLISTCEL forIndexPath:indexPath];
    for (id temp in cell.subviews) {
        [temp removeFromSuperview];
    }
    [cell init];
    PropertyMendAndServiceListModel *model = self.dataArr[indexPath.row];
    [cell makeUI:model andImageAndVoiceAndVideo:self.imageAndVoiceAndVideoArr[indexPath.row]];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PropertyMendAndServiceListModel *model = self.dataArr[indexPath.row];
    ProertyMendDeatilViewController *mendDetail = [[ProertyMendDeatilViewController alloc] initWithProertyMendId:model.pbID];
    [self.navigationController pushViewController:mendDetail animated:YES];
}
#pragma mark 计算每一个cell的高度
-(CGFloat)returnCellHeight:(NSString *)contentRepaire{
    CGFloat width = WIDTH_CONTROLLER - 45 * self.numSingleVesion;
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
    CGRect rect = [contentRepaire boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    
    return rect.size.height;
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
