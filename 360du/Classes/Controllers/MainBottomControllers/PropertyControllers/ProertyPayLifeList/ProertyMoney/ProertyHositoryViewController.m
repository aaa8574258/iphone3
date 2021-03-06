//
//  ProertyHositoryViewController.m
//  360du
//
//  Created by linghang on 16/3/7.
//  Copyright © 2016年 wangjian. All rights reserved.
//

#import "ProertyHositoryViewController.h"
#import "AFNetworkTwoPackaging.h"
#import "StoreageMessage.h"
#import "ProertyHistoryModel.h"
#import "UIView+Toast.h"
@interface ProertyHositoryViewController ()
@property(nonatomic,strong)NSMutableArray *dataArr;
@end

@implementation ProertyHositoryViewController
- (id)initWithPrid:(NSString *)prid{
    self = [super init];
    if (self) {
        self.dataArr = [NSMutableArray arrayWithCapacity:0];
        [self requestData:prid];
        [self createNav];
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    // Do any additional setup after loading the view.
}
- (void)createNav{
    [self setNavBarImage:@"landi.png"];
    //[self setBackgroud:@"lantiao x.png"];
    [self setBackImageStateName:@"fanhuijian02.png" AndHighlightedName:@""];
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    //view.backgroundColor = MAINVIEWNAVBARCOLOR;
    //[self.view addSubview:view];
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectZero];
    lable.text = @"历史账单";
    lable.font = [UIFont systemFontOfSize:16 * self.numSingleVesion];
    lable.textColor = [UIColor whiteColor];
    [lable sizeToFit];
    lable.frame = CGRectMake(5 * self.numSingleVesion, 0 + (44 - 15) / 2, lable.frame.size.width, 15);
    [view addSubview:lable];
    view.frame = CGRectMake(0, 0, lable.frame.size.width, 44);
    //UIBarButtonItem *centerBar = [[UIBarButtonItem alloc] initWithCustomView:view];
    self.navigationItem.titleView = view;
}
- (void)requestData:(NSString *)prid{
    AFNetworkTwoPackaging *twoPack = [[AFNetworkTwoPackaging alloc] init];
    NSString *url = [NSString stringWithFormat:PROERTYHISTORYPAYMONEY,[StoreageMessage getMessage][2]];
//    NSLog(@"%@",url);
    [twoPack getUrl:url andFinishBlock:^(id getResult) {
//        NSLog(@"%@",getResult);
        if ([getResult[@"code"] isEqualToString:@"000000"]) {
            for (id temp in getResult[@"datas"]) {
                ProertyHistoryModel *model = [[ProertyHistoryModel alloc] initWithDictionary:temp];
                [self.dataArr addObject:model];
            }
            [self createUIScrollView];
        }else{
            NSString *message = getResult[@"message"];
            if (message.length == 0) {
                message = @"请求出错,请稍后再试!";
            }
            [self.view makeToast:message];
        }
    }];
    
}
- (void)createUIScrollView{
    CGFloat height = 64;
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0,height, WIDTH_CONTROLLER, 40 * self.numSingleVesion)];
    headView.backgroundColor = SMSColor(241, 241, 241);
    //    headView.backgroundColor = [UIColor redColor];
    //    [self.view addSubview:headView];
    //    self.headView = headView;
    //底线
    //    UILabel *lineLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 39 * self.numSingleVesion, WIDTH_CONTROLLER, 1 * self.numSingleVesion)];
    //    lineLab.backgroundColor = SMSColor(151, 151, 151);
    //    [headView addSubview:lineLab];
    //左边红色
    UILabel *leftLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 10 * self.numSingleVesion, 40 * self.numSingleVesion)];
    leftLab.backgroundColor = SMSColor(230, 26, 27);
    [headView addSubview:leftLab];
    //goodsName
    UILabel *nameLab = [[UILabel alloc] initWithFrame:CGRectZero];
    nameLab.textColor = SMSColor(151, 151, 151);
    nameLab.text = @"账单";
    nameLab.font = [UIFont systemFontOfSize:15];
    [nameLab sizeToFit];
    nameLab.center = CGPointMake(15 * self.numSingleVesion + nameLab.frame.size.width / 2, 20 * self.numSingleVesion);
    [headView addSubview:nameLab];
    [self.view addSubview:headView];
    
    height += 40 * self.numSingleVesion;
    
    
    CGFloat everHeight = 60 * self.numSingleVesion;
    
    UIScrollView *scr = [[UIScrollView alloc] initWithFrame:CGRectMake(0, height, WIDTH_CONTROLLER, HEIGHT_CONTROLLER - height)];
    [self.view addSubview:scr];
    scr.contentSize = CGSizeMake(WIDTH_CONTROLLER, everHeight * self.dataArr.count);
    for (NSInteger i = 0; i < self.dataArr.count; i++) {
        ProertyHistoryModel *model = self.dataArr[i];
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0 * self.numSingleVesion,  everHeight * i, WIDTH_CONTROLLER - 0 * self.numSingleVesion,everHeight -  0 * self.numSingleVesion)];
        [scr addSubview:backView];
        //backView.layer.borderWidth = 1 * self.numSingleVesion;
        //backView.layer.borderColor = [[UIColor blackColor] CGColor];
        
        UILabel *leftLab = [[UILabel alloc] initWithFrame:CGRectZero];
        leftLab.font = [UIFont systemFontOfSize:16];
        [backView addSubview:leftLab];
        leftLab.textColor = SMSColor(211, 211, 211);
        leftLab.text = model.AccountTime;
        leftLab.frame = CGRectMake(10 * self.numSingleVesion, 10 * self.numSingleVesion, 300 * self.numSingleVesion, 15 * self.numSingleVesion);
        
        UILabel *leftLab1 = [[UILabel alloc] initWithFrame:CGRectZero];
        leftLab1.font = [UIFont systemFontOfSize:16];
        [backView addSubview:leftLab1];
        leftLab1.textColor = SMSColor(211, 211, 211);
        leftLab1.text = model.payTime;
        leftLab1.frame = CGRectMake(10 * self.numSingleVesion, 40 * self.numSingleVesion, 300 * self.numSingleVesion, 15 * self.numSingleVesion);
        
        UILabel *centerLab = [[UILabel alloc] initWithFrame:CGRectZero];
        centerLab.font = [UIFont systemFontOfSize:16];
        [backView addSubview:centerLab];
        centerLab.textColor = SMSColor(51, 51, 51);
        centerLab.text = [NSString stringWithFormat:@"￥%@",model.JFmoney];
        [centerLab sizeToFit];
        centerLab.center = CGPointMake(WIDTH_CONTROLLER - 10 * self.numSingleVesion - centerLab.frame.size.width, (everHeight - 0 * self.numSingleVesion) / 2);
        
        UILabel *lineLab = [[UILabel alloc] initWithFrame:CGRectMake(0, everHeight - 1, WIDTH_CONTROLLER, 1)];
        lineLab.backgroundColor = SMSColor(241, 241, 241);
        [backView addSubview:lineLab];
        
        
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
