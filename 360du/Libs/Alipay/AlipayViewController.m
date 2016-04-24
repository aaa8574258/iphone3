//
//  AlipayViewController.m
//  360du
//
//  Created by linghang on 15/9/1.
//  Copyright (c) 2015年 wangjian. All rights reserved.
//

#import "AlipayViewController.h"
#import "Order.h"
#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>
@interface AlipayViewController ()
@property(nonatomic,copy)NSString *price;
@property(nonatomic,copy)NSString *descMerchant;
@property(nonatomic,copy)NSString *titleMer;
@property(nonatomic,copy)NSString *merOrder;
@end

@implementation AlipayViewController
- (id)initPrice:(NSString *)price andDescMerchant:(NSString *)desc andTitle:(NSString *)titleMer andMerOrder:(NSString *)merOrder{
    self = [super init];
    if (self) {
        self.price = price;
        self.titleMer = titleMer;
        self.descMerchant = desc;
        self.merOrder = merOrder;
        [self makeNav];
        [self paybutton];
    }
    return self;
}
- (void)makeNav{
    [self setBackImageStateName:@"fanhuijian02.png" AndHighlightedName:@""];
    [self setNavTitleItemWithName:@"支付结果"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(receiveResult:) name:@"back" object:nil];
//    [self paybutton];
    // Do any additional setup after loading the view.
}
- (void)receiveResult:(NSNotification *)notify{
    NSDictionary *dict = [notify object];
    NSLog(@"%@",dict);
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectZero];
    lable.font = [UIFont boldSystemFontOfSize:18];
    [self.view addSubview:lable];
    if([dict[@"resultStatus"] isEqual:@"9000"]){
        lable.text = @"支付成功!";
    }else{
        lable.text = @"支付失败!";
    }
    [lable sizeToFit];
    lable.center = CGPointMake(WIDTH_CONTROLLER / 2, HEIGHT_CONTROLLER / 2);
}
- (void)paybutton{
    NSLog(@"123");
    NSString *partner = @"2088411427598120";
    NSString *seller = @"605898888@qq.com";
    //NSString *privateKey = @"MIICXAIBAAKBgQC3BqMQB+rklgfM8moviQUktmK+hutZ8Y4SbSCOjICOKaQd2a6h0oZ1UDcx6lzkLM5bH0fsIbAvs3bSKSXPNZlNg5iALkH7NPaaItaRaHC8zksyvwn47Lsl16KHkLh9o+72V7yiv6ULyAQs3ElfpgP9l0R4kB4ESKFfIyOgOqHg2QIDAQABAoGBAJ4/vdPJlL5qPnplC4zoQys4C27DR1Ewe2/RLTozn5/Lv1wT8Ft4pMtgPSkKg6DCYPYGuPAhPK4x1MXn0Ao2RMJ6+d5/nVnYScKK7PsV2aGxM8d3Tvs6DKpWtjWY5jd09hui8F4ADLlPqovozv7cRg9u7BhyHTnZgmaD1EWZH2aBAkEA4+seAfbnLM2lxoRlbdxheZTdbRR6Usdc+YDxOtNxiNdaRN1UIMcwBOYrof7ZVQ07GQJtz7SpoJeEbw3sanNbUQJBAM2Ti04i+xq5rrBYRU+Pa7/QKI2WTXBSSSqbD1bZS4DGnwmEFZmLwnzqg1e5kZUXpoc5L3wXM/Z6xYcPwUwIOwkCQAuPVUpMN5VyKMJU3MAhuV/tSP3LWBjyu6h7/cA6ETwbkByGDUpMUAcvlW71+hfyP9kY4nDyfNgEV1c6oY8UosECQBdDMuhMnQ2RJWtfEbjHCfJSo8Qh1fF33j+r/DhfrmOMFkMFZ0xQvFlWUDaFESxF2NpEZlMsbPzfN6ro5X6tD8ECQES8g3nHnbZCtyrxhtN9HurA9gXqRD7NwtvhrcINxXE99AVFWmkU5WkMED0YR8efl8Ou7rDPTt+GEU1WLHbSmfY=";
    NSString *privateKey = @"MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBANi2IdvSERyhKBJ7/tz9lY3v+Xgt+Zhq+hvXWHzH3JytbIk4Be0ktJZ/VVB2v/DzqgrnW/VWDtnfpI4c5rs+k7I4Wn8qfMjDoSB5k1OwwKyCVWwU7qC9rYpPjx8A6S3um8c5Gnj8aFsj4j/3E+FxDn40B4dbiVnAPyPwRR0/cn0hAgMBAAECgYEAw+mLnH1BCP/MCUHdew0o2cM7ZWEyxo7XgrngfhX0pBPIDhj+io9nTrLYfsCL7xlo/SiBIr7k+CRNUEhicp40x/v6pqnZLzU2DXrHjziFDcDQys2Y4Xt9SObgj4LLfEpLm3gjMVFG/EhyEqXSVo+NqWB8nU0nzFUPeCDInc45YNECQQD3KzQW4YJTpfhZwPwVpMOVGqsbhZL5d64pBBf99yu33+nslTSPinrrWCfw1J5AmN/gHhKzjOTLt36SzmG/iQr9AkEA4HRXuvbM0eDh+a5Sv7XLAmZHohuqjYR8TuBqS6PcT9az2YRiRIRSqqB0PcrSRHxfUMeB4Q5cS+UWuzYFKbat9QJBAO1zI+eXXYzetWgEbiic0Qg9RoR6HmhrAXWF6UaiXe2XvzL5ZDVB5DSTzEsg96c3Nlwoh+7WPDc5YO/INT+8eEECQFDR050grNONtBChcm5RWU394iE+8QSQBeqo591gnT2qQ4w5HOEq/FEwAWsWkuvSFMgTbnLJJva1AKBcbTN98dkCQCObVz9dHk2jxhCVQlcHJtwzQpvaLrnlZ7eC5HCCwtKJQIwcjSeMb/u5zpEqStxGpjIwBNrabA7DA9mEi185NSg=";
    

    //NSString *privateKey = @"MIICeAIBADANBgkqhkiG9w0BAQEFAASCAmIwggJeAgEAAoGBALgqxhIe0GXDpq26F4giZDkCD8vFaYCOsjGgqp1sjbAijiiw4lwZeTs2x432tsk1KpAEvy75rtjxMgYvuojqyfb+LvSm6hMmuSOgXuN02B83YzXobYzkefmtuNYsLGB2xYxq7IS1QPWZWPq5mdXUjc5n0MhJ2sUInWyUzM4GPOwdAgMBAAECgYEAoZ2nxC8WYreXhc1Q6T6FBSIyCnhrZU3UQojkMNIaZP9uEXdorboNEVG5PXPMZDYr68a+n9KtBeRkKdmosI6aPJEfRj1o5uIKeTGKFh2e0hE1BkaSx0DLjUGLiFUOI1+Ff+iRL0lwcVfunJbM2XV95tn8/SEywYgpcWr5emQwjwECQQDcfBulJz9DQW/PcSA9xEzwk1nsFmLf6mNDqMX9A+3LeccfoagfXH5+T0J+bFXGZ5u0ZLZX5eD+ncYEDaBlICNlAkEA1dUSWopd5k9y4Z1/zopMEAMj1KF0yGc269uHuWcVfP/IFI4YCt9TNYgvpJOp/k49a4IwFEj9RgYWydEQ8CdGWQJACORMbR2nFHxIGRKT3UnUXINkxfulIyidtjXRPkHxThpsKF9pm1Ism8Vwhg6yatz0z5KcM/FGYJ5WRQWTqWBhbQJBAITGd00NGd1Ge/koCRJAwZY3vOntD0zY+jtd51rybV9em+hXiwpFPa/BzoOMxUOJZY36GsydvdbbNQ8/6BqW6JECQQDO9v5or0+70RtQKI7MVJwgOvmBOnRb6Sk/3kBGPx0uia31nwnbZ4whpBTZLkrrvsfpmxTxstzR+hjWG5ydYxp6";
    //partner和seller获取失败,提示
    if ([partner length] == 0 || [seller length] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"缺少partner或者seller。"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    Order *order = [[Order alloc] init];
    order.partner = partner;
    order.seller = seller;
    order.tradeNO = [self generateTradeNO]; //订单ID（由商家自行制定）
    //    order.tradeNO = @"119";
    order.productName = self.titleMer; //商品标题
    order.productDescription = self.descMerchant; //商品描述
    order.amount = self.price; //商品价格
    order.notifyURL =  @"http://www.360duang.net/360duang/Shop/pay/notify_url.jsp"; //回调URL
    
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m"; //订单时间
    order.showUrl = @"m.alipay.com"; //商品链接
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"360du";
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    NSLog(@"orderSpec = %@",orderSpec);
    
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:orderSpec];
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
        NSLog(@"orderString===%@",orderString);
        
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"resuluDic%@",resultDic);
            [self.navigationController popToRootViewControllerAnimated:YES];
//            [self.navigationController popViewControllerAnimated:YES];
            
        }];
        
    }
    
    
    
}
#pragma mark -
#pragma mark   ==============产生随机订单号==============


- (NSString *)generateTradeNO
{
    static int kNumber = 15;
    
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand(time(0));
    for (int i = 0; i < kNumber; i++)
    {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
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
