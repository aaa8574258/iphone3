//
//  JfDhXqViewController.m
//  360du
//
//  Created by 利美 on 17/3/16.
//  Copyright © 2017年 wangjian. All rights reserved.
//

#import "JfDhXqViewController.h"
#import "StoreageMessage.h"
#import "JfDhDetialViewController.h"
@interface JfDhXqViewController ()<UIScrollViewDelegate,UIWebViewDelegate>
@property (nonatomic ,strong) UIScrollView *Scro;

@end

@implementation JfDhXqViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(WIDTH_CONTROLLER - 32 , (44 - 2) / 2, 30, 30);
    [leftBtn setImage:[UIImage imageNamed:@"叉号@2x.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(setBack) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setImageEdgeInsets:UIEdgeInsetsMake(6, 5, 6, 5)];
    UIBarButtonItem *leftSecondItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftSecondItem;
    self.view.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTENTVIEW, 20)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    
    UIScrollView *Scro = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, WIDTH_CONTENTVIEW, HEIGHT_CONTENTVIEW)];
    Scro.contentSize = CGSizeMake(WIDTH_CONTENTVIEW, 1800);
    Scro.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
    [self.view addSubview:Scro];
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTENTVIEW, 20)];
    view1.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view1];
    self.Scro = Scro;
    self.Scro.delegate = self;
    [self reloadInfo];
}

-(void) reloadInfo{
    AFNetworkTwoPackaging *twoPacking = [[AFNetworkTwoPackaging alloc] init];
    [twoPacking getUrl:[NSString stringWithFormat:DHDETIALM,[StoreageMessage getMessage][2],self.exchange_id] andFinishBlock:^(id getResult) {
        NSLog(@"%@",getResult);
        [self makeUIWithJF:getResult[@"datas"][@"proIntegral"] AndImageUrl:getResult[@"datas"][@"picUrl"] andName:getResult[@"datas"][@"proName"] AndJuanMa:getResult[@"datas"][@"redemption"] andTime:getResult[@"datas"][@"endTime"] andOther:getResult[@"datas"][@"proContent"] andproid:getResult[@"datas"][@"pro_id"]];
    }];


}


-(void)makeUIWithJF:(NSString *)jifen AndImageUrl:(NSString *)imageUrl andName:(NSString *)name AndJuanMa:(NSString *)juanMa andTime:(NSString *)time  andOther:(NSString *)other andproid:(NSString *)proid{
    UIView * view0 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 103 * self.numSingleVesion)];
    view0.backgroundColor = [UIColor whiteColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doTap:)];
    view0.userInteractionEnabled = YES;
    view0.tag = 10010 + proid.integerValue;
    [view0 addGestureRecognizer:tap];
    [self.Scro addSubview:view0];
    
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(10 * self.numSingleVesion, 15 * self.numSingleVesion, 115 * self.numSingleVesion, 75 *self.numSingleVesion)];
    //    imageV.backgroundColor = [UIColor cyanColor];
    [imageV sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
    [self.Scro addSubview:imageV];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(135 * self.numSingleVesion, 15 *self.numSingleVesion, self.view.frame.size.width - 85 *self.numSingleVesion, 50 *self.numSingleVesion)];
    label1.text = [NSString stringWithFormat:@"%@",name];
    label1.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
    label1.font = [UIFont systemFontOfSize:15 * self.numSingleVesion];
    [label1 sizeToFit];
    [view0 addSubview:label1];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(135 * self.numSingleVesion, label1.frame.origin.y + label1.frame.size.height + 10 *self.numSingleVesion, self.view.frame.size.width - 135 *self.numSingleVesion, 30 *self.numSingleVesion)];
    label2.text = [NSString stringWithFormat:@"%@ 积分",jifen];
    label2.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
    label2.font = [UIFont systemFontOfSize:16];
    [label2 sizeToFit];
    [view0 addSubview:label2];
    
    
    UIImageView *imageV1 = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, 14 * self.numSingleVesion, 12 *self.numSingleVesion)];
    //    imageV.backgroundColor = [UIColor cyanColor];
    [imageV1 sd_setImageWithURL:[NSURL URLWithString:@""]];
    [view0 addSubview:imageV1];
    
    
    
    
    
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 113 * self.numSingleVesion, self.view.frame.size.width, 84 *self.numSingleVesion)];
    view1.backgroundColor = [UIColor whiteColor];
    [self.Scro addSubview:view1];
    
    UILabel *lab1 = [[UILabel alloc] initWithFrame:CGRectMake(10 * self.numSingleVesion, 15 * self.numSingleVesion, self.view.frame.size.width - 20 * self.numSingleVesion, 30)];
    lab1.text = [NSString stringWithFormat:@"卷码 %@",juanMa];
    lab1.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
    lab1.font = [UIFont systemFontOfSize:15 * self.numSingleVesion];
    [lab1 sizeToFit];
    [view1 addSubview:lab1];
    
    UILabel *lab2 = [[UILabel alloc] initWithFrame:CGRectMake(10 * self.numSingleVesion,  lab1.frame.size.height + lab1.frame.origin.y + 23 * self.numSingleVesion, self.view.frame.size.width - 20 * self.numSingleVesion, 30)];
    lab2.text = [NSString stringWithFormat:@"有效期至: %@",time];
    lab2.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
    lab2.font = [UIFont systemFontOfSize:14 * self.numSingleVesion];
    [lab2 sizeToFit];
    [view1 addSubview:lab2];
    
    
    
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(0, view1.frame.origin.y + view1.frame.size.height + 10 *self.numSingleVesion, self.view.frame.size.width, 1000 *self.numSingleVesion)];
    view2.backgroundColor = [UIColor whiteColor];
    [self.Scro addSubview:view2];

    
    
    UILabel *lab3 = [[UILabel alloc] initWithFrame:CGRectMake(10 *self.numSingleVesion, 10 *self.numSingleVesion, self.view.frame.size.width - 20 *self.numSingleVesion, 30 * self.numSingleVesion)];
    lab3.text = [NSString stringWithFormat:@"%@",@"卷描述"];
    lab3.font = [UIFont systemFontOfSize:17 * self.numSingleVesion];
    lab3.textColor  = SMSColor(51, 51, 51);
    [lab3 sizeToFit];
    [view2 addSubview:lab3];
    

    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(5 *self.numSingleVesion, lab3.frame.origin.y + lab3.frame.size.height + 20 *self.numSingleVesion, self.view.frame.size.width - 10 *self.numSingleVesion, 1000 * self.numSingleVesion)];
    webView.backgroundColor = [UIColor whiteColor];
    webView.scrollView.showsVerticalScrollIndicator = NO;
    webView.scrollView.bouncesZoom = NO;
    webView.scalesPageToFit = NO;//自动对页面进行缩放以适应屏幕
    webView.delegate=self;
    webView.autoresizesSubviews = NO; //自动调整大小
    webView.autoresizingMask=(UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth);
    webView.scrollView.scrollEnabled=NO;
    //    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",FIRSTSTRING,self.detial,LASTSTRING]]]];
    [webView loadHTMLString:[NSString stringWithFormat:@"%@",other] baseURL:nil];
    //    NSLog(@"%@",[NSString stringWithFormat:@"%@%@%@",FIRSTSTRING,self.detial,LASTSTRING]);
    [view2 addSubview:webView];
    
    
    
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    CGSize actualSize = [webView sizeThatFits:CGSizeZero];
    CGRect newFrame = webView.frame;
    newFrame.size.height = actualSize.height;
    webView.frame = newFrame;
    self.Scro.contentSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width, webView.frame.origin.y+webView.frame.size.height );
    
}

-(void)doTap:(UITapGestureRecognizer *)center{
    NSLog(@"%ld",center.view.tag -10010);
    JfDhDetialViewController *detial = [[JfDhDetialViewController alloc] init];
    detial.pro_id = [NSString stringWithFormat:@"%ld",center.view.tag - 10010];
    
    [self.navigationController pushViewController:detial animated:YES];
    
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
