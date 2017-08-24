//
//  AddrFirstTableViewController.h
//  360du
//
//  Created by 利美 on 16/4/26.
//  Copyright © 2016年 wangjian. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol sendAddr <NSObject>

-(void) sendAddr:(NSString *)string andCode:(NSString *)code;

@end


@interface AddrFirstTableViewController : UITableViewController
@property(nonatomic,strong) NSMutableDictionary *dataDic;
@property(nonatomic,strong) NSMutableArray *dataArr;
@property(nonatomic,strong) NSString *name;


@property(nonatomic,strong)NSString *codei;
@property(nonatomic,strong)NSString *treeLevel;
@property(nonatomic,strong)NSMutableArray *secondArr;

@property (nonatomic ,assign) id<sendAddr> sendAddrDelegate;

@property (nonatomic ,copy) NSString *address;
@end
