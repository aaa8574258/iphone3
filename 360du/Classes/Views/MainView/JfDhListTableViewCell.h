//
//  JfDhListTableViewCell.h
//  360du
//
//  Created by 利美 on 17/3/15.
//  Copyright © 2017年 wangjian. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "JfDhListModel.h"
@interface JfDhListTableViewCell : BaseTableViewCell
@property (nonatomic ,strong) UILabel *dhLab;
@property (nonatomic ,strong) UILabel *zfFlagLab;
@property (nonatomic ,strong) UILabel *nameLab;
@property (nonatomic ,strong) UILabel *dNameLab;
@property (nonatomic ,strong) UILabel *JfLab;
@property (nonatomic ,strong) UILabel *JmLab;
@property (nonatomic ,strong) UILabel *numberLab;
@property (nonatomic ,strong) UIImageView *imageV;
@property (nonatomic ,strong) UIView *line1;
@property (nonatomic ,strong) UIView *line2;

@property (nonatomic ,strong) JfDhListModel *model;
@end
