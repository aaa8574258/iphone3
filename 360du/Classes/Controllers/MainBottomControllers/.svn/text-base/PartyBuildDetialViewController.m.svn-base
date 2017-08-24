//
//  PartyBuildDetialViewController.m
//  360du
//
//  Created by 利美 on 17/7/27.
//  Copyright © 2017年 wangjian. All rights reserved.
//

#import "PartyBuildDetialViewController.h"
#define FIRSTSTRING @"<!doctype html><html lang=\"zh\"><head><meta charset=\"GBK\"><meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge,chrome=1\"><meta name=\"viewport\" content=\"width=device-width,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no\"/><title>product Introduction</title><script type=\"text/javascript\">document.write(‘<meta name=\"viewport\" content=\"width=640, user-scalable=no, target-densitydpi=device-dpi\">‘);</script></head><body><div class='product-main'>"
#define LASTSTRING @"</div></body></html>"
@interface PartyBuildDetialViewController ()
@property (nonatomic ,copy) NSString *tittle;
@property (nonatomic ,copy) NSString *detial;
@property (nonatomic ,copy) NSString *time;
@end

@implementation PartyBuildDetialViewController

- (id)initWithTittle:(NSString *)tittle andDetial:(NSString *)detial andTime:(NSString *)time
{
    self = [super init];
    if (self) {
        
        self.tittle = tittle;
        self.detial = detial;
        self.time = time;
    }
    return self;
}


-(void) makeNavigationAndNext{

    [self setBackImageStateName:@"fanhuijian2222.png" AndHighlightedName:@""];
    UILabel *labelDetial1 = [[UILabel alloc] initWithFrame:CGRectMake(20 *self.numSingleVesion, 64 +20 *self.numSingleVesion, self.view.frame.size.width - 40, 30)];
    labelDetial1.font = [UIFont systemFontOfSize:17 * self.numSingleVesion];
    
    labelDetial1.text = self.tittle;
    labelDetial1.numberOfLines = 0;
    [labelDetial1 sizeToFit];
    [self.view addSubview:labelDetial1];
    
    
    UILabel *labelDetial2 = [[UILabel alloc] initWithFrame:CGRectMake(20 * self.numSingleVesion, 64 + 30 *self.numSingleVesion + labelDetial1.frame.size.height, self.view.frame.size.width - 40, 30*self.numSingleVesion)];
    labelDetial2.font = [UIFont systemFontOfSize:12 * self.numSingleVesion];
    labelDetial2.text = [NSString stringWithFormat:@"%@",self.time];
    [labelDetial2 sizeToFit];
    labelDetial2.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
    [self.view addSubview:labelDetial2];
    
    UIImageView *imageline = [[UIImageView alloc] initWithFrame:CGRectMake(20, 64 + 31 * self.numSingleVesion + labelDetial1.frame.size.height  + labelDetial2.frame.size.height, self.view.frame.size.width - 40, 1 * self.numSingleVesion)];
    [imageline setImage:[UIImage imageNamed:@"xuxian.png"]];
    [self.view addSubview:imageline];
    
    NSLog(@"%@",self.detial);
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(19 * self.numSingleVesion, 64 + 41 * self.numSingleVesion + labelDetial1.frame.size.height  + labelDetial2.frame.size.height, self.view.frame.size.width - 38, self.view.frame.size.height - 64 - 106 *self.numSingleVesion)];
    webView.backgroundColor = [UIColor whiteColor];
    webView.scrollView.showsVerticalScrollIndicator = NO;
    webView.scrollView.bouncesZoom = NO;
    [webView loadHTMLString:[NSString stringWithFormat:@"%@%@%@",FIRSTSTRING,self.detial,LASTSTRING] baseURL:nil];
    NSLog(@"%@",[NSString stringWithFormat:@"%@%@%@",FIRSTSTRING,self.detial,LASTSTRING]);
    [self.view addSubview:webView];
}



- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
}


-(void)viewWillAppear:(BOOL)animated{
    [self makeNavigationAndNext];

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
