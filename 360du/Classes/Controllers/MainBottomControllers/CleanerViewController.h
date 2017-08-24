//
//  CleanerViewController.h
//  360du
//
//  Created by 利美 on 16/4/21.
//  Copyright © 2016年 wangjian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CleanerViewController : UIViewController<MBProgressHUDDelegate>
@property (nonatomic ,strong) NSMutableArray *listArray;

@property (nonatomic ,strong) NSMutableArray *rentData;
@property (nonatomic ,strong) NSMutableArray *shengArr;
@property (nonatomic ,strong) NSMutableArray *shengCodeArr;

@property (nonatomic ,strong) NSMutableArray *shiArr;
@property (nonatomic ,strong) NSMutableArray *shiCodeArr;

@property (nonatomic ,strong) NSMutableArray *leiXArr;
@property (nonatomic ,strong) NSMutableArray *leiCodeXArr;

@property (nonatomic ,strong) NSDictionary *getData;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (nonatomic, copy) NSString *addrId;
@property (nonatomic, copy) NSString *leiXId;
@property (nonatomic, copy) NSString *search;
@property (nonatomic ,copy) NSString *PaiXId;

@property (nonatomic, copy) NSString *addr;
@property (nonatomic, copy) NSString *leiX;
@property (nonatomic ,copy) NSString *PaiX;


@property (nonatomic ,copy) NSString *latAndLong;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *addrWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *typeWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *paiWidth;




@property (nonatomic ,copy) NSString *tag;


@property (nonatomic ,assign) id flag;
@property (nonatomic ,assign) id target;



-(void)makeHUd;
-(void)hudWasHidden:(MBProgressHUD *)hud;
-(void) returnchooseAddrbuttonTitle:(NSString *)name andCode:(NSString *)code;
-(void) returnchoosePaibuttonTitle:(NSString *)name andCode:(NSString *)code;
-(void)chooseGetqyCode:(NSString *)qycode andzjcode:(NSString *)zjCode andhxCode:(NSString *)hxCode andlyCode:(NSString *)lyCode andlxCode:(NSString *)lxCode andlcCode:(NSString *)lcCode andcxCode:(NSString *)cxCode andkeyword:(NSString *)keyWord;
-(void) searchIOPWithxqid:(NSString *)xqid andqyCode:(NSString *)qycode andsortType:(NSString *)sortType andTwoType:(NSString *)twoType andlocation:(NSString *)location andkeyWord:(NSString *)keyword;
@end
