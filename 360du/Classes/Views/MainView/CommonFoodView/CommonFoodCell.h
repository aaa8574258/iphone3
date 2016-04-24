//
//  CommonFoodCell.h
//  360du
//
//  Created by linghang on 15-4-18.
//  Copyright (c) 2015年 wangjian. All rights reserved.
//

#import "BaseTableViewCell.h"
@class CommomFoodModel;
@interface CommonFoodCell : BaseTableViewCell
@property(nonatomic,strong)UIImageView *leftImg;
@property(nonatomic,strong)UILabel *titleLable;
@property(nonatomic,strong)UILabel *countLable;
@property(nonatomic,strong)UILabel *priceUsualLable;
@property(nonatomic,strong)UILabel *priceOtherLable;
@property(nonatomic,strong)UIImageView *foreStarImg;
@property(nonatomic,strong)UIImageView *backStarImg;
@property(nonatomic,strong)UIButton *ticketBtn;
@property(nonatomic,strong)UIButton *payBtn;
@property(nonatomic,assign)NSInteger row;
@property(nonatomic,strong)UIButton *privilegeBtn;
@property(nonatomic,strong)UILabel *privilegeLable;
@property(nonatomic,strong)UIImageView *privilegeNew;
@property(nonatomic,strong)UIImageView *privilegeReduce;
@property(nonatomic,strong)UIButton *privilegePage;
@property(nonatomic,strong)NSArray *privilegeArr;
@property(nonatomic,assign)BOOL privilegeBtnState;
@property(nonatomic,strong)UIView *priviegeStateView;//优惠下边的东西
-(void)makeUI;
-(void)refreshUI:(CommomFoodModel *)model;

@end
