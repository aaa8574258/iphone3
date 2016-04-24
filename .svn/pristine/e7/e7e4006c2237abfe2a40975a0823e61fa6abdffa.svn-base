//
//  CommonBusinessListCollectionViewCell.h
//  360du
//
//  Created by linghang on 15/7/3.
//  Copyright (c) 2015年 wangjian. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MerchantDeatilModel;
@interface CommonBusinessListCollectionViewCell : UICollectionViewCell<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,assign)CGFloat allWidth;
@property(nonatomic,assign)CGFloat numSingleVesion;
@property(nonatomic,strong)NSArray *dataArr;
@property(nonatomic,strong)NSArray *sectionArr;
@property(nonatomic,strong)NSDictionary *evaluateDic;
@property(nonatomic,weak)UITableView *tableView;
@property(nonatomic,copy)NSString *memchantId;
@property(nonatomic,assign)id target;
@property(nonatomic,strong)MerchantDeatilModel *detailModel;
-(void)makeUINum:(NSInteger)num;
-(void)returnAddBtn:(NSInteger)num andSection:(NSInteger)section andAddAndReduce:(NSString *)addAndReduce andCount:(NSString *)buyCount;
@end
