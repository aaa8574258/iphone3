//
//  ZAndHDetialViewController.m
//  360du
//
//  Created by 利美 on 16/6/22.
//  Copyright © 2016年 wangjian. All rights reserved.
//

#import "ZAndHDetialViewController.h"
#import "RentZHDetialModel.h"
#import "UIView+Toast.h"
#import "VOTagList.h"
#import "SDCycleScrollView.h"
#import "StoreageMessage.h"
@interface ZAndHDetialViewController ()<SDCycleScrollViewDelegate>
@property (nonatomic ,strong) NSMutableArray *data;
@property (nonatomic ,strong) NSMutableArray *imageData;
@property (weak, nonatomic) IBOutlet UILabel *msLab;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *msSuperViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ScViewHeight;
@property (weak, nonatomic) UIButton *naviBtn2;
@end

@implementation ZAndHDetialViewController

- (void)viewDidLoad {
    [self makeHUd];
    [super viewDidLoad];
//    NSLog(@"%@",self.houseId);
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
    
    

}

-(void)backDown:(UIButton *)sender{

}




-(void)viewWillAppear:(BOOL)animated{
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"0.png"] forBarMetrics:UIBarMetricsDefault];

}

-(void)rightBtn:(UIButton *)sender{
    [self makeHUd];
    AFNetworkTwoPackaging *twoPacking1 = [[AFNetworkTwoPackaging alloc] init];
    [twoPacking1 getUrl:[NSString stringWithFormat:DELETEINFO,self.houseId,[StoreageMessage getMessage][2]] andFinishBlock:^(id getResult) {
        [self hudWasHidden:self.hudProgress];
        if ([getResult[@"code"] isEqualToString:@"000000"]) {
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [self.view makeToast:getResult[@"message"]];
        }
    }];
}


/**
 *  解析数据
 */
-(void) getInfo{
    
    AFNetworkTwoPackaging *twoPacking1 = [[AFNetworkTwoPackaging alloc] init];
    [twoPacking1 getUrl:[NSString stringWithFormat:RENTZHDETIAL,self.houseId] andFinishBlock:^(id getResult) {
        [self hudWasHidden:self.hudProgress];
//        NSLog(@"%@",getResult);
        if ([getResult[@"code"] isEqualToString:@"000000"]) {
            for (NSDictionary *dic in getResult[@"datas"]) {
                RentZHDetialModel *model = [[RentZHDetialModel alloc] initWithDictionary:dic];
                [self.data addObject:model];
                
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
                self.timeLab.text = [NSString stringWithFormat:@"发布时间:%@",model.publishTime];
//                if (model.pageviews) {
//                    <#statements#>
//                }
                self.lllLab.text = [NSString stringWithFormat:@"浏览量:%@",model.pageviews];
                self.rentLab.text = [NSString stringWithFormat:@"%@元/月",model.rent];
                self.stwLab.text = [NSString stringWithFormat:@"%@",model.apartment];
                self.mjLab.text = [NSString stringWithFormat:@"面积:%@㎡",model.houseArea];
                self.floorContLab.text = model.floor;
                self.faceLab.text = [NSString stringWithFormat:@"房屋朝向:%@",model.face];
                self.houseTypeLab.text = model.homeType;
                self.xqLab.text = model.xqName;
                self.dzLab.text = model.qyName;
                self.lxrLab.text = model.person;
                self.phoneLab.text = model.tel;
                
                self.ssSuperViewHeight.constant = 16 + ((int)ceilf(model.facilities.count/4) + 1)* 50;
//                NSLog(@"%f -- %d",self.ssSuperViewHeight.constant,(int)ceilf(model.facilities.count/4));
                if (model.facilities) {
                    [self addVOtags:[NSMutableArray arrayWithArray:model.facilities]];
                }else{
                    
                }
                
                
                
                self.msLab.numberOfLines = 0;
                self.msLab.text = model.houseDes;
                [self.msLab sizeToFit];
                self.msSuperViewHeight.constant = self.msLab.frame.size.height+10;
                if (!model.houseDes) {
                    [self.msLab.superview removeFromSuperview];
                    self.ScViewHeight.constant = 358 + self.ssSuperViewHeight.constant + self.lunboSuperViewHeight.constant;
                }else{
                    self.ScViewHeight.constant = 358 + self.ssSuperViewHeight.constant + self.lunboSuperViewHeight.constant + self.msSuperViewHeight.constant + 10;
                }
                self.dlxrLab.text = model.person;
                self.ddhLab.text = model.tel;
                [self.telBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
            }
        }else{
             [self.view makeToast:@"获取信息失败"];
        }
    }];
}


/**
 *  电话
 *
 *  @param sender
 */
-(void) btnAction:(UIButton *)sender{
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",self.ddhLab.text]]];
}


-(void) getImageInfo{
    AFNetworkTwoPackaging *twoPacking = [[AFNetworkTwoPackaging alloc] init];
    [twoPacking getUrl:[NSString stringWithFormat:RENTZHDETIALIMAGE,self.houseId] andFinishBlock:^(id getResult) {
        self.imageData = [NSMutableArray arrayWithCapacity:0];
        self.data = [NSMutableArray arrayWithCapacity:0];
//        NSLog(@"%@",getResult);
        if ([getResult[@"code"] isEqualToString:@"000000"]) {
            self.lunboSuperViewHeight.constant = 200;
            for (NSDictionary *dic in getResult[@"datas"]) {
                RentZHDetialModel *model = [[RentZHDetialModel alloc] initWithDictionary:dic];
                [self.data addObject:model];
                
                
                /**
                 *  SDC轮播图
                 */
                
                

                    [self.imageData addObject:model.image];
//                    [self.LBTdic setValue:m.comicId forKey:m.defaultImageUrl];
                    SDCycleScrollView *cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.lunboSuperView.frame.size.width, self.lunboSuperViewHeight.constant) imageURLStringsGroup:nil];
                    cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
                    cycleScrollView2.delegate = self;
                    cycleScrollView2.dotColor = [UIColor yellowColor];
                    cycleScrollView2.placeholderImage = [UIImage imageNamed:@"placeholder"];
                    [self.lunboSuperView addSubview:cycleScrollView2];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        cycleScrollView2.imageURLStringsGroup = self.imageData;
                    });
                
                
                
                
            }
        }else{
//            [self.view makeToast:@"商家尚未上传图片"];
            self.lunboSuperViewHeight.constant = 0;
        }
        [self getInfo];

    }];
}

/**
 *  标签
 *
 *  @param _tags <#_tags description#>
 */
-(void)addVOtags:(NSMutableArray *)_tags{
    //   self.ssView.frame.size.height == 200;
    VOTagList *tagList = [[VOTagList alloc] initWithTags:_tags];
    tagList.frame = CGRectMake(10,8, self.view.frame.size.width-16,self.ssSuperViewHeight.constant);
    tagList.multiLine = YES;
    tagList.multiSelect = YES;
    tagList.allowNoSelection = YES;
    tagList.vertSpacing = 8;
    tagList.horiSpacing = 25;
    tagList.textColor = [UIColor greenColor];
    tagList.selectedTextColor = [UIColor greenColor];
    tagList.tagBackgroundColor = [UIColor whiteColor];
    tagList.selectedTagBackgroundColor = [UIColor whiteColor];
    tagList.tagCornerRadius = 3;
    tagList.tagEdge = UIEdgeInsetsMake(10, 10, 10, 10);
    [self.ssSuperView addSubview:tagList];
    
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
