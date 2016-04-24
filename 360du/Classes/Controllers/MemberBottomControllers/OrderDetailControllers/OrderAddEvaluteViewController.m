//
//  OrderAddEvaluteViewController.m
//  360du
//
//  Created by linghang on 16/1/4.
//  Copyright © 2016年 wangjian. All rights reserved.
//

#import "OrderAddEvaluteViewController.h"
#import "OrderAddEvaluate.h"
#import "StoreageMessage.h"
#import "NSString+URLEncoding.h"
@interface OrderAddEvaluteViewController ()
@property(nonatomic,copy)NSString *merchantId;
@end

@implementation OrderAddEvaluteViewController
- (id)initWithMerchantId:(NSString *)merchantId andStarCount:(NSString *)starCout{
    self = [super init];
    if (self) {
        self.merchantId = merchantId;
        [self makeNav];
        [self createStateView:starCout];
    }
    return self;
}
- (void)makeNav{
    [self setNavBarImage:@"landi.png"];
    //[self setBackgroud:@"lantiao x.png"];
    [self setBackImageStateName:@"fanhuijian02.png" AndHighlightedName:@""];
    
    [self setNavTitleItemWithName:@"添加评价"];
}
- (void)createStateView:(NSString *)starCount{
    OrderAddEvaluate *addEvaluate = [[OrderAddEvaluate alloc] initWithFrame:CGRectMake(0, 64, WIDTH_CONTROLLER, HEIGHT_CONTROLLER - 64) andStarCount:starCount];
    addEvaluate.target = self;
    [self.view addSubview:addEvaluate];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    // Do any additional setup after loading the view.
}
//返回评价的星数和评价内容
- (void)returnStarCount:(NSString *)starCount andEvaluteContent:(NSString *)evaluteContent{
    AFNetworkTwoPackaging *twoPack = [[AFNetworkTwoPackaging alloc] init];
    NSString *url = [NSString stringWithFormat:ORDERADDEVALUATE,self.merchantId,[StoreageMessage getMessage][2],starCount,[[evaluteContent urlEncodeString] urlEncodeString],self.orderId];
    [twoPack getUrl:url andFinishBlock:^(id getResult) {
        NSLog(@"%@",getResult);
    }];
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
