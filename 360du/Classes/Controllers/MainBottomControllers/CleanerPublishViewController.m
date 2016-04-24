//
//  CleanerPublishViewController.m
//  360du
//
//  Created by 利美 on 16/4/21.
//  Copyright © 2016年 wangjian. All rights reserved.
//

#import "CleanerPublishViewController.h"
#import "XYTextView.h"
@interface CleanerPublishViewController ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *NameText;
@property (weak, nonatomic) IBOutlet UITextField *adrrText;
@property (weak, nonatomic) IBOutlet UITextField *telText;
@property (weak, nonatomic) IBOutlet UIView *teSeTextView;
@property (weak, nonatomic) IBOutlet UIView *discrpView;
@property (weak, nonatomic) IBOutlet UIView *tView;
@property (weak, nonatomic) IBOutlet UIView *mView;

@property(strong, nonatomic)XYTextView * textView;
@property(strong, nonatomic)XYTextView * textView2;

@end

@implementation CleanerPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"landi.png"] forBarMetrics:UIBarMetricsDefault];
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(WIDTH_CONTROLLER - 32 , (44 - 2) / 2, 30, 40);
    [leftBtn setImage:[UIImage imageNamed:@"返回.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(setBack) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setImageEdgeInsets:UIEdgeInsetsMake(6, 5, 6, 5)];
    UIBarButtonItem *leftSecondItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftSecondItem;
    // Do any additional setup after loading the view.
    
    
    _textView = [[XYTextView alloc]initWithFrame:CGRectMake(self.tView.frame.origin.x, self.tView.frame.origin.y, [UIScreen mainScreen].bounds.size.width - self.tView.frame.origin.x - 8, self.tView.frame.size.height)];
    _textView.backgroundColor = [UIColor whiteColor];
    _textView.font = [UIFont systemFontOfSize:14.f];
    _textView.textColor = [UIColor blackColor];
    _textView.textAlignment = NSTextAlignmentLeft;
    NSLog(@"%f",self.tView.frame.size.width);
    NSLog(@"%f",_textView.frame.size.width);
    NSLog(@"%f",self.textView.contentSize.width);
    NSLog(@"%f",[UIScreen mainScreen].bounds.size.width);
//    [self.textView setPlaceholder:@"服务起价、理念等展示您特色或优势的信息"];
    [self.teSeTextView addSubview:_textView];
    
    
    _textView2 = [[XYTextView alloc]initWithFrame:CGRectMake(self.mView.frame.origin.x, self.mView.frame.origin.y, [UIScreen mainScreen].bounds.size.width - self.mView.frame.origin.x - 8, self.mView.frame.size.height)];
    _textView2.backgroundColor = [UIColor whiteColor];
    _textView2.font = [UIFont systemFontOfSize:14.f];
    _textView2.textColor = [UIColor blackColor];
    _textView2.textAlignment = NSTextAlignmentLeft;
//    [self.textView2 setPlaceholder:@"店铺的主营项目、基本报价、当前规模和经营理念等，以便更多的客户了解您的店铺，增强点击效果！"];
    [self.discrpView addSubview:_textView2];

}

-(void)setBack{
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)publishOKButton:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
