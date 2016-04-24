//
//  ProertyMendDeatilViewController.m
//  360du
//
//  Created by linghang on 15/11/18.
//  Copyright © 2015年 wangjian. All rights reserved.
//

#import "ProertyMendDeatilViewController.h"
#import "AFNetworkTwoPackaging.h"
#import "UIView+Toast.h"
@interface ProertyMendDeatilViewController ()

@end

@implementation ProertyMendDeatilViewController
- (id)initWithProertyMendId:(NSString *)proertyMendId{
    self = [super init];
    if (self) {
        [self loadDataWithProertyMendId:proertyMendId];
        [self makeNav];
    }
    return self;
}
- (void)makeNav{
    [self setNavBarImage:@"landi.png"];
    //[self setBackgroud:@"lantiao x.png"];
    [self setBackImageStateName:@"fanhuijian02.png" AndHighlightedName:@""];
    
    
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    //view.backgroundColor = MAINVIEWNAVBARCOLOR;
    //[self.view addSubview:view];
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectZero];
    lable.text = @"维修状态";
    lable.font = [UIFont systemFontOfSize:16 * self.numSingleVesion];
    lable.textColor = [UIColor whiteColor];
    [lable sizeToFit];
    lable.frame = CGRectMake(5 * self.numSingleVesion, 0 + (44 - 15) / 2, lable.frame.size.width, 15);
    [view addSubview:lable];
    view.frame = CGRectMake(0, 0, lable.frame.size.width, 44);
    //UIBarButtonItem *centerBar = [[UIBarButtonItem alloc] initWithCustomView:view];
    self.navigationItem.titleView = view;
}
- (void)loadDataWithProertyMendId:(NSString *)proertyMendID{
    [self makeHUd];
    AFNetworkTwoPackaging *twoPack = [[AFNetworkTwoPackaging alloc] init];
    [twoPack getUrl:[NSString stringWithFormat:PEOERTYMENDDEATIL,proertyMendID] andFinishBlock:^(id getResult) {
        [self hudWasHidden:self.hudProgress];
        NSLog(@"url:%@",[NSString stringWithFormat:PEOERTYMENDDEATIL,proertyMendID] );
        NSLog(@"getResult:%@",getResult);
        if (!getResult) {
            [self.view makeToast:@"没有发布状态!"];
            return ;
        }
        if ([getResult[@"success"] isEqual:@"no"]) {
            [self.view makeToast:getResult[@"message"]];
        }else{
            [self makeUIWithContent:getResult[@"datas"][@"repairContent"] andTime:getResult[@"datas"][@"reservationTime"] andPbId:getResult[@"datas"][@"pbID"]];
        }
    }];
}
- (void)makeUIWithContent:(NSString *)content andTime:(NSString *)time andPbId:(NSString *)pbID{
    NSArray *keyArr = @[@"发布时间:",@"维修编号",@"维修内容:"];
    NSArray *valueArr = @[time,pbID,content];
    CGFloat height = [self returnContentHeight:content];
    for (NSInteger i = 0; i < keyArr.count; i++) {
        UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(20 * self.numSingleVesion, 64 + 20 * self.numSingleVesion + 40 * self.numSingleVesion * i + 15 * self.numSingleVesion, WIDTH_CONTROLLER - 40 * self.numSingleVesion, 40 * self.numSingleVesion)];
        lable.text = [NSString stringWithFormat:@"%@%@",keyArr[i],valueArr[i]];
        lable.textColor = SMSColor(151, 151, 151);
        [self.view addSubview:lable];
        if (i == keyArr.count - 1) {
            lable.frame = CGRectMake(20 * self.numSingleVesion, 64 + 20 * self.numSingleVesion + 40 * i * self.numSingleVesion + 15 * self.numSingleVesion, WIDTH_CONTROLLER - 40 * self.numSingleVesion, height);
        }
    }
}
- (CGFloat)returnContentHeight:(NSString *)content{
    NSDictionary *dict = @{NSFontAttributeName:[UIFont systemFontOfSize:15]};
    CGRect rect = [content boundingRectWithSize:CGSizeMake(WIDTH_CONTROLLER - 40 * self.numSingleVesion, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    return rect.size.height;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
