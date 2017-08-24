//
//  CommitOrderViewController.h
//  360du
//
//  Created by linghang on 15/7/11.
//  Copyright (c) 2015年 wangjian. All rights reserved.
//

#import "BaseViewController.h"


@protocol sendNewAddress <NSObject>

-(void)sendNewAddress:(NSString *)AddressStr andNumber:(NSString *)number andName:(NSString *)name andSex:(NSString *)sex andPhone:(NSString *)phone;

@end




@interface CommitOrderViewController : BaseViewController




@property (nonatomic ,assign) id<sendNewAddress> delegate;
@property(nonatomic,assign)id target;
-(id)initWithAddressArr:(NSArray *)addressArr;
-(void)returnRow:(NSInteger)row;
//刷新数据
-(void)refreshData;








@end
