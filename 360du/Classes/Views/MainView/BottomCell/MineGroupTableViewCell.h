//
//  MineGroupTableViewCell.h
//  360du
//
//  Created by linghang on 16/4/12.
//  Copyright © 2016年 wangjian. All rights reserved.
//

#import "BaseTableViewCell.h"
@class MIneGroupModel;
@interface MineGroupTableViewCell : BaseTableViewCell
@property(nonatomic,copy)MIneGroupModel *groupModel;

@property(nonatomic,strong)UILabel *payLab;//待付款
@property(nonatomic,strong)UILabel *buyTime;//下单时间
@property(nonatomic,strong)UIImageView *leftImg;//左边图片
@property(nonatomic,strong)UILabel *nameLab;//名称
@property(nonatomic,strong)UILabel *deatilLab;//介绍
@property(nonatomic,strong)UILabel *prePriceLab;//原先价格
@property(nonatomic,strong)UILabel *nowPiceLab;//现在价格
@property(nonatomic,strong)UILabel *countLab;//数量
@property(nonatomic,strong)UILabel *totoalPriceLab;//总价
@property(nonatomic,strong)UIButton *payBtn;//付款按钮
@property(nonatomic,strong)UIButton *logisticsBtn;
@property (nonatomic ,strong) UIButton *shouHuoBtn;
@property (nonatomic, copy) NSString *tag1;
@end
