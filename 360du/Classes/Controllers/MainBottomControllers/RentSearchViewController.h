//
//  RentSearchViewController.h
//  360du
//
//  Created by 利美 on 16/6/22.
//  Copyright © 2016年 wangjian. All rights reserved.
//

#import "BaseViewController.h"

@interface RentSearchViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UILabel *qyLab;
@property (weak, nonatomic) IBOutlet UILabel *zjlab;
@property (weak, nonatomic) IBOutlet UILabel *hxLab;
@property (weak, nonatomic) IBOutlet UILabel *lyLab;
@property (weak, nonatomic) IBOutlet UILabel *lxLab;
@property (weak, nonatomic) IBOutlet UILabel *lcLab;
@property (weak, nonatomic) IBOutlet UILabel *cxLab;
@property (weak, nonatomic) IBOutlet UITextField *keywordTextF;

@property (nonatomic ,assign) id taget;
-(void)returnRentyjName:(NSString *)name andCode:(NSString *)code;
-(void)returnRenthxName:(NSString *)name andCode:(NSString *)code;
-(void)returnRentlyName:(NSString *)name andCode:(NSString *)code;
-(void)returnRentlxName:(NSString *)name andCode:(NSString *)code;
-(void)returnRentlcName:(NSString *)name andCode:(NSString *)code;
-(void)returnRentcxName:(NSString *)name andCode:(NSString *)code;


@end
