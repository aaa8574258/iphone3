//
//  MerchantSystemSettingViewController.m
//  360du
//
//  Created by linghang on 15/12/17.
//  Copyright © 2015年 wangjian. All rights reserved.
//

#import "MerchantSystemSettingViewController.h"
#import "PersonalFeedbackViewController.h"
#import "AFNetworkTwoPackaging.h"
#import "AbountOurViewController.h"
#import "StoreageMessage.h"
#import "MenberViewController.h"
#define MEMBERCELL @"settingCell"
@interface MerchantSystemSettingViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
@property(nonatomic,weak)UITableView *tableView;
@property(nonatomic,strong)NSArray *dataArr;
@property(nonatomic,strong)NSArray *imgArr;
@property(nonatomic,assign)BOOL swithOn;
@end

@implementation MerchantSystemSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.swithOn = [StoreageMessage jugePersonalStoreMessageState];
    [self makeNav];
    [self laodData];
    [self makeTable];
    // Do any additional setup after loading the view.
}
- (void)makeNav{
    [self setNavBarImage:@"landi.png"];
    //[self setBackgroud:@"lantiao x.png"];
    [self setBackImageStateName:@"fanhuijian02.png" AndHighlightedName:@""];
    //[self setNavTitleItemWithNameAndImage:@"登陆" imageName:@"360.png"];
    [self setNavTitleItemWithName:@"系统设置"];
}
-(void)laodData{
    NSArray *tempArr1 = @[@"订单消息提醒",@"意见反馈"];
    NSArray *tempArr2 = @[@"关于我们",@"400-887-6675",@"退出登录"];
    self.dataArr = @[tempArr1,tempArr2];
    NSArray *imgArr1 = @[@"personal_item2@2x.png",@"personal_item3@2x.png"];
    NSArray *imgArr2 = @[@"personal_item4@2x.png",@"personal_item1@2x.png",@"personal_item6@2x.png"];
    self.imgArr = @[imgArr1,imgArr2];
}
-(void)makeTable{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, WIDTH_CONTROLLER, HEIGHT_CONTROLLER - 64 )style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:tableView];
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:MEMBERCELL];
    self.tableView = tableView;
}
#pragma mark tableview的协议代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataArr[section] count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }
    return 10 * self.numSingleVesion;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50 * self.numSingleVesion;
}
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 45 * self.numSingleVesion;
//}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MEMBERCELL forIndexPath:indexPath];
//    if (!cell) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:MEMBERCELL];
//
//    }
    cell.imageView.image = [UIImage imageNamed:self.imgArr[indexPath.section][indexPath.row]];
    cell.textLabel.text = self.dataArr[indexPath.section][indexPath.row];
    if (indexPath.section == 0 && indexPath.row < 1) {
        UISwitch *switchOn = [[UISwitch alloc] initWithFrame:CGRectMake(WIDTH_CONTROLLER - 40 * self.numSingleVesion, 0, 30 * self.numSingleVesion, 20 * self.numSingleVesion)];
        switchOn.center = CGPointMake(WIDTH_CONTROLLER - 15 * self.numSingleVesion - 30 * self.numSingleVesion, 25 * self.numSingleVesion);
        switchOn.on = self.swithOn;
        [cell.contentView addSubview:switchOn];
        [switchOn addTarget:self action:@selector(switchValueChange:) forControlEvents:UIControlEventValueChanged];

        
    }else if (indexPath.section == 1 && indexPath.row == 1){
        UILabel *lable = [[UILabel alloc] initWithFrame:CGRectZero];
        lable.font = [UIFont systemFontOfSize:13];
        lable.text = @"每天9:00-22:00";
        lable.textColor = SMSColor(211, 211, 211);
        [lable sizeToFit];
        [cell.contentView addSubview:lable];
        lable.center = CGPointMake(WIDTH_CONTROLLER - 10 * self.numSingleVesion - lable.frame.size.width / 2, 25 * self.numSingleVesion);
    }else{
        UIImageView *arrowImg = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH_CONTROLLER - 15 * self.numSingleVesion, 0, 11.5 * self.numSingleVesion, 21.5 * self.numSingleVesion)];
        arrowImg.image = [UIImage imageNamed:@"personal_enter@2x.png"];
        [cell.contentView addSubview:arrowImg];
        arrowImg.center = CGPointMake(WIDTH_CONTROLLER - 15 * self.numSingleVesion - 23 * self.numSingleVesion, 25 * self.numSingleVesion);
        arrowImg.clipsToBounds = YES;
    }


    //cell.backgroundColor = [UIColor lightGrayColor];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 1) {
        PersonalFeedbackViewController *personalFeedBack = [[PersonalFeedbackViewController alloc] init];
        [self.navigationController pushViewController:personalFeedBack animated:YES];
    }else if (indexPath.section == 1 && indexPath.row == 0){
        AbountOurViewController *abountOur = [[AbountOurViewController alloc] init];
        [self.navigationController pushViewController:abountOur animated:YES];
    }else if (indexPath.section == 1 && indexPath.row ==1){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"联系客服" message:@"确定要联系客服吗?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alertView.delegate = self;
        [alertView show];
    }else if (indexPath.section == 1 && indexPath.row == 2){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"退出登录" message:@"确定要退出当前账号吗?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alertView.delegate = self;
        [alertView show];
        alertView.tag = 10000;

    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"%ld",buttonIndex);
    if (alertView.tag == 10000) {
        if (buttonIndex == 1) {
            [StoreageMessage clearMerchantUserNameAndPassword];
            for (UIViewController *controller in self.navigationController.viewControllers) {
                if ([controller isKindOfClass:[MenberViewController class]]) {
                    [self.navigationController popToViewController:controller animated:YES];
                }
            }

            

        }
    }
    if (buttonIndex == 1) {
        NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",self.dataArr[1][1]]];
        
        UIWebView *phoneCallWebView = [[UIWebView alloc] initWithFrame:CGRectZero];//创建一个webView
        [phoneCallWebView loadRequest:[NSURLRequest requestWithURL:phoneURL]];//加载电话url
        [self.view addSubview:phoneCallWebView];

    }
}
//推送开关
-(void)switchValueChange:(UISwitch*)switchView
{
    
    //判断是开还是关，是转还是停
    if(switchView.on)
    {
        [StoreageMessage storePersonalPushMessage:YES];
        self.swithOn = YES;
    }
    else
    {
        [StoreageMessage storePersonalPushMessage:NO];
        self.swithOn = NO;
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
