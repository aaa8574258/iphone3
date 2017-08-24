//
//  GroupRobGoodsDetialViewController.h
//  360du
//
//  Created by 利美 on 16/7/7.
//  Copyright © 2016年 wangjian. All rights reserved.
//

#import "BaseViewController.h"
#import "GroupPurchaseModel.h"
#import "GroupPurchasrItemListModel.h"
#import "GroupPurchaseItemView.h"
#import "StoreageMessage.h"
#import "GroupOrderDeatilModel.h"
#import "GroupPurchaseOrderDetailViewController.h"
@interface GroupRobGoodsDetialViewController : BaseViewController
@property(nonatomic,strong)GroupPurchaseModel *model;
@property (weak, nonatomic) IBOutlet UIView *LBSuperView;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *JGLab;
@property (weak, nonatomic) IBOutlet UILabel *JG1Lab;
@property (weak, nonatomic) IBOutlet UIView *timeSuperView;
@property (weak, nonatomic) IBOutlet UIView *goToWebView;
@property (weak, nonatomic) IBOutlet UIWebView *WebSuperView;
@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *moneyLineWidth;
@property (weak, nonatomic) IBOutlet UIView *superView;


//1,为确定，0为取消
- (void)cancelOrNot:(NSInteger)cancelOrConfirm andArr:(NSArray *)infoArr;
- (void)cancelOrNot:(NSInteger)cancelOrConfirm andArr:(NSArray *)infoArr andCount:(NSString *)count andPid:(NSString *)pid andShopType:(NSString *)shopType andRule:(NSString *)rule;
@end
