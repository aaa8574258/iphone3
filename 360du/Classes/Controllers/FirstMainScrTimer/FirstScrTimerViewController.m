//
//  FirstScrTimerViewController.m
//  360du
//
//  Created by linghang on 15/9/10.
//  Copyright (c) 2015年 wangjian. All rights reserved.
//

#import "FirstScrTimerViewController.h"

@interface FirstScrTimerViewController ()

@end

@implementation FirstScrTimerViewController
- (id)initWithArr:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        [self makeNav:dict[@"adContent"]];
        [self makeWebView:dict[@"guideAction"]];
    }
    return self;
}
- (void)makeNav:(NSString *)navTitle{
    [self setNavBarImage:@"landi.png"];
    //[self setBackgroud:@"lantiao x.png"];
    [self setBackImageStateName:@"fanhuijian02.png" AndHighlightedName:@""];
    
    [self setNavTitleItemWithName:navTitle];
}
- (void)makeWebView:(NSString *)webUrl{
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, WIDTH_CONTROLLER, HEIGHT_CONTROLLER - 64)];
    webView.scrollView.showsVerticalScrollIndicator = NO;
    webView.scrollView.bouncesZoom = NO;
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:webUrl]]];
    [self.view addSubview:webView];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
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