//
//  RentSearchViewController.m
//  360du
//
//  Created by 利美 on 16/6/22.
//  Copyright © 2016年 wangjian. All rights reserved.
//

#import "RentSearchViewController.h"
#import "UniversalViewController.h"
#import "AddrFirstTableViewController.h"
#import "RentViewController.h"
#import "SendMessage.h"
#import "UIView+Toast.h"
#import "CleanerViewController.h"
@interface RentSearchViewController ()
@property (nonatomic ,copy)NSString *qyCode;
@property (nonatomic ,copy)NSString *zjCode;
@property (nonatomic ,copy)NSString *hxCode;
@property (nonatomic ,copy)NSString *lyCode;
@property (nonatomic ,copy)NSString *lxCode;
@property (nonatomic ,copy)NSString *lcCode;
@property (nonatomic ,copy)NSString *cxCode;


@end

@implementation RentSearchViewController


-(void)viewWillAppear:(BOOL)animated{
    if ([SendMessage shareInstance].singleValue) {
        //    if (!self.chooseName) {
//        NSLog(@"%@",[SendMessage shareInstance].singleValue);
        self.qyCode = [SendMessage shareInstance].singleCode;
        self.qyLab.text = [NSString stringWithFormat:@"%@",[SendMessage shareInstance].singleValue] ;
    }

}



- (void)viewDidLoad {
    [super viewDidLoad];
    [SendMessage shareInstance].singleCode = nil;
    [SendMessage shareInstance].singleValue = nil;
    NSArray *viewsArr = @[_qyLab,_zjlab,_hxLab,_lyLab,_lxLab,_lcLab,_cxLab];
    for (UILabel *lab in viewsArr) {
        UITapGestureRecognizer *tap=[[ UITapGestureRecognizer alloc ] initWithTarget : self action : @selector (randomColor:)];
        [lab addGestureRecognizer :tap];
        lab. userInteractionEnabled = YES ;
    }
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"landi.png"] forBarMetrics:UIBarMetricsDefault];
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(WIDTH_CONTROLLER - 32 , (44 - 2) / 2, 30, 40);
    [leftBtn setImage:[UIImage imageNamed:@"返回.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(setBack) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setImageEdgeInsets:UIEdgeInsetsMake(6, 5, 6, 5)];
    UIBarButtonItem *leftSecondItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftSecondItem;
    // Do any additional setup after loading the view.
}


-(void)randomColor:( UITapGestureRecognizer *)gestureRecognizer{
    UILabel *lab=( UILabel *)gestureRecognizer.view;
    if (lab.tag == 151884) {
        AddrFirstTableViewController *controller = [[AddrFirstTableViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    if (lab.tag == 151885) {
        UniversalViewController *universal = [[UniversalViewController alloc] initWithUrl:@"rentMoneyChoose"];
        universal.target = self;
        [self.navigationController pushViewController:universal animated:YES];
    }
    if (lab.tag == 151886) {
        UniversalViewController *universal = [[UniversalViewController alloc] initWithUrl:@"rentRoomCount"];
        universal.target = self;
        [self.navigationController pushViewController:universal animated:YES];
    }
    if (lab.tag == 151887) {
        UniversalViewController *universal = [[UniversalViewController alloc] initWithUrl:@"from"];
        universal.target = self;
        [self.navigationController pushViewController:universal animated:YES];
    }
    if (lab.tag == 151888) {
        UniversalViewController *controller = [[UniversalViewController alloc] initWithUrl:[NSString stringWithFormat:RENTPUBLISHSS,@"ZHHouseType"]];
        controller.target = self;
        [self.navigationController pushViewController:controller animated:YES];
    }
    if (lab.tag == 151889) {
        UniversalViewController *controller = [[UniversalViewController alloc] initWithUrl:@"floorCount"];
        controller.target = self;
        [self.navigationController pushViewController:controller animated:YES];
            }
    if (lab.tag == 151890) {
        UniversalViewController *controller = [[UniversalViewController alloc] initWithUrl:[NSString stringWithFormat:RENTPUBLISHSS,@"face"]];
        controller.target = self;
        [self.navigationController pushViewController:controller animated:YES];
            }

    
}

-(void)returnRentyjName:(NSString *)name andCode:(NSString *)code{
    if (!code) {
        code = @"0";
    }
    self.zjlab.text = name;
    self.zjCode = code;
}
-(void)returnRenthxName:(NSString *)name andCode:(NSString *)code{
    if (!code) {
        code = @"0";
    }
    self.hxCode = code;
    self.hxLab.text = name;
}
-(void)returnRentlyName:(NSString *)name andCode:(NSString *)code{
    if (!code) {
        code = @"0";
    }
    self.lyCode = code;
    self.lyLab.text = name;
}
-(void)returnRentlxName:(NSString *)name andCode:(NSString *)code{
    if (!code) {
        code = @"0";
    }
    self.lxCode = code;
    self.lxLab.text = name;
}
-(void)returnRentlcName:(NSString *)name andCode:(NSString *)code{
    if (!code) {
        code = @"0";
    }
    self.lcCode = code;
    self.lcLab.text = name;
}
-(void)returnRentcxName:(NSString *)name andCode:(NSString *)code{
    if (!code) {
        code = @"0";
    }
    self.cxCode = code;
    self.cxLab.text = name;
}








- (IBAction)okBtn:(id)sender {
//    if ([self.taget isKindOfClass:[CleanerViewController class]]) {
//    NSLog(@"1  %@  %@",self.taget,self.keywordTextF.text);
    if (self.keywordTextF.text.length == 0) {
        self.keywordTextF.text = nil;
        }
            if (_qyCode == nil) {
                _qyCode = @"0";
            }if (_zjCode == nil) {
                _zjCode = @"0";
            }if (_hxCode == nil) {
                _hxCode = @"0";
            }if (_lyCode == nil) {
                _lyCode = @"0";
            }if (_lxCode == nil) {
                _lxCode = @"0";
            }if (_lcCode == nil) {
                _lcCode = @"0";
            }if (_cxCode == nil) {
                _cxCode = @"0";
            }
//            NSLog(@"%@",_lyCode);
            [self.taget  chooseGetqyCode:self.qyCode andzjcode:self.zjCode andhxCode:self.hxCode andlyCode:self.lyCode andlxCode:self.lxCode andlcCode:self.lcCode andcxCode:self.cxCode andkeyword:self.keywordTextF.text];
            [self.navigationController popViewControllerAnimated:YES];
//        }
//    }
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
