//
//  ShopCarViewController.h
//  360du
//
//  Created by 利美 on 16/9/20.
//  Copyright © 2016年 wangjian. All rights reserved.
//

#import "BaseViewController.h"

@protocol viewDelegate <NSObject>

-(void)changeString:(NSString *)string;

@end

@interface ShopCarViewController : BaseViewController
@property (nonatomic ,strong) UITableView *tabelView;
@property (nonatomic ,strong) NSMutableArray *dataArr;
@property (nonatomic ,assign) id target;

@property (nonatomic ,strong) NSArray *yhqArr;
- (instancetype)initWithData:(NSMutableArray *)arr;

-(void)sendNewAddressAtIndex:(NSInteger )index;

@property (nonatomic ,assign) id <viewDelegate> Strdelegate;

@end
