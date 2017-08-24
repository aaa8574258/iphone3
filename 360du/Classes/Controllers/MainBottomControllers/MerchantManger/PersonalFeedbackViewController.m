//
//  PersonalFeedbackViewController.m
//  360du
//
//  Created by linghang on 15/12/18.
//  Copyright © 2015年 wangjian. All rights reserved.
//

#import "PersonalFeedbackViewController.h"
#import "NSString+URLEncoding.h"
#import "AFNetworkTwoPackaging.h"
#import "UIView+Toast.h"
#import "StoreageMessage.h"
#import "NSString+NSString.h"
@interface PersonalFeedbackViewController ()<UITextViewDelegate,UITextFieldDelegate>

@end

@implementation PersonalFeedbackViewController
- (id)init{
    self = [super init];
    if (self) {
        [self makeNav];
        [self makeUI];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    // Do any additional setup after loading the view.
}
- (void)makeNav{
//    [self setNavBarImage:@"landi.png"];
//    //[self setBackgroud:@"lantiao x.png"];
//    [self setBackImageStateName:@"fanhuijian02.png" AndHighlightedName:@""];
//    //[self setNavTitleItemWithNameAndImage:@"登陆" imageName:@"360.png"];
//    [self setNavTitleItemWithName:@"意见反馈"];
    
    
    
    [self setNavBarImage:@"0.png"];
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(WIDTH_CONTROLLER - 32 , (44 - 20) / 2, 15, 15);
    [leftBtn setImage:[UIImage imageNamed:@"fanhuijian2222.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(setBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftSecondItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    //self.navigationItem.leftBarButtonItem = leftSecondItem;
    //[self setBackgroud:@"lantiao x.png"];
    //[self setBackImageStateName:@"fanhuijian02.png" AndHighlightedName:@""];
    
    
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    //view.backgroundColor = MAINVIEWNAVBARCOLOR;
    //[self.view addSubview:view];
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectZero];
    lable.text = @"意见反馈";
    lable.font = [UIFont systemFontOfSize:15 * self.numSingleVesion];
    lable.textColor = [UIColor blackColor];
    [lable sizeToFit];
    lable.frame = CGRectMake(5 * self.numSingleVesion, 0 + (44 - 15) / 2, lable.frame.size.width, 15);
    [view addSubview:lable];
    view.frame = CGRectMake(0, 0, lable.frame.size.width, 44);
    UIBarButtonItem *centerBar = [[UIBarButtonItem alloc] initWithCustomView:view];
    //self.navigationItem.titleView = view;
    self.navigationItem.leftBarButtonItems = @[leftSecondItem,centerBar];
    
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.frame = CGRectMake(WIDTH_CONTROLLER - 50 * self.numSingleVesion, (44 - 34 * self.numSingleVesion) / 2, 40 * self.numSingleVesion, 34 * self.numSingleVesion);
    [searchBtn setTitle:@"提交" forState:UIControlStateNormal];
    searchBtn.titleLabel.font = [UIFont systemFontOfSize:13 * self.numSingleVesion];
    [searchBtn addTarget:self action:@selector(btnDown) forControlEvents:UIControlEventTouchUpInside];
    [searchBtn setTitleColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1] forState:UIControlStateNormal];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:searchBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}



- (void)makeUI{
    //建议描述
//    UILabel *descLab = [[UILabel alloc] initWithFrame:CGRectMake(10 * self.numSingleVesion, 64 + 10 * self.numSingleVesion, 200 * self.numSingleVesion, 15 * self.numSingleVesion)];
//    descLab.font = [UIFont systemFontOfSize:16];
//    descLab.text = @"建议描述:";
//    descLab.textColor = SMSColor(51, 51, 51);
//    [self.view addSubview:descLab];
    //textView
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(10 * self.numSingleVesion, 64 + 10 * self.numSingleVesion, WIDTH_CONTROLLER - 20 * self.numSingleVesion, 150 * self.numSingleVesion)];
    [self.view addSubview:textView];
    textView.delegate = self;
    textView.layer.cornerRadius = 1 * self.numSingleVesion;
    textView.layer.borderWidth = 1 * self.numSingleVesion;
    textView.layer.borderColor = [SMSColor(204, 204, 204) CGColor];
    textView.tag = 2300;
    //placeholder
    UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake(10 * self.numSingleVesion, 10 * self.numSingleVesion, 250, 20)];
    lab.font = [UIFont systemFontOfSize:12 * self.numSingleVesion];
    lab.text = @"你的反馈将帮助我们更快的成长";
    [textView addSubview:lab];
    lab.tag = 2000;
    lab.textColor = SMSColor(204, 204, 204);
    
    //联系方式
//    UILabel *contactLab = [[UILabel alloc] initWithFrame:CGRectMake(10 * self.numSingleVesion, 64 + 30 * self.numSingleVesion + 200 * self.numSingleVesion + 30 * self.numSingleVesion, 200 * self.numSingleVesion, 15 * self.numSingleVesion)];
//    contactLab.font = [UIFont systemFontOfSize:16];
//    contactLab.text = @"联系方式:";
//    contactLab.textColor = SMSColor(51, 51, 51);
//    [self.view addSubview:contactLab];
    //输入框
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(10 * self.numSingleVesion, 64 + 200 * self.numSingleVesion, WIDTH_CONTROLLER - 20 * self.numSingleVesion, 30 * self.numSingleVesion)];
    textField.layer.cornerRadius = 1 * self.numSingleVesion;
    textField.layer.borderColor = [[UIColor clearColor] CGColor];
    textField.layer.borderWidth = 1 * self.numSingleVesion;
    [self.view addSubview:textField];
    textField.placeholder = @"请输入联系方式 (QQ或者手机号)";
//    textField.
    [textField setValue:SMSColor(204, 204, 204) forKeyPath:@"_placeholderLabel.textColor"];
    [textField setValue:[UIFont systemFontOfSize:12 * self.numSingleVesion] forKeyPath:@"_placeholderLabel.font"];
    textField.delegate = self;
    textField.tag = 2100;
    
    UIView *vie = [[UIView alloc] initWithFrame:CGRectMake(10 * self.numSingleVesion, 64 + 230 *self.numSingleVesion, WIDTH_CONTENTVIEW - 20 * self.numSingleVesion, 1 * self.numSingleVesion)];
    vie.backgroundColor = SMSColor(204, 204, 204);
    [self.view addSubview:vie];
    //提交
//    UIButton *commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    commitBtn.frame = CGRectMake(10 * self.numSingleVesion,  64 + 210 * self.numSingleVesion, WIDTH_CONTROLLER - 20 * self.numSingleVesion, 40 * self.numSingleVesion);
//    commitBtn.backgroundColor = SMSColor(228, 53, 53);
//    [self.view addSubview:commitBtn];
//    [commitBtn setTitle:@"提交" forState:UIControlStateNormal];
//    [commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [commitBtn addTarget:self action:@selector(btnDown) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:commitBtn];

    
}
- (void)btnDown{
    UITextView *textView = (UITextView *)[self.view viewWithTag:2300];
    UITextField *textField = (UITextField *)[self.view viewWithTag:2100];
    if (textView.text.length == 0) {
        [self.view makeToast:@"请填写反馈意见"];
        return;
    }else if (textField.text.length == 0){
        [self.view makeToast:@"请填写邮箱或者手机号"];
        return;
    }else if (![textField.text jugeEamil] && ![textField.text jugeTel]){
        [self.view makeToast:@"请填写正确邮箱或者手机号"];
        return;
    }
    AFNetworkTwoPackaging *twoPack = [[AFNetworkTwoPackaging alloc] init];
    [twoPack getUrl:[NSString stringWithFormat:OPINONFEEDBACK,[StoreageMessage getMessage][2],[textView.text urlEncodeString],textField.text] andFinishBlock:^(id getResult) {
        [self.view makeToast:getResult[@"message"]];
        /**
         *  阻塞的延时
         *
         *  @param delNotification <#delNotification description#>
         *
         *  @return <#return value description#>
         */
        [self performSelector:@selector(delNotification) withObject:nil afterDelay:1.0f];
        if ([getResult[@"code"] isEqual:@"000000"]) {

        }
    }];
    
}

-(void)delNotification{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark textView的代理
//开始编辑的时候触发
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    UILabel *label = (UILabel*)[self.view viewWithTag:2000];
    label.hidden = YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    UITextView *textView = (UITextView *)[self.view viewWithTag:2300];
    [textView resignFirstResponder];
    return YES;
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
