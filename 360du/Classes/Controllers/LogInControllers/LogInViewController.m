//
//  LogInViewController.m
//  360du
//
//  Created by linghang on 15-4-19.
//  Copyright (c) 2015年 wangjian. All rights reserved.
//

#import "LogInViewController.h"
#import "RegisterViewController.h"
#import "AFNetworkTwoPackaging.h"
#import "UIView+Toast.h"
#import "StoreageMessage.h"
#import "MD5SixTeen.h"
#import "ForgetPasswordViewController.h"
@interface LogInViewController ()<UITextFieldDelegate>

@end

@implementation LogInViewController
- (id)init{
    self = [super init];
    if (self) {
        [self makeUI];
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated{
    [self makeNav];
}
- (void)viewDidLoad {
    [super viewDidLoad];
   
    // Do any additional setup after loading the view.
}
-(void)makeNav{
    [self setNavBarImage:@"landi.png"];
    //[self setBackgroud:@"lantiao x.png"];
    [self setBackImageStateName:@"fanhuijian02.png" AndHighlightedName:@""];
    //[self setNavTitleItemWithNameAndImage:@"登陆" imageName:@"360.png"];
    [self setNavTitleItemWithName:@"登陆"];
    
//    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"注册"style:UIBarButtonItemStylePlain target:self action:@selector(leftDown)];
//    self.navigationItem.rightBarButtonItem = leftItem;
    
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, (44 - 30) / 2, 50 * self.numSingleVesion, 30);
    [rightBtn setTitle:@"注册" forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:14 * self.numSingleVesion];
    //rightBtn.backgroundColor = [UIColor whiteColor];
    //rightBtn.layer.cornerRadius = 15 * self.numSingleVesion;
     rightBtn.layer.borderWidth = 1 * self.numSingleVesion;
    rightBtn.layer.borderColor = [[UIColor colorWithRed:(CGFloat)(211) / 255.0 green:(CGFloat)(211) / 255.0 blue:(CGFloat)(211) / 255.0 alpha:1] CGColor];
    rightBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [rightBtn addTarget:self action:@selector(leftDown) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.center = CGPointMake(WIDTH_CONTROLLER - 25 * self.numSingleVesion - 5 * self.numSingleVesion, 22);
    [rightBtn setTitleColor:SMSColor(255, 255, 255) forState:UIControlStateNormal];
    
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightBar;
}
-(void)leftDown{
    //注册
    RegisterViewController *registView = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:registView animated:YES];
}
-(void)makeUI{
    NSArray *array = @[@"login_user.png",@"login_lock.png"];
    NSArray *placeArr = @[@"请输入手机号",@"请输入密码"];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(42 * self.numSingleVesion, 64 + 24 * self.numSingleVesion , (WIDTH_CONTROLLER - 84 * self.numSingleVesion), 45 * self.numSingleVesion * 2)];
    view.layer.cornerRadius = 4;
    view.layer.borderWidth = 1;
    view.layer.borderColor = [[UIColor colorWithRed:(CGFloat)204 / 255.0 green:(CGFloat)204 / 255.0 blue:(CGFloat)204 / 255.0 alpha:1] CGColor];
    [self.view addSubview:view];;
    for (NSInteger i = 0; i < array.count; i++) {
        
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(26 * self.numSingleVesion + 2,  45 * self.numSingleVesion * i, (WIDTH_CONTROLLER - 84 * self.numSingleVesion - 26 * self.numSingleVesion), 45 * self.numSingleVesion)];
        textField.borderStyle = UITextBorderStyleNone;
        textField.clearButtonMode = UITextFieldViewModeAlways;
        if (i == 0) {
            textField.keyboardType = UIKeyboardTypeNumberPad;
        }
        if (i == 1) {
            textField.secureTextEntry = YES;
        }
        textField.delegate = self;
        textField.tag = 1300 + i;
        [view addSubview:textField];
        
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(2, (45 - 28 / 2) / 2* self.numSingleVesion + 45 * self.numSingleVesion * i, 26  / 2 * self.numSingleVesion, 28 / 2* self.numSingleVesion)];
        imageView.image = [UIImage imageNamed:array[i]];
        [view addSubview:imageView];
        textField.placeholder = placeArr[i];
    }
    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 45 * self.numSingleVesion, view.frame.size.width, 1)];
    line.image = [UIImage imageNamed:@"line.png"];
    [view addSubview:line];
    //登陆
    UIButton *logInBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    logInBtn.frame = CGRectMake(42 * self.numSingleVesion, view.frame.size.height + 64 + 20 + 24 * self.numSingleVesion, (WIDTH_CONTROLLER - 84 * self.numSingleVesion), 45 * self.numSingleVesion);
    //[logInBtn setBackgroundImage:[UIImage imageNamed:@"topbg.gif"] forState:UIControlStateNormal];
//    214,61,59
    [logInBtn setBackgroundColor:SMSColor(214, 61, 59)];
  //  [logInBtn setBackgroundColor:[UIColor redColor]];
    [logInBtn addTarget:self action:@selector(logInBtnDown:) forControlEvents:UIControlEventTouchUpInside];
    logInBtn.tag = 1800;
    [logInBtn setTitle:@"登陆" forState:UIControlStateNormal];
    logInBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:logInBtn];
    
    //忘记密码
    UIButton *forgetPasswordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    forgetPasswordBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [forgetPasswordBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [forgetPasswordBtn setTitleColor:[UIColor colorWithRed:(CGFloat)51 / 255.0 green:(CGFloat)51 / 255.0 blue:(CGFloat)51 / 255.0 alpha:1] forState:UIControlStateNormal];
    forgetPasswordBtn.titleLabel.font = [UIFont systemFontOfSize:14 * self.numSingleVesion];
    [forgetPasswordBtn.titleLabel sizeToFit];
    [forgetPasswordBtn addTarget:self action:@selector(logInBtnDown:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetPasswordBtn];
    forgetPasswordBtn.tag = 1801;
    
    NSArray *widthForgetPasswordContraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[forgetPasswordBtn]-42-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(forgetPasswordBtn)];
    NSArray *heightForgetPasswordContranints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[logInBtn]-[forgetPasswordBtn(==20)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(forgetPasswordBtn,logInBtn)];
    [self.view addConstraints:widthForgetPasswordContraints];
    [self.view addConstraints:heightForgetPasswordContranints];
    
    
}
-(void)logInBtnDown:(UIButton *)logInAndRegister{
    if(logInAndRegister.tag == 1800){
        UITextField *userName = (UITextField *)[self.view viewWithTag:1300];
        UITextField *passWord = (UITextField *)[self.view viewWithTag:1301];
        [userName resignFirstResponder];
        [passWord resignFirstResponder];
        if (userName.text.length == 0 ) {
            [self.view makeToast:@"请输入手机号,手机号不能为空!"];
            return;
        }
        if (passWord.text.length == 0) {
            [self.view makeToast:@"请输入密码,密码不能为空!"];
            return;
        }
        
        AFNetworkTwoPackaging *twoPacking = [[AFNetworkTwoPackaging alloc] init];
        [twoPacking getUrl:[NSString stringWithFormat:LOGIN,userName.text,[MD5SixTeen md5:passWord.text]] andFinishBlock:^(id getResult) {
            NSLog(@"getResult:%@",getResult);
            NSDictionary *dict = getResult;
            if ([dict[@"statu"] integerValue] == 1) {
                [StoreageMessage storeMessageUsername:userName.text andPassword:passWord.text andToken:                dict[@"info"][0][@"userid"] ];
               // [self.view makeToast:@"登陆成功!"];
                [UIView animateWithDuration:1 animations:^{
                    [self.view makeToast:@"登陆成功" duration:1 position:nil];

                } completion:^(BOOL finished) {
                    [self.navigationController popViewControllerAnimated:YES];

                }];

            }else{
                [self.view makeToast:@"由于网络问题，请重新登陆!"];
            }
            

        }];
    }else{
        ForgetPasswordViewController *forgetPassword = [[ForgetPasswordViewController alloc] init];
        [self.navigationController pushViewController:forgetPassword animated:YES];
    }
//    BaseViewController *crtl = nil;
//    switch (logInAndRegister.tag) {
//        case 1800:{
//            NSMutableArray *textArr = [NSMutableArray arrayWithCapacity:0];
//            if (![StoreageMessage isStoreMessage]) {
//                [textArr addObject:@""];
//            }
//            else{
//                [textArr addObject:[StoreageMessage getMessage][2]];
//            }
//            for (NSInteger i = 0; i < 2; i++) {
//                UITextField *textField = (UITextField *)[self.view viewWithTag:1300 + i];
//                //[textArr addObject:textField.text];
//            }
//            [textArr addObject:@"18513175036"];
//            [textArr addObject:@"123456"];
//            
//            _rom = [AFHTTPRequestOperationManager manager];
//            _rom.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/json",@"text/html",@"application/json",nil];
//            //NSString *url = [NSString stringWithFormat:STUDY_CATEGORY_ITEM,self.categoryId,22];
//            //            [NSString stringWithFormat:LOGIN,textArr[0],textArr[1],textArr[2]]
//            [_rom GET: [NSString stringWithFormat:LOGIN,textArr[0],textArr[1],textArr[2]]parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//#warning message logIn
//                NSLog(@"%@",[NSString stringWithFormat:LOGIN,textArr[0],textArr[1],textArr[2]]);
//                _model = [[LogInModel alloc] initWithDictionary:responseObject];
//                if (_model.code == 0) {
//#warning message model.uid
//                    NSLog(@"%@",_model.uid);
//                    [StoreageMessage storeMessageUsername: textArr[1] andPassword:textArr[2] andToken:_model.token andUid:_model.uid];
//                }
//                
//                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"警告" message:[self jugeLogIN:[NSString stringWithFormat:@"%ld",(long)_model.code]] delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
//                alertView.delegate = self;
//                [alertView show];
//            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//                [[NSURLCache sharedURLCache] removeAllCachedResponses];
//                NSLog(@"%@",[error description]);
//                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"警告" message:@"网络不流畅，请换个网络试试" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
//                [alertView show];
//                return ;
//            }];
//            break;
//        }
//        case 1801:{
//            crtl = [[ForgetPasswordViewController alloc] init];
//            break;
//        }
//        case 1802:{
//            crtl = [[Register1ViewController alloc] init];
//            break;
//        }
//        default:
//            break;
//    }
//    [self.navigationController pushViewController:crtl animated:YES];
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
