//
//  FixMasterViewController.m
//  360du
//
//  Created by 利美 on 16/12/7.
//  Copyright © 2016年 wangjian. All rights reserved.
//

#import "FixMasterViewController.h"
#import "StoreageMessage.h"
@interface FixMasterViewController ()

@end

@implementation FixMasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(WIDTH_CONTROLLER - 32 , (44 - 2) / 2, 30, 30);
    [leftBtn setImage:[UIImage imageNamed:@"fanhuijian2222.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(setBack) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setImageEdgeInsets:UIEdgeInsetsMake(6, 5, 6, 5)];
    UIBarButtonItem *leftSecondItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftSecondItem;
    
    
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 150, 20)];
//    
//    view.backgroundColor = [UIColor cyanColor];
//    
//    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 200, 20)];
    lab.text = @"是否接收维修信息";
    lab.font = [UIFont systemFontOfSize:14];
//    lab.textColor = [UIColor lightGrayColor];
    [self.view addSubview:lab];

    [self loadSwitchOK];
    //
//    UIBarButtonItem *right1 = [[UIBarButtonItem alloc] initWithCustomView:view];
//    self.navigationItem.rightBarButtonItem = right1;

}

-(void)loadSwitchOK{
    AFNetworkTwoPackaging *twoPacking = [[AFNetworkTwoPackaging alloc] init];
    [twoPacking getUrl:[NSString stringWithFormat:ISFIXMAN,[StoreageMessage getMessage][2]] andFinishBlock:^(id getResult) {
        NSLog(@"%@",getResult);
        
        
        
        
        
        UISwitch *switchButton = [[UISwitch alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 60, 0, 50, 20)];
        //    switchButton.backgroundColor = [UIColor whiteColor];
        if ([getResult[@"status"] isEqualToString:@"1"]) {
            [switchButton setOn:YES];
        }else{
            [switchButton setOn:NO];
        }
        [switchButton addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
        
        [self.view addSubview:switchButton];

    }];

}


-(void)switchAction:(id)sender
{
    //    [self.tabelView reloadData];
    
    UISwitch *switchButton = (UISwitch*)sender;
    BOOL isButtonOn = [switchButton isOn];
    NSString *str1;
    if (isButtonOn == YES) {
        str1 = @"1";
    }else{
        str1 = @"2";
    }
    AFNetworkTwoPackaging *twoPacking = [[AFNetworkTwoPackaging alloc] init];
    [twoPacking getUrl:[NSString stringWithFormat:ISOPENFIXMASTER,[StoreageMessage getMessage][2],str1] andFinishBlock:^(id getResult) {
        NSLog(@"%@",getResult);
        
    }];
}



-(void)setBack{
    
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
