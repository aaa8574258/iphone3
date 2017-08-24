//
//  DRentDetialViewController.m
//  360du
//
//  Created by 利美 on 16/6/23.
//  Copyright © 2016年 wangjian. All rights reserved.
//

#import "DRentDetialViewController.h"
#import "RentZHDetialModel.h"
#import "SDCycleScrollView.h"
#import "UIView+Toast.h"
#import "ZFChooseTimeViewController.h"
#import "DRentGoToPayViewController.h"
#import "UniversalViewController.h"
#import "StoreageMessage.h"
#import "LogInViewController.h"
@interface DRentDetialViewController ()<SDCycleScrollViewDelegate>
@property (nonatomic ,strong) NSMutableArray *data;
@property (nonatomic ,strong) NSMutableArray *imageData;
@property (nonatomic ,copy) NSString *StarTime;
@property (nonatomic ,copy) NSString *EndTime;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ScroViewHeight;

@end

@implementation DRentDetialViewController

- (void)viewDidLoad {
    [self makeHUd];
    //字体局右
    [self.ckrlBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [self.ckgzBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [super viewDidLoad];
    NSLog(@"%@",self.houseId);
    [self getImageInfo];

    self.title = @"房屋详情";
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"0.png"] forBarMetrics:UIBarMetricsDefault];
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(WIDTH_CONTROLLER - 32 , (44 - 2) / 2, 25, 25);
    [leftBtn setImage:[UIImage imageNamed:@"fanhuijian2222.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(setBack) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setImageEdgeInsets:UIEdgeInsetsMake(6, 5, 6, 5)];
    UIBarButtonItem *leftSecondItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftSecondItem;
    // Do any additional setup after loading the view.
}

-(void)rightBtn:(UIButton *)sender{
    [self makeHUd];
    AFNetworkTwoPackaging *twoPacking1 = [[AFNetworkTwoPackaging alloc] init];
    [twoPacking1 getUrl:[NSString stringWithFormat:DELETEINFO,self.houseId,[StoreageMessage getMessage][2]] andFinishBlock:^(id getResult) {
        NSLog(@"%@",getResult);
        [self hudWasHidden:self.hudProgress];
        if ([getResult[@"code"] isEqualToString:@"000000"]) {
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [self.view makeToast:getResult[@"message"]];
        }
    }];
}
-(void) getInfo{
    
    
    AFNetworkTwoPackaging *twoPacking1 = [[AFNetworkTwoPackaging alloc] init];
    [twoPacking1 getUrl:[NSString stringWithFormat:RENTZHDETIAL,self.houseId] andFinishBlock:^(id getResult) {
        [self hudWasHidden:self.hudProgress];
        NSLog(@"%@",getResult);
        if ([getResult[@"code"] isEqualToString:@"000000"]) {
            for (NSDictionary *dic in getResult[@"datas"]) {
                RentZHDetialModel *model = [[RentZHDetialModel alloc] initWithDictionary:dic];
                [self.data addObject:model];
                NSLog(@"%@",model.memberId);
                if ([model.memberId isEqualToString:[StoreageMessage getMessage][2]]) {
                    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                    leftBtn.frame = CGRectMake(WIDTH_CONTROLLER - 32 , (44 - 2) / 2, 40, 25);
                    //    [leftBtn setImage:[UIImage imageNamed:@"fanhuijian2222.png"] forState:UIControlStateNormal];
                    
                    [leftBtn setTitle:@"删除" forState:UIControlStateNormal];
                    
                    leftBtn.titleLabel.font = [UIFont systemFontOfSize:12];
                    [leftBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                    
                    [leftBtn addTarget:self action:@selector(rightBtn:) forControlEvents:UIControlEventTouchUpInside];
                    [leftBtn setImageEdgeInsets:UIEdgeInsetsMake(6, 5, 6, 5)];
                    UIBarButtonItem *leftSecondItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
                    self.navigationItem.rightBarButtonItem = leftSecondItem;
                }
                
                self.titleLab.text = model.houseName;
                self.TimeLab.text = [NSString stringWithFormat:@"发布时间:%@",model.publishTime];
                self.lllLab.text = [NSString stringWithFormat:@"浏览量:%@",model.pageviews];
                self.rentLab.text = [NSString stringWithFormat:@"%@元/天",model.rent];
                self.zdzqLab.text = [NSString stringWithFormat:@"最短租期:%@天",model.minutental];
                if (!model.houseDes) {
                    self.msSuperViewHeight.constant = 0;
                }
                self.mslab.numberOfLines = 0;
                self.mslab.text = model.houseDes;
                [self.mslab sizeToFit];
                self.msSuperViewHeight.constant = self.mslab.frame.size.height+16;
                /**
                 *  595
                 */
                
                self.houseStyleLab.text = model.homeType;
                self.dzLab.text = model.qyName;
                self.lxrLab.text = model.person;
                self.phoneLab.text = model.tel;
                self.yjLab.text = [NSString stringWithFormat:@"%@元",model.deposit];
                self.fpLab.text = model.invoice;
                self.dRentLab.text = [NSString stringWithFormat:@"%@元/天",model.rent];
                switch (model.invoice.integerValue) {
                    case 1:
                        self.fpLab.text = @"提供发票";
                        break;
                    case 2:
                        self.fpLab.text = @"不提供发票";
                        break;
                    default:
                        break;
                }
                self.jdTimeLab.text = model.receptionTime;
                self.rzTimeLab.text = model.stayTime;
                self.tfTimeLab.text = model.checkOutTime;
                NSLog(@"%f",self.LBSuperViewHeight.constant);
                self.ScroViewHeight.constant = self.LBSuperViewHeight.constant + 595 + self.msSuperViewHeight.constant;
                [self.payBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
                [self.ckrlBtn addTarget:self action:@selector(btn1Action:) forControlEvents:UIControlEventTouchUpInside];
                [self.ckgzBtn addTarget:self action:@selector(btn2Action:) forControlEvents:UIControlEventTouchUpInside];
            }
        }else{
            [self.view makeToast:@"获取信息失败"];
        }
    }];
}

//跳往订单
-(void) btnAction:(UIButton *)sender{
    if (![StoreageMessage isStoreMessage]) {
        [self.view makeToast:@"请先登录!"];
        LogInViewController *logIn = [[LogInViewController alloc] init];
        [self.navigationController pushViewController:logIn animated:YES];
        return;
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                    message:@"房屋押金要面交给房东"
                                                   delegate:self
                                          cancelButtonTitle:@"再看看"
                                          otherButtonTitles:@"知道了",nil];
    [alert show];
    
}


//弹出日历
-(void) btn1Action:(UIButton *)sender{
    AFNetworkTwoPackaging *twoPacking1 = [[AFNetworkTwoPackaging alloc] init];
    [twoPacking1 getUrl:[NSString stringWithFormat:TIMETORENT,self.houseId] andFinishBlock:^(id getResult) {
        NSLog(@"time :%@",getResult);
        ZFChooseTimeViewController * vc =[ZFChooseTimeViewController new];
        //    vc.timeCannotChooseArr = @[@"2016",@"07",@"02"];
        
        [vc backDate:^(NSArray *goDate, NSArray *backDate) {
            self.StarTime = [goDate componentsJoinedByString:@"-"];
            self.EndTime = [backDate componentsJoinedByString:@"-"];
//            NSLog(@"%@",self.StarTime);
//            NSLog(@"%@-%lu",backDate, backDate.count);
            [self.ckrlBtn setTitle:[NSString stringWithFormat:@"%@到%@",[goDate componentsJoinedByString:@"-"],[backDate componentsJoinedByString:@"-"]] forState:UIControlStateNormal];
        }];

        if ([getResult[@"code"] isEqualToString:@"000001"]) {
            
            
            
        }else if ([getResult[@"code"] isEqualToString:@"000000"]){
            
            vc.arr = getResult[@"datas"];
        }
        UINavigationController *nav =[[UINavigationController alloc]initWithRootViewController:vc];
        [self presentViewController:nav animated:YES completion:^{
        }];
    }];

    
}

//查看规则
-(void) btn2Action:(UIButton *)sender{
    UniversalViewController *controller = [[UniversalViewController alloc] initWithUrl:@"guiZe"];
    controller.target = self;
    [self.navigationController pushViewController:controller animated:YES];
    
}

-(void) getImageInfo{
    AFNetworkTwoPackaging *twoPacking = [[AFNetworkTwoPackaging alloc] init];
    [twoPacking getUrl:[NSString stringWithFormat:RENTZHDETIALIMAGE,self.houseId] andFinishBlock:^(id getResult) {
        self.imageData = [NSMutableArray arrayWithCapacity:0];
        self.data = [NSMutableArray arrayWithCapacity:0];
        NSLog(@"%@",getResult);
        if ([getResult[@"code"] isEqualToString:@"000000"]) {
            self.LBSuperViewHeight.constant = 200;
            for (NSDictionary *dic in getResult[@"datas"]) {
                RentZHDetialModel *model = [[RentZHDetialModel alloc] initWithDictionary:dic];
                [self.data addObject:model];
                [self.imageData addObject:model.image];
                //                    [self.LBTdic setValue:m.comicId forKey:m.defaultImageUrl];
                SDCycleScrollView *cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.LBSuperView.frame.size.width, self.LBSuperViewHeight.constant) imageURLStringsGroup:nil];
                cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
                cycleScrollView2.delegate = self;
                cycleScrollView2.dotColor = [UIColor yellowColor];
                cycleScrollView2.placeholderImage = [UIImage imageNamed:@"placeholder"];
                [self.LBSuperView addSubview:cycleScrollView2];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    cycleScrollView2.imageURLStringsGroup = self.imageData;
                });
            }
        }else{
//            [self.view makeToast:@"商家尚未上传图片"];
            self.LBSuperViewHeight.constant = 0;
        }
        [self getInfo];

    }];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"%ld",(long)buttonIndex);
    if (buttonIndex == 1) {
        UIStoryboard *cleanerSB = [UIStoryboard storyboardWithName:@"Cleaner" bundle:nil];
        
        DRentGoToPayViewController *pay = [cleanerSB instantiateViewControllerWithIdentifier:@"DRentGoToPay"];
        NSLog(@"%@",self.ckrlBtn.titleLabel.text);
        if (![self.ckrlBtn.titleLabel.text isEqualToString:@"查看日历"]) {
            NSArray *array = [self.ckrlBtn.titleLabel.text componentsSeparatedByString:@"到"]; //从字符A中分隔成2个元素的数组
            NSLog(@"array:%@",array); //结果是adfsfsfs和dfsdf
            pay.star = array[0];
            pay.end = array[1];
        }else{
            pay.star = nil;
            pay.end = nil;
        }
        pay.tilr = self.titleLab.text;
        pay.yj = self.yjLab.text;
        pay.rent = self.rentLab.text;
        pay.houseId = self.houseId;
        [self.navigationController pushViewController:pay animated:YES];
    }else{
        
        
        
    }
    
}

//轮播图的点击事件
-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{

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
