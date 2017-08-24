//
//  RentPublishViewController.h
//  360du
//
//  Created by 利美 on 16/6/14.
//  Copyright © 2016年 wangjian. All rights reserved.
//

#import "BaseViewController.h"
#import "VOTagList.h"
#import "UniversalViewController.h"
#import "ALAsset+AGIPC.h"
@interface RentPublishViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UIView *photoView;
@property (weak, nonatomic) IBOutlet UILabel *quyuLabel;
@property (weak, nonatomic) IBOutlet UILabel *xqLabel;
@property (weak, nonatomic) IBOutlet UITextField *zjTextF;
@property (weak, nonatomic) IBOutlet UILabel *yjLab;
@property (weak, nonatomic) IBOutlet UILabel *fwStyleLab;
@property (weak, nonatomic) IBOutlet UILabel *cxLab;
@property (weak, nonatomic) IBOutlet UILabel *hxLab;
@property (weak, nonatomic) IBOutlet UILabel *lcLab;
@property (weak, nonatomic) IBOutlet UITextField *mjTextF;
@property (weak, nonatomic) IBOutlet UIView *ssView;
@property (weak, nonatomic) IBOutlet UITextField *titleTextF;
@property (weak, nonatomic) IBOutlet UITextView *msTextView;

@property (weak, nonatomic) IBOutlet UITextField *lxrTextF;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextF;
@property (weak, nonatomic) IBOutlet UISegmentedControl *lySegment;
@property (weak, nonatomic) IBOutlet UIView *msSuperView;
@property (weak, nonatomic) IBOutlet UIView *ptssSuperView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ptssSuperHeight;
@property (weak, nonatomic) IBOutlet UITextField *dztfTextF;
@property (weak, nonatomic) IBOutlet UITextField *dzrzTexF;
@property (weak, nonatomic) IBOutlet UITextField *dzjdTextF;


@property (weak, nonatomic) IBOutlet UITextField *dzyjTextF;
@property (weak, nonatomic) IBOutlet UILabel *dzfplab;
@property (weak, nonatomic) IBOutlet UITextField *dzzdzqTxetF;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *fwStyleToZjHeight;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleToXqHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *hzTozzHeight;




























//整租合租日租分类
@property (nonatomic ,copy) NSString *tag;


-(void) returnAddrAndnumber:(NSString *)code andName:(NSString *)name andLocation:(NSString *)location;
-(void) returnyjfsWithName:(NSString *)name andcode:(NSString *)code;
-(void) returnfwlxWithName:(NSString *)name andcode:(NSString *)code;
-(void) returnfaceWithName:(NSString *)name andcode:(NSString *)code;
-(void) returnhzWithName:(NSString *)name andcode:(NSString *)code;
-(void) returndzfpWithName:(NSString *)name andcode:(NSString *)code;
-(void) returndzzfWithName:(NSString *)name andcode:(NSString *)code;
@end
