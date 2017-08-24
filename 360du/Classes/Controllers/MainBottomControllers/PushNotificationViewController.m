//
//  PushNotificationViewController.m
//  360du
//
//  Created by 利美 on 16/12/9.
//  Copyright © 2016年 wangjian. All rights reserved.
//

#import "PushNotificationViewController.h"
#import "PushNotificationCell.h"
#import "StoreageMessage.h"
#import "PushModel.h"
#import "FixMasterViewController.h"
#import "FixMasterOneViewController.h"
#import "FixMasterTwoViewController.h"
#import "FixMasterThreeViewController.h"
#import "PropertyNoticeViewController.h"
#import "ProertyMendDeatilViewController.h"
#import "ProertyPayCostViewController.h"
#import "RobOrderCenterViewController.h"
#import "JPUSHService.h"
#import "ProertyNoticeDeatilViewController.h"
@interface PushNotificationViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic ,strong) NSMutableArray *dataArr;
@end

@implementation PushNotificationViewController




- (void)viewDidLoad {
    [super viewDidLoad];

//    else{
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64)];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        [self.view addSubview:self.tableView];
    

//    }
    // Do any additional setup after loading the view.
}


-(void)viewWillAppear:(BOOL)animated{
    //    [StoreageMessage clearPushMessage];
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(WIDTH_CONTROLLER - 32 , (44 - 2) / 2, 20, 30);
    [leftBtn setImage:[UIImage imageNamed:@"fanhuijian2222.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(setBack) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setImageEdgeInsets:UIEdgeInsetsMake(6, 5, 6, 5)];
    UIBarButtonItem *leftSecondItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftSecondItem;
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(WIDTH_CONTROLLER - 80 * self.numSingleVesion, 5, 85 * self.numSingleVesion, 34 * self.numSingleVesion);
    [rightBtn setTitle:@"清空消息" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightAct) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:15 * self.numSingleVesion];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    self.title = @"消息中心";
    self.dataArr = [StoreageMessage getPushMessageFromMemberId:[StoreageMessage getMessage][2]];
    NSLog(@"%@",self.dataArr);
    if (self.dataArr.count == 0) {
        UIImageView *imagev = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width)];
        [imagev setImage:[UIImage imageNamed:@"wushuju.png"]];
        
        imagev.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
        [self.view addSubview:imagev];
        
        [self.tableView removeFromSuperview];
    }

}

-(void)rightAct{
    [StoreageMessage clearPushMessage];
    [StoreageMessage clearBadge];
    [JPUSHService setBadge:0];

    UIImageView *imagev = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width)];
    [imagev setImage:[UIImage imageNamed:@"wushuju.png"]];
    
    imagev.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
    [self.view addSubview:imagev];
    
    [self.tableView removeFromSuperview];
//    [self.tableView reloadData];
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70 *self.numSingleVesion;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PushNotificationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PushCell"];
//    if (!cell) {
        cell = [[PushNotificationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PushCell"];
//    }
    NSLog(@"%lu---%ld----%lu",(unsigned long)self.dataArr.count,(long)indexPath.row,self.dataArr.count - indexPath.row);
    NSDictionary *dic = self.dataArr[self.dataArr.count - indexPath.row - 1];
    NSString*string =[NSString stringWithFormat:@"%@",dic[@"time"]];
//    string = [string substringFromIndex:5];
    cell.messageLab.text = [NSString stringWithFormat:@"%@",dic[@"aps"][@"alert"]];
    cell.timeLab.text = [NSString stringWithFormat:@"%@",string];
    cell.titleLab.text = [NSString stringWithFormat:@"%@",dic[@"title"]];
    NSLog(@"%ld",[dic[@"flag"] integerValue]);
    if ([dic[@"flag"] integerValue] == 1) {
        cell.dianV.backgroundColor  = [UIColor whiteColor];
    }
    return cell;
}

-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [StoreageMessage clearPushMessage];

    NSDictionary *userInfo = self.dataArr[self.dataArr.count - indexPath.row - 1];
    NSLog(@"%@",userInfo[@"goal"]);
    
    NSLog(@"%@",self.dataArr);
//    NSMutableDictionary *newDic = [NSMutableDictionary dictionaryWithCapacity:0];
    NSInteger j = self.dataArr.count - indexPath.row - 1;
    for (NSInteger i = 0; i < self.dataArr.count; i ++) {
        if (i == j) {
            NSDictionary *newDic = self.dataArr[self.dataArr.count - indexPath.row - 1];
            [newDic setValue:@"1" forKey:@"flag"];
        }
        [StoreageMessage storePushMessage1:self.dataArr[i]];
    }
    NSLog(@"%@",[StoreageMessage getPushMessageFromMemberId:[StoreageMessage getMessage][2]]);
    
    


    
    if (userInfo[@"xqid"] == nil) {
        
    }else{
        [StoreageMessage storeCommuntity:userInfo[@"xqname"]];
        [StoreageMessage storeCommuntityId:userInfo[@"xqid"]];
    }

    if ([userInfo[@"goal"] isEqualToString:@"3"]) {
        ProertyPayCostViewController *proerty = [[ProertyPayCostViewController alloc] init];
        proerty.tag = [NSString stringWithFormat:@"5"];
        [self.navigationController pushViewController:proerty animated:YES];
    }else if ([userInfo[@"goal"] isEqualToString:@"4"]){
        ProertyPayCostViewController *proerty = [[ProertyPayCostViewController alloc] init];
        proerty.tag = [NSString stringWithFormat:@"1"];
        [self.navigationController pushViewController:proerty animated:YES];
    }else if ([userInfo[@"goal"] isEqualToString:@"5"]){
        ProertyPayCostViewController *proerty = [[ProertyPayCostViewController alloc] init];
        proerty.tag = [NSString stringWithFormat:@"2"];
        [self.navigationController pushViewController:proerty animated:YES];
    }else if ([userInfo[@"goal"] isEqualToString:@"6"]){
        ProertyPayCostViewController *proerty = [[ProertyPayCostViewController alloc] init];
        proerty.tag = [NSString stringWithFormat:@"3"];
        [self.navigationController pushViewController:proerty animated:YES];
    }else if ([userInfo[@"goal"] isEqualToString:@"7"]){
        ProertyNoticeDeatilViewController *controller = [[ProertyNoticeDeatilViewController alloc] initWithTittle:userInfo[@"anTitle"] andDetial:userInfo[@"anContent"] andTime:userInfo[@"anTime"]];
        [self.navigationController pushViewController:controller animated:YES];
    }else if ([userInfo[@"goal"] isEqualToString:@"8"]){
        ProertyMendDeatilViewController *mendDetail = [[ProertyMendDeatilViewController alloc] initWithProertyMendId:userInfo[@"pbid"]];
        [self.navigationController pushViewController:mendDetail animated:YES];
    }else if ([userInfo[@"goal"] isEqualToString:@"9"]){
        ProertyPayCostViewController *proerty = [[ProertyPayCostViewController alloc] init];
        proerty.tag = [NSString stringWithFormat:@"4"];
        [self.navigationController pushViewController:proerty animated:YES];
    }else if ([userInfo[@"goal"] isEqualToString:@"1"]){
        RobOrderCenterViewController *controller = [[RobOrderCenterViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
        
    }else if ([userInfo[@"goal"] isEqualToString:@"10"]){
        FixMasterViewController *pageVC = [[FixMasterViewController alloc] initWithViewControllerClasses:@[[FixMasterOneViewController class],[FixMasterTwoViewController class],[FixMasterThreeViewController class]] andTheirTitles:@[@"未完成",@"已完成",@"未委派任务"]];
        pageVC.pageAnimatable = YES;
        pageVC.menuItemWidth = self.view.frame.size.width/3;
        pageVC.menuHeight = 45;
        pageVC.postNotification = YES;
        //                    pageVC.menuView.frame.origin.y == 200;
        //                    pageVC.menuBGColor = [UIColor whiteColor];
        pageVC.bounces = YES;
        //                    pageVC.menuView.frame = CGRectMake(20, 200, self.view.frame.size.width, 45 *self.numSingleVesion);
        pageVC.title = @"维修师傅";
        [self.navigationController pushViewController:pageVC animated:YES];
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
