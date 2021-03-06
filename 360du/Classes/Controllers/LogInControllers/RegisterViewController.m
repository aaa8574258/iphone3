//
//  RegisterViewController.m
//  360du
//
//  Created by linghang on 15-4-19.
//  Copyright (c) 2015年 wangjian. All rights reserved.
//

#import "RegisterViewController.h"
#import "NSString+URLEncoding.h"
#import "UIView+Toast.h"
#import "StoreageMessage.h"
#import "MD5SixTeen.h"
#import "LogInViewController.h"
@interface RegisterViewController ()<UITextFieldDelegate>{
    AFHTTPSessionManager *_rom;
}
@property(nonatomic,strong)NSMutableArray *persoalArr;
@property(nonatomic,copy)NSString *messageStr;
@property(nonatomic,copy)NSString *randomStr;
@property(nonatomic,strong)NSTimer *timer;
@property(nonatomic,strong)NSMutableArray *tempDataArr;
@property(nonatomic,assign)NSInteger timerStrBtn;
@property (nonatomic ,strong) UIView *yzmView;
@property (nonatomic ,strong) UITextField *yzmTef;
@end

@implementation RegisterViewController
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.persoalArr = [NSMutableArray arrayWithCapacity:0];
        self.tempDataArr = [NSMutableArray arrayWithCapacity:0];
        [self makeNav];
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
    [self setNavBarImage:@"0.png"];
    //[self setBackgroud:@"lantiao x.png"];
    [self setBackImageStateName:@"fanhuijian2222.png" AndHighlightedName:@""];
    [self setNavTitleItemWithName:@"注册"];
}
-(void)makeUI{
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(42 * self.numSingleVesion, 64 + 18 * self.numSingleVesion, 29 / 2 * self.numSingleVesion, 18 * self.numSingleVesion)];
//    imageView.image = [UIImage imageNamed:@"register_message@2x.png"];
//    [self.view addSubview:imageView];
//    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake((42 + 29 / 2) * self.numSingleVesion + 3, 64 + 18 * self.numSingleVesion, 300, 18 * self.numSingleVesion)];
//    lable.text = @"新同学看过来，即将换号码也没关系，注册后还可以修改哦";
//    lable.font = [UIFont systemFontOfSize:12];
//    [lable sizeToFit];
//    lable.textColor = [UIColor colorWithRed:(CGFloat)153 / 255.0 green:(CGFloat)153 / 255.0 blue:(CGFloat)153 / 255.0 alpha:1];
//    lable.center = CGPointMake((42 + 29 / 2) * self.numSingleVesion + 3 + lable.frame.size.width / 2, 64 + 18 * self.numSingleVesion + 9 * self.numSingleVesion);
//    [self.view addSubview:lable];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(42 * self.numSingleVesion, (10 + 18 + 18) * self.numSingleVesion + 64, (WIDTH_CONTROLLER - 84 * self.numSingleVesion), 40 * 4 * self.numSingleVesion)];
    view.layer.cornerRadius = 4 * self.numSingleVesion;
    view.layer.borderColor = [[UIColor colorWithRed:(CGFloat)213 / 255.0 green:(CGFloat)213 / 255.0 blue:(CGFloat)213 / 255.0 alpha:1] CGColor];
    view.layer.borderWidth = 0.8 * self.numSingleVesion;
    [self.view addSubview:view];
    NSArray *array = @[@"login_user@2x.png",@"login_lock@2x.png",@"login_lock@2x.png",@"login_lock@2x.png"];
    NSArray *placeArr = @[@"请输入手机号",@"请输入密码",@"请重新输入确认密码",@"请输入右侧验证码"];
    for (NSInteger i = 0; i < 4; i++) {
        if (i == 3) {
            UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(0 * self.numSingleVesion,  41 * self.numSingleVesion * 3, 120 * self.numSingleVesion, 36 * self.numSingleVesion)];
            //        textField.backgroundColor = [UIColor redColor];
            textField.borderStyle = UITextBorderStyleNone;
            textField.clearButtonMode = UITextFieldViewModeAlways;
            textField.placeholder = @"输入右侧验证码";
            self.yzmTef = textField;
            [view addSubview:textField];
            [self loadYZMInView:view];
            self.yzmView = view;
        }else{
        
            UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(26 * self.numSingleVesion + 2,  41 * self.numSingleVesion * i, (WIDTH_CONTROLLER - 84 * self.numSingleVesion - 26 * self.numSingleVesion), 40 * self.numSingleVesion)];
            textField.borderStyle = UITextBorderStyleNone;
            textField.clearButtonMode = UITextFieldViewModeAlways;
            if (i != 0) {
                textField.secureTextEntry = YES;
            }
            textField.tag = 1400 + i;
            textField.delegate = self;
            [view addSubview:textField];
            if (i == 0) {
                UILabel *lable = [[UILabel alloc] initWithFrame:CGRectZero];
                lable.text = @"+86";
                lable.font = [UIFont systemFontOfSize:15 * self.numSingleVesion];
                lable.textColor = [UIColor colorWithRed:(CGFloat)153 / 255.0 green:(CGFloat)153 / 255.0 blue:(CGFloat)153 / 255.0 alpha:1];
                [lable sizeToFit];
                lable.frame = CGRectMake(view.frame.size.width - lable.frame.size.width -3 - 15 * self.numSingleVesion, (40 * self.numSingleVesion - lable.frame.size.height) / 2, lable.frame.size.width, lable.frame.size.height);
                lable.center = CGPointMake(view.frame.size.width - lable.frame.size.width / 2 -3 * self.numSingleVesion - 20 * self.numSingleVesion, 40 / 2 * self.numSingleVesion);
                [view addSubview:lable];
            
                textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
            }
           
        
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5 * self.numSingleVesion, (41 - 28 / 2) / 2* self.numSingleVesion + 41 * self.numSingleVesion * i, 26  / 2 * self.numSingleVesion, 28 / 2* self.numSingleVesion)];
            imageView.image = [UIImage imageNamed:array[i]];
            [view addSubview:imageView];
            textField.placeholder = placeArr[i];
            if (i < 3) {
                UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 40 * self.numSingleVesion + 41 * self.numSingleVesion * i, view.frame.size.width, 1 * self.numSingleVesion)];
                line.image = [UIImage imageNamed:@"line_1.jpg"];
                [view addSubview:line];
            }
        }
    }
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(42 * self.numSingleVesion, 64 + view.frame.size.height + (18 + 18 + 10 + 15) * self.numSingleVesion, (WIDTH_CONTROLLER - 84 * self.numSingleVesion) / 3 * 2 - 15 * self.numSingleVesion, 45 * self.numSingleVesion)];
    textField.tag = 1405;
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.placeholder = @"请输入验证码";
    textField.layer.borderColor = [SMSColor(231, 231, 231) CGColor];
    textField.delegate = self;
    [self.view addSubview:textField];
    
    UIButton *codeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    codeBtn.frame = CGRectMake((42 * self.numSingleVesion + textField.frame.size.width + 15 * self.numSingleVesion) , 64 + view.frame.size.height + (18 + 18 + 10 + 15) * self.numSingleVesion, (WIDTH_CONTROLLER - 84 * self.numSingleVesion) / 3  - 15 * self.numSingleVesion + 15 * self.numSingleVesion, 45 * self.numSingleVesion);
    codeBtn.layer.cornerRadius = 4 * self.numSingleVesion;
    //codeBtn.layer.
    //[codeBtn setBackgroundColor:[UIColor orangeColor]];
    [codeBtn setBackgroundColor:[UIColor colorWithRed:(CGFloat)255 / 255.0 green:(CGFloat)136 / 255.0 blue:(CGFloat)0 / 255.0 alpha:1]];
    //
    [codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    codeBtn.titleLabel.font = [UIFont boldSystemFontOfSize:13];
    [codeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    codeBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [codeBtn addTarget:self action:@selector(codeAndRegisterBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:codeBtn];
    
    
    
    codeBtn.tag = 1500;
    
    UIButton *registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    registerBtn.frame = CGRectMake(42 * self.numSingleVesion, 64 + view.frame.size.height + (18 + 18 + 10 + 15 + 15) * self.numSingleVesion + codeBtn.frame.size.height, view.frame.size.width, 45 * self.numSingleVesion);
    //[registerBtn setBackgroundImage:[UIImage imageNamed:@"topbg.gif"] forState:UIControlStateNormal];
    [registerBtn setBackgroundColor:SMSColor(67, 142, 185)];
    [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    registerBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [registerBtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [registerBtn addTarget:self action:@selector(codeAndRegisterBtn:) forControlEvents:UIControlEventTouchUpInside];
    registerBtn.layer.cornerRadius = 4 * self.numSingleVesion;
    [self.view addSubview:registerBtn];
    
}

-(void) loadYZMInView:(UIView *)view{

    
    AFNetworkTwoPackaging *twoPacking = [[AFNetworkTwoPackaging alloc] init];
    
    [twoPacking getUrl:LOADYZM andFinishBlock:^(id getResult) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.frame = CGRectMake(118 * self.numSingleVesion + 2,  41 * self.numSingleVesion * 3, 170 * self.numSingleVesion, 36 * self.numSingleVesion);
        [btn addTarget:self action:@selector(YZMBTN:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btn];
//        UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(118 * self.numSingleVesion + 2,  41 * self.numSingleVesion * 3, 170 * self.numSingleVesion, 36 * self.numSingleVesion)];
//        view1.backgroundColor = [UIColor whiteColor];
        [view addSubview:btn];
        UIImageView *img = [[UIImageView alloc] init];
        img.frame = CGRectMake(0,  0, 100 * self.numSingleVesion, 36 * self.numSingleVesion);
        NSLog(@"%@",getResult[@"datas"][@"imgUrl"]);
        [img sd_setImageWithURL:getResult[@"datas"][@"imgUrl"]];
        [btn addSubview:img];
        UILabel *lab = [[UILabel alloc] init];
        lab.frame = CGRectMake(100 *self.numSingleVesion,  0, 70 * self.numSingleVesion, 36 * self.numSingleVesion);
        lab.text = @"点击刷新";
        lab.font = [UIFont systemFontOfSize:13 * self.numSingleVesion];
        lab.textColor = [UIColor lightGrayColor];
        lab.textAlignment = NSTextAlignmentCenter;
        [btn addSubview:lab];
       
    }];
    
}

-(void)YZMBTN:(UIButton *)sender{
//    [self.yzmTef setText:@""];
    [self loadYZMInView:self.yzmView];
}


-(void)codeAndRegisterBtn:(UIButton *)btn{
    NSLog(@"%@",self.randomStr);
    if (btn.tag == 1500) {

        
        AFNetworkTwoPackaging *twoPacking = [[AFNetworkTwoPackaging alloc] init];
        NSLog(@"%@",[NSString stringWithFormat:ISYZMOK,self.yzmTef.text]);

        [twoPacking getUrl:[NSString stringWithFormat:ISYZMOK,self.yzmTef.text]andFinishBlock:^(id getResult) {
            NSLog(@"%@",getResult);
            
            
            
            
            UITextField *textField = (UITextField *)[self.view viewWithTag:1400];
            //先判断是不是手机号
            if(![self jugeTel:textField.text]){
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警告" message:@"请输入正确手机号!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
                [alert show];
                return;
            }
            //判断密码是否一致
            UITextField *textField1 = (UITextField *)[self.view viewWithTag:1401];
            UITextField *textField2 = (UITextField *)[self.view viewWithTag:1402];
            if (textField1.text.length < 6) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警告" message:@"密码至少为六位!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
                [alert show];
                return;
            }
            if (![textField1.text isEqualToString:textField2.text]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警告" message:@"两次输入密码不一样，请重新输入" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
                [alert show];
                return;
            }
            if ([getResult[@"datas"] isEqualToString:@"验证码无效"]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警告" message:@"验证码输入无效" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
                [alert show];
                return;
            }
            [textField resignFirstResponder];
            [textField1 resignFirstResponder];
            [textField2 resignFirstResponder];
            btn.userInteractionEnabled = NO;
            
            self.timerStrBtn = 60;
            self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerBtn) userInfo:nil repeats:YES];
            _rom = [AFHTTPSessionManager manager];
            _rom.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/json",@"text/html",@"text/xml",@"text/json", nil];
            _rom.requestSerializer = [[AFHTTPRequestSerializer  alloc] init] ;
            _rom.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
            
            if (textField.text.length == 0) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警告" message:@"请输入手机号，手机号不能为空" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
                [alert show];
                return;
            }
            [StoreageMessage giveYZM:[self random]];
            self.randomStr = [StoreageMessage getYZM];
            NSLog(@"%@",self.randomStr);
            
            [_rom GET:[NSString stringWithFormat:MESSAGE,textField.text,self.randomStr.integerValue] parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [StoreageMessage getErrorMessage:@"NULL" fromUrl:[NSString stringWithFormat:MESSAGE,textField.text,self.randomStr.integerValue]];
                
                btn.userInteractionEnabled = YES;
                //            NSLog(@"%@",[NSString stringWithFormat:MESSAGE,textField.text,self.randomStr.integerValue] );
                NSString *str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                if ([str isEqualToString:@"reg"]) {
                    [self.view makeToast:@"手机号已经注测过，请重新注册!"];
                    return ;
                }
                NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
                NSDictionary *dcit = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                NSLog(@"%@",dcit);
                
                if ([dcit[@"code"] isEqualToString:@"000000"]) {
                    //[UIView s]
                    [self.view makeToast:@"短信发送成功,请注意查收!"];
                    
                }else{
                    [self.view makeToast:@"短信发送失败,请重新发送!"];
                }
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                btn.userInteractionEnabled = YES;
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警告" message:@"由于网络问题，请重新获取一下验证码" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
                [alert show];
            }];

            
        }];
        //手机号

       
//        NSString *messageStr = [NSString stringWithFormat:@"欢迎您注册微知库APP，您的验证是%@祝您学习愉快。",self.randomStr];
//        [_rom GET:[NSString stringWithFormat:@"33",[messageStr urlEncodeString],textField.text] parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//            NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//            NSRange range = [string rangeOfString:@"result="];
//            if(range.location != NSNotFound){
//                NSString *subStrRange = [string substringWithRange:NSMakeRange(range.location + 8, 1)];
//                [self makeSubStringRange:subStrRange];
//                if ([subStrRange isEqualToString:@"1"]) {
//                    UITextField *textField1 = (UITextField *)[self.view viewWithTag:1401];
//                    UITextField *textField2 = (UITextField *)[self.view viewWithTag:1402];
//                    UITextField *textField = (UITextField *)[self.view viewWithTag:1400];
//#warning message 以后改过来
//                    //                    textField.userInteractionEnabled = NO;
//                    //                    textField2.userInteractionEnabled = NO;
//                    //                    textField1.userInteractionEnabled = NO;
//                }
//            }
//        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//            NSLog(@"%@",error);
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警告" message:@"由于网络问题，请重新获取一下验证码" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
//            [alert show];
//        }];
    }else{
        self.randomStr = [StoreageMessage getYZM];

        //判断密码是否一致
        UITextField *textField1 = (UITextField *)[self.view viewWithTag:1401];
        UITextField *textField2 = (UITextField *)[self.view viewWithTag:1402];
        UITextField *textField = (UITextField *)[self.view viewWithTag:1400];
        [textField resignFirstResponder];
        //先判断是不是手机号
        if(![self jugeTel:textField.text]){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警告" message:@"请输入正确手机号!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
            [alert show];
            return;
        }
        if (textField1.text.length < 6) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警告" message:@"密码至少为六位!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
            [alert show];
            return;
        }
        if (![textField1.text isEqualToString:textField2.text]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警告" message:@"两次输入密码不一样，请重新输入" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
            [alert show];
            return;
        }
        UITextField *textField5 = (UITextField *)[self.view viewWithTag:1405];
        NSLog(@"%@",self.randomStr);

        if (![textField5.text isEqualToString:self.randomStr]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警告" message:@"验证码不对,请重新获取验证码" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
            [alert show];
            return;
        }
        if (textField.text.length == 0) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警告" message:@"请输入手机号，手机号不能为空" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
            [alert show];
            return;
        }
        _rom = [AFHTTPSessionManager manager];
        _rom.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/json",@"text/html",@"text/xml",@"text/json", nil];
        _rom.requestSerializer = [[AFHTTPRequestSerializer  alloc] init] ;
        _rom.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
        
  
        NSString *tempStr = self.randomStr;
        NSString *passwordStr = [MD5SixTeen md5:textField1.text];
        [_rom GET:[NSString stringWithFormat:REGISTER,textField.text,passwordStr,tempStr] parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [StoreageMessage getErrorMessage:@"NULL" fromUrl:[NSString stringWithFormat:REGISTER,textField.text,passwordStr,tempStr]];

            NSString *str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];

            NSData *backData = [str dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:backData options:NSJSONReadingMutableLeaves error:nil];
//            NSLog(@"%@",dict);
            [self.view makeToast:dict[@"message"]];
            btn.userInteractionEnabled = NO;
//            __block int timeout=59; //倒计时时间
//            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//            dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
//            dispatch_source_set_timer(timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
//            dispatch_source_set_event_handler(timer, ^{
//                if(timeout<=0){ //倒计时结束，关闭
//                    dispatch_source_cancel(timer);
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        //设置界面的按钮显示 根据自己需求设置
////                    [btn setTitle:@"发送验证码" forState:UIControlStateNormal];
////                        btn.userInteractionEnabled = YES;
//                    });
//                }else{
//                    //            int minutes = timeout / 60;
//                    int seconds = timeout % 60;
//                    NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        //设置界面的按钮显示 根据自己需求设置
//                        [btn setTitle:[NSString stringWithFormat:@"%@秒后重新发送",strTime] forState:UIControlStateNormal];
//                        btn.userInteractionEnabled = NO;
//                        
//                    });
//                    timeout--;
//                    
//                }
//            });
//            dispatch_resume(timer);

            
            if ([dict[@"code"] isEqualToString:@"000000"]) {
//                [StoreageMessage storeMessageUsername:textField.text andPassword:passwordStr andToken:@""];
//                
//                [self.navigationController popToRootViewControllerAnimated:YES];
                LogInViewController *logIn = [[LogInViewController alloc] init];
                logIn.target = self;
                [self.navigationController pushViewController:logIn animated:YES];
            }else{
                
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警告" message:@"由于网络问题，请重新获取一下验证码" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
            [alert show];
        }];
    }
}
//判断注册情况
-(void)jugeReister:(NSString *)code{
    
}
//判断验证码
-(void)makeSubStringRange:(NSString *)subString{
    switch (subString.integerValue) {
        case 1:{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"恭喜" message:@"短信发送成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
            [alert show];
            break;
        }
        case -4:{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警告" message:@"请输入正确的手机号" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
            [alert show];
            break;
        }
        default:{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警告" message:@"由于网络问题，请重新获取一下验证码" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
            [alert show];
            break;
        }
    }
}
//随机数
-(NSString *)random{
    NSMutableString *numStr = [NSMutableString stringWithCapacity:0];
    for (NSInteger i = 0; i < 4; i++) {
        NSInteger num1 = arc4random() % 9;
        [numStr appendString:[NSString stringWithFormat:@"%ld",num1]];
    }
    if (numStr.length != 4) {
        return [self random];
    }
    return numStr;
}
#pragma mark 判断是不是手机号
-(BOOL)jugeTel:(NSString *)telPhone{
    //手机号以13， 15，18开头，八个 \d 数字字符
    // NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSString *phoneRegex = @"^((13[0-9])|(17[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    //(13|17)[0-9]
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:telPhone];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [self.timer invalidate];
    self.timer = nil;
}
#pragma mark time
- (void)timerBtn{
    
    UIButton *btn = (UIButton *)[self.view viewWithTag:1500];
    if (self.timerStrBtn == 0 && [btn.titleLabel.text isEqualToString:@"0s"]) {
        [btn setTitle:[NSString stringWithFormat:@"重新发送"] forState:UIControlStateNormal];

        btn.userInteractionEnabled = YES;
        [self.timer invalidate];
        self.timer = nil;

    }else{
        btn.userInteractionEnabled = NO;

        self.timerStrBtn--;
        [btn setTitle:[NSString stringWithFormat:@"%lds",self.timerStrBtn] forState:UIControlStateNormal];
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
