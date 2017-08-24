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
#import "ProertyDetialTableViewCell.h"
#import "PropertyDetialModel.h"
#import "DetialWeiXiu.h"
#import "FZHPopView.h"
#import "FixMasterOneViewController.h"
#import "FixMasterTwoViewController.h"
#import "FixMasterThreeViewController.h"
#import "StoreageMessage.h"
#import "NSString+URLEncoding.h"
#import "ShowImageViewController.h"

#import "ProertyMendAndServerListViewController.h"
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
@interface ProertyMendDeatilViewController ()<UITableViewDelegate,UITableViewDataSource,UIWebViewDelegate,FZHPopViewDelegate>
@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic ,strong) UISegmentedControl *segmentView;
@property (nonatomic, strong) UIView *SecondView;
@property (nonatomic ,strong) UIWebView *webView;
@property (nonatomic ,copy) NSString *RepairTime;
@property (nonatomic ,copy) NSString *ReservationTime;
@property (nonatomic ,copy) NSString *phone;
@property (nonatomic ,copy) NSString *name;
@property (nonatomic ,copy) NSString *htmlStr;
@property (nonatomic ,copy) NSString *address;
@property (nonatomic ,copy) NSString *RepairContent;
//@property (nonatomic ,copy) NSString *pbid;
@property (nonatomic ,strong) NSArray *imageArr;
@property (nonatomic ,strong) NSMutableArray *DetailArr;
@property (nonatomic, strong) NSMutableArray *titleArray;
@property (nonatomic ,strong)UIButton *btn1;
@property (nonatomic ,strong) UIButton *btn2;
@property (nonatomic ,strong) UIDatePicker *dataPicker;
@property (nonatomic ,copy) NSString *time1;


@property (nonatomic ,copy) NSString *propertyMendId;
@end

@implementation ProertyMendDeatilViewController{
    FZHPopView * _fzhPopView;
}
- (id)initWithProertyMendId:(NSString *)proertyMendId{
    self = [super init];
    if (self) {
//        NSLog( @"%@",proertyMendId);
        self.pbid = proertyMendId;
        self.propertyMendId = proertyMendId;
    }
    return self;
}
- (NSMutableArray *)titleArray{
    if (!_titleArray) {
        _titleArray = [NSMutableArray array];
    }
    return _titleArray;
}




- (void)makeNav{
    [self setNavBarImage:@"0.png"];
    //[self setBackgroud:@"lantiao x.png"];
    [self setBackImageStateName:@"fanhuijian2222.png" AndHighlightedName:@""];
    
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    //view.backgroundColor = MAINVIEWNAVBARCOLOR;
    //[self.view addSubview:view];
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectZero];
    lable.text = self.title1;
    lable.font = [UIFont systemFontOfSize:16 * self.numSingleVesion];
    lable.textColor = [UIColor blackColor];
    [lable sizeToFit];
    lable.frame = CGRectMake(5 * self.numSingleVesion, 0 + (44 - 15) / 2, lable.frame.size.width, 15);
    [view addSubview:lable];
    view.frame = CGRectMake(0, 0, lable.frame.size.width, 44);
    //UIBarButtonItem *centerBar = [[UIBarButtonItem alloc] initWithCustomView:view];
    self.navigationItem.titleView = view;
}
- (void)loadDataWithProertyMendId:(NSString *)proertyMendID{
//    [self makeHUd];
    AFNetworkTwoPackaging *twoPack = [[AFNetworkTwoPackaging alloc] init];
    [twoPack getUrl:[NSString stringWithFormat:PEOERTYMENDDEATIL,proertyMendID] andFinishBlock:^(id getResult) {
        [self hudWasHidden:self.hudProgress];
        self.array = [NSMutableArray arrayWithCapacity:0];
//        NSLog(@"1211212%@",getResult);
//        NSLog(@"url:%@",[NSString stringWithFormat:PEOERTYMENDDEATIL,proertyMendID] );
//        NSLog(@"getResult:%@",getResult);
        
        if (!getResult) {
            [self.view makeToast:@"没有发布状态!"];
            return ;
            
//        }
//        if ([getResult[@"success"] isEqual:@"no"]) {
//            [self.view makeToast:getResult[@"message"]];
        }
        for (NSDictionary *dic in getResult) {
            PropertyDetialModel *model = [[PropertyDetialModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [self.array addObject:model];
        }
//            [self makeUIWithContent:getResult[@"datas"][@"repairContent"] andTime:getResult[@"datas"][@"reservationTime"] andPbId:getResult[@"datas"][@"pbID"]];
//        for ; ; <#increment#>) {
//            <#statements#>
//        }<#condition#>
//        NSLog(@"%@",getResult[0]);
//        [self makeUIWithContent:getResult[0][@"content"] andTime:getResult[0][@"statusTime"] andPbId:getResult[0][@"pbID"]];
//        }
        [self.tableView reloadData];
    }];
}
- (void)makeUIWithContent:(NSString *)content andTime:(NSString *)time andPbId:(NSString *)pbID{
    NSLog(@"%@",time);
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


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _array.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 110*self.numSingleVesion;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ProertyDetialTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"proertyMendDeatilCell"];
    if (!cell) {
        cell = [[ProertyDetialTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"proertyMendDeatilCell"];
    }
    
        PropertyDetialModel *model = _array[indexPath.row];
        cell.imageView1.image = [UIImage imageNamed:@"person_buying"];
        cell.statuslabel.text = [NSString stringWithFormat:@"发布时间:%@",model.statusTime];
        
        cell.pbIDlabel.text = [NSString stringWithFormat:@"维修编号:%@",model.PbID];

        cell.contentlabel.text = [NSString stringWithFormat:@"当前进度:%@",model.content];

    return cell;
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

-(void)viewWillAppear:(BOOL)animated{
    [self loadDataWithProertyMendId:_propertyMendId];
    [self getInfoFromProertyMendID:_propertyMendId];
    [self makeNav];
    [self makeSegment];
    
    self.view.backgroundColor = [UIColor whiteColor];
    NSLog(@"%@",self.target);
    if ([self.target isKindOfClass:[FixMasterOneViewController class]] || [self.target isKindOfClass:[ProertyMendAndServerListViewController class]]) {
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y + 64 +40, self.view.frame.size.width, self.view.frame.size.height - 40 - 104)];
        UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn1.frame = CGRectMake(0, self.view.frame.size.height - 40, self.view.frame.size.width/2-0.5, 40 );
        btn1.tag = 151884;
        [btn1 setTitle:@"完成任务" forState:UIControlStateNormal];
        [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn1 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        btn1.backgroundColor = [UIColor colorWithRed:255/255.0 green:40/255.0 blue:79/255.0 alpha:1];
        [self.view addSubview:btn1];
        
        UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn2.frame = CGRectMake(self.view.frame.size.width/2, self.view.frame.size.height - 40, self.view.frame.size.width/2 - 0.5, 40 );
        btn2.tag = 151885;
        [btn2 setTitle:@"未完成任务" forState:UIControlStateNormal];
        btn2.backgroundColor = [UIColor colorWithRed:255/255.0 green:40/255.0 blue:79/255.0 alpha:1];

        [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

        [btn2 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn2];
//        self.btn2 = btn2;
    }else if ([self.target isKindOfClass:[FixMasterThreeViewController class]]){
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y + 64 +40, self.view.frame.size.width, self.view.frame.size.height - 40 - 104)];
        UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn1.frame = CGRectMake(0, self.view.frame.size.height - 40, self.view.frame.size.width/2-0.5, 40 );
        btn1.tag = 151886;
        [btn1 setTitle:@"选择维修时间" forState:UIControlStateNormal];
        [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn1 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        btn1.backgroundColor = [UIColor colorWithRed:255/255.0 green:40/255.0 blue:79/255.0 alpha:1];
        [self.view addSubview:btn1];
        self.btn1 = btn1;

        UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn2.frame = CGRectMake(self.view.frame.size.width/2, self.view.frame.size.height - 40, self.view.frame.size.width/2 - 0.5, 40 );
        btn2.tag = 151887;
        [btn2 setTitle:@"接受此任务" forState:UIControlStateNormal];
        btn2.backgroundColor = [UIColor colorWithRed:255/255.0 green:40/255.0 blue:79/255.0 alpha:1];
        
        [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [btn2 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn2];

    }else{
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y + 64 +40, self.view.frame.size.width, self.view.frame.size.height - 40)];
    }
    [self makeSecondView];
    //    self.SecondView = [[UIView alloc] initWithFrame:self.tableView.frame];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //    self.tableView.backgroundColor = [UIColor blueColor];
    //    [self.view addSubview:self.SecondView];
    [self.view addSubview:self.tableView];

}
-(void)makeDatePicker{
    UIDatePicker *datePick = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, HEIGHT_CONTROLLER - 250 * self.numSingleVesion, WIDTH_CONTROLLER, 200 * self.numSingleVesion)];
    [datePick addTarget:self action:@selector(datePickDown) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:datePick];
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:NSTimeIntervalSince1970];
    [datePick setMinimumDate:date];
    self.dataPicker = datePick;
    datePick.hidden = YES;
    
    //datePick.datePickerMode = UIDatePickerModeCountDownTimer;
    
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)datePickDown{
    NSDate *select = [self.dataPicker date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *dateAndTime = [dateFormatter stringFromDate:select];
    
    NSTimeInterval a=[select timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%ld", (long)a];
    self.time1 = [NSString stringWithFormat:@"%lld",timeString.longLongValue * 1000];

    self.btn1.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.btn1 setTitle:[NSString stringWithFormat:@"维修时间:%@",dateAndTime] forState:UIControlStateNormal];
//    NSLog(@"%@---%@-----%@",self.time1,self.pbid,[NSString stringWithFormat:ISHAVETHISFIX,[StoreageMessage getMessage][2],self.time1,self.pbid]);

}

-(void)btnAction:(UIButton *)sender{
    if (sender.tag == 151884) {
          UIAlertView  *customAlertView = [[UIAlertView alloc] initWithTitle:@"输入文字内容" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil ];
        
        [customAlertView setAlertViewStyle:UIAlertViewStylePlainTextInput];
        customAlertView.tag = 111111;
        UITextField *nameField = [customAlertView textFieldAtIndex:0];
        nameField.placeholder = @"输入文字内容";
        [customAlertView show];
    }else if (sender.tag == 151885){
        UIAlertView  *customAlertView = [[UIAlertView alloc] initWithTitle:@"输入文字内容" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil ];
        customAlertView.tag = 111112;
        [customAlertView setAlertViewStyle:UIAlertViewStylePlainTextInput];
        
        UITextField *nameField = [customAlertView textFieldAtIndex:0];
        nameField.placeholder = @"输入文字内容";
        [customAlertView show];
    }else if (sender.tag == 151886){
        [self makeDatePicker];
        self.dataPicker.hidden = NO;
        

    
    }else if (sender.tag == 151887){
        
//        NSString *str = [self getDate:self.time1];
//        NSLog(@"%@--%@",str,self.time1);
//        if
        if (self.time1.length ==0) {
            [self.view makeToast:@"请选择时间"];
        }else{
            AFNetworkTwoPackaging *twoPacking = [[AFNetworkTwoPackaging alloc] init];
            [twoPacking getUrl:[NSString stringWithFormat:ISOTHERMASTER,[StoreageMessage getMessage][2],self.pbid] andFinishBlock:^(id getResult) {
                NSLog(@"%@",getResult);
//                if (![getResult[@"code"] isEqualToString:@"000000"]) {
//                    [self.view makeToast:getResult[@"message"]];
//                }else{
//                    [self.view makeToast:getResult[@"message"]];
//                }
                AFNetworkTwoPackaging *twoPacking = [[AFNetworkTwoPackaging alloc] init];
                [twoPacking getUrl:[NSString stringWithFormat:ISHAVETHISFIX,[StoreageMessage getMessage][2],self.time1,self.pbid] andFinishBlock:^(id getResult) {
                    self.dataPicker.hidden = YES;
                    NSLog(@"%@",getResult);
                    if ([getResult[@"code"] isEqualToString:@"000000"]) {
                        [self.navigationController popViewControllerAnimated:YES];
                        [self.view makeToast:getResult[@"message"]];
                        UIAlertView  *customAlertView = [[UIAlertView alloc] initWithTitle:@"接单成功" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil ];
                        
                        [customAlertView show];
                    }
                    
                }];
            }];
        }
    }
}

-(void)alertView : (UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *str111;
    if ([self.target isKindOfClass:[FixMasterOneViewController class]]) {
        str111 = @"2";
    }else{
        str111 = @"1";
    }
    
    
    
    if (buttonIndex == 1) {
        UITextField *tf=[alertView textFieldAtIndex:0];

        if (alertView.tag == 111111) {
            AFNetworkTwoPackaging *twoPacking = [[AFNetworkTwoPackaging alloc] init];
            [twoPacking getUrl:[NSString stringWithFormat:ISOKFIX,[StoreageMessage getMessage][2],self.pbid,@"2",[[tf.text urlEncodeString] urlEncodeString],str111] andFinishBlock:^(id getResult) {
                NSLog(@"%@",[NSString stringWithFormat:ISOKFIX,[StoreageMessage getMessage][2],self.pbid,@"2",[[tf.text urlEncodeString] urlEncodeString],str111]);
                [self.view makeToast:getResult[@"message"]];
                [self.navigationController popViewControllerAnimated:YES];
            }];
        }else if (alertView.tag == 111112){
            AFNetworkTwoPackaging *twoPacking = [[AFNetworkTwoPackaging alloc] init];
            [twoPacking getUrl:[NSString stringWithFormat:ISOKFIX,[StoreageMessage getMessage][2],self.pbid,@"1",[[tf.text urlEncodeString] urlEncodeString],str111] andFinishBlock:^(id getResult) {
                NSLog(@"%@",[NSString stringWithFormat:ISOKFIX,[StoreageMessage getMessage][2],self.pbid,@"1",tf.text,str111]);
                [self.view makeToast:getResult[@"message"]];
                [self.navigationController popViewControllerAnimated:YES];

            }];
        
        }
    }
    //得到输入框
    
}


#pragma mark-once 得到当前的时间

-(NSString *)getDate:(NSString *)date

{
    
    long long time=[date longLongValue];
    
    NSDate *d = [[NSDate alloc]initWithTimeIntervalSince1970:time/1000.0];
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];//格式化
    
    [df setDateFormat:@"yy-MM-dd HH:mm"];
    
    [df setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"] ];
    
    NSString * timeStr =[df stringFromDate:d];
    
    return timeStr;
    
}

- (void)initTitleArray{
    if (!self.phone) {
        self.phone = @"暂未添加";
    }
    [self.titleArray addObject:[NSString stringWithFormat:@"姓名:%@   电话:%@",self.name,self.phone]];
    [self.titleArray addObject:[NSString stringWithFormat:@"地址:%@",self.address]];
    [self.titleArray addObject:[NSString stringWithFormat:@"报修时间:%@",self.RepairTime]];
    [self.titleArray addObject:[NSString stringWithFormat:@"预约时间:%@",self.ReservationTime]];

}
-(void) makeSegment{

    self.segmentView = [[UISegmentedControl alloc] initWithItems:@[@"当前状态",@"详细信息"]];
    
    self.segmentView.tintColor = [UIColor whiteColor];
//    self.segmentView setti
//    [self.segmentView setTintColor:[UIColor lightGrayColor]];
    self.segmentView.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y + 64, self.view.frame.size.width, 40);
    self.segmentView.selectedSegmentIndex = 0;
    [self.view addSubview:self.segmentView];
    [self.segmentView addTarget:self action:@selector(changeViewAction:) forControlEvents:UIControlEventValueChanged];
}

-(void)changeViewAction:(UISegmentedControl *)sender{
//    NSLog(@"%ld",sender.selectedSegmentIndex);
    switch (sender.selectedSegmentIndex) {
        case 0:
            [self.SecondView removeFromSuperview];
            [self.view addSubview:self.tableView];
            [self.tableView reloadData];
            break;
        case 1:
            [self.tableView removeFromSuperview];
            [self.view addSubview:self.SecondView];
            break;
        default:
            break;
    }
    
}

-(void)makeSecondView{
    self.SecondView = [[UIView alloc] initWithFrame:self.tableView.frame];
    [self.view addSubview:self.SecondView];
}


-(void)makeWebView{
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0,30,self.view.frame.size.width,700)];
    webView.delegate = self;
    [self.SecondView addSubview:webView];
    webView.dataDetectorTypes = UIDataDetectorTypeAll;
    webView.userInteractionEnabled = YES;
    webView.scrollView.showsHorizontalScrollIndicator = NO;
    webView.layer.borderWidth = 1 * self.numSingleVesion;
    webView.layer.borderColor = [[UIColor colorWithRed:(CGFloat) 221 / 255.0  green:(CGFloat) 221 / 255.0 blue:(CGFloat) 221 / 255.0 alpha:1] CGColor];
    webView.scalesPageToFit = YES;
    self.webView = webView;
    [webView loadHTMLString:self.htmlStr baseURL:nil];
    
  
}

-(void) makelatImageAndLabOnView:(UIView *)view{
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 1 * self.numSingleVesion)];
    view1.backgroundColor = [UIColor lightGrayColor];
    [view addSubview:view1];
    
    UILabel *lab1 = [[UILabel alloc] initWithFrame:CGRectMake(10 * self.numSingleVesion, 10 *self.numSingleVesion, self.view.frame.size.width - 20, 20)];
    lab1.text = @"详情";
    lab1.font = [UIFont systemFontOfSize:13 * self.numSingleVesion];
    [view addSubview:lab1];
    
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(0, 42 *self.numSingleVesion, self.view.frame.size.width, 1 * self.numSingleVesion)];
    view2.backgroundColor = [UIColor lightGrayColor];
    [view addSubview:view2];
    
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(10 * self.numSingleVesion, 53 * self.numSingleVesion, view.frame.size.width, 100 * self.numSingleVesion)];
    lab.text = self.RepairContent;
    lab.font = [UIFont systemFontOfSize:13 * self.numSingleVesion];
    [lab sizeToFit];
    [view addSubview:lab];
    NSLog(@"%lu",(unsigned long)self.imageArr.count);
    if (self.imageArr.count != 0) {
        for (NSInteger i = 0; i < self.imageArr.count; i ++) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10 * self.numSingleVesion + i * 80 * self.numSingleVesion, lab.frame.size.height + 83 * self.numSingleVesion , 75 * self.numSingleVesion, 75 * self.numSingleVesion)];
            imageView.tag = i + 2000;
            imageView.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImageView:)];
            [imageView addGestureRecognizer:tap];
            [imageView sd_setImageWithURL:[NSURL URLWithString:self.imageArr[i]]];

            [view addSubview:imageView];
 
        }
    }

}

-(void)tapImageView:(UITapGestureRecognizer *)tap
{
    NSLog(@"%@---%ld",self.imageArr,tap.view.tag);
    ShowImageViewController *vc = [[ShowImageViewController alloc] init];
    vc.clickTag = tap.view.tag;
    vc.imageViews = self.imageArr;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)makeOtherLabel{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(0, 0, self.view.frame.size.width, 30);
    [btn setTitle:@"点击此处可以查看详细信息" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor lightGrayColor]forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.SecondView addSubview:btn];
    //    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(8, 8, 100, 30)];
    //    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(173, 8, 100, 30)];
    //    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(8,38, self.view.frame.size.width - 16, 30)];
    //    UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake(8, 68, self.view.frame.size.width - 16, 30)];
    //    UILabel *label5 = [[UILabel alloc] initWithFrame:CGRectMake(8, 98, self.view.frame.size.width - 16, 30)];
    //    label1.text = self.name;
    //    label2.text = self.phone;
    //    label3.text = self.address;
    //    label4.text = [NSString stringWithFormat:@"保修时间:%@",self.RepairTime];
    //    label5.text = [NSString stringWithFormat:@"预约时间:%@",self.ReservationTime];
    //    [self.SecondView addSubview:label1];
    //    [self.SecondView addSubview:label2];
    //    [self.SecondView addSubview:label3];
    //    [self.SecondView addSubview:label4];
    //    [self.SecondView addSubview:label5];
    [self initTitleArray];

}


-(void)getInfoFromProertyMendID:(NSString *)string{
        //    [self makeHUd];
        AFNetworkTwoPackaging *twoPack = [[AFNetworkTwoPackaging alloc] init];
        [twoPack getUrl:[NSString stringWithFormat:PEOERTyMENDDEATILTWO,string] andFinishBlock:^(id getResult) {
            NSLog(@"%@",getResult);
            [self hudWasHidden:self.hudProgress];
            NSLog(@"%@",getResult);
//            if ([getResult[@"success"] isEqualToString:@"yes"]) {
                for (NSDictionary *dic in getResult[@"datas"]) {
                    DetialWeiXiu *model = [[DetialWeiXiu alloc] initWithDictionary:dic];
                    self.name = model.name;
                    self.RepairTime = model.RepairTime;
                    self.ReservationTime = model.ReservationTime;
                    self.name = model.name;
                    self.address = model.address;
                    self.htmlStr = model.htmlData;
                    self.imageArr = model.images;
                    self.RepairContent = model.RepairContent;
                    NSLog(@"123123%@",self.imageArr);
//                    [self makeOtherLabel];
//                    [self makeWebView];
                    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0,  95 * self.numSingleVesion, self.view.frame.size.width, 500)];
//                    view.backgroundColor = [UIColor cyanColor];
                    [self.SecondView addSubview:view];
                    [self makelatImageAndLabOnView:view];
                    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 10 * self.numSingleVesion, self.view.frame.size.width, 46 * self.numSingleVesion)];
                    [self.SecondView addSubview:view1];
                    [self showTheView:view1];
                }
        }];
    
}

- (void)buttonClick{
//    _fzhPopView = [[FZHPopView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
//    _fzhPopView.fzhPopViewDelegate = self;
//    [_fzhPopView showThePopViewWithArray:self.titleArray];
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 46 * self.numSingleVesion)];
    [self.SecondView addSubview:view1];
    [self showTheView:view1];
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(0, 46 *self.numSingleVesion, self.view.frame.size.width, 500)];
    [self.SecondView addSubview:view2];
    [self makelatImageAndLabOnView:view2];

    
}

-(void) showTheView:(UIView *)view {
    NSArray *arr = @[@"业主信息",[NSString stringWithFormat:@"业主: %@",self.name],[NSString stringWithFormat:@"地址: %@",self.address],[NSString stringWithFormat:@"预约时间: %@",self.ReservationTime]];
    
    for (NSInteger i = 0; i < arr.count; i ++) {
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(10 * self.numSingleVesion, 22 *self.numSingleVesion * i, self.view.frame.size.width - 20 *self.numSingleVesion, 12 * self.numSingleVesion)];
        lab.text = arr[i];
        lab.textColor = [UIColor colorWithRed:103/255.0 green:103/255.0 blue:103/255.0 alpha:1];
        lab.font = [UIFont systemFontOfSize:13 *self.numSingleVesion];
        [view addSubview:lab];
    }

}



#pragma mark - FZHPopViewDelegate
- (void)getTheButtonTitleWithButton:(UIButton *)button{
    
//    int index = (int)button.tag - 1000;
//    NSString * buttonStr = self.titleArray[index];
    [_fzhPopView dismissThePopView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//ShowImageViewController *vc = [[ShowImageViewController alloc] init];
//vc.clickTag = tap.view.tag;
//vc.imageViews = self.imagePickerArray;
//[self.navigationController pushViewController:vc animated:YES];

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
