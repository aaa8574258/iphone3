//
//  AgoTableViewCell.h
//  360du
//
//  Created by 利美 on 16/6/12.
//  Copyright © 2016年 wangjian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetialInfoPropertyModel.h"
@interface AgoTableViewCell : UITableViewCell
@property (nonatomic ,strong) UILabel *firstlabel;
@property (nonatomic ,strong) UILabel *secondLabel;
@property (nonatomic ,strong) UILabel *timeLabel;
@property (nonatomic ,strong) UILabel *areaLabel;
@property (nonatomic ,strong) UILabel *userNameLabel;
@property (nonatomic ,strong) UILabel *cleaningLabel;
@property (nonatomic ,strong) UILabel *safeFeeLabel;
@property (nonatomic ,strong) UILabel *rubbishFeeLabel;
@property (nonatomic ,strong) UILabel *wyFeeLabel;
@property (nonatomic ,strong) UILabel *realFeeLabel;

@property(nonatomic,assign)CGFloat numSingleVersion;
//@property(nonatomic,assign)CGFloat allWidth;


-(void)haveModel:(DetialInfoPropertyModel *)model;

@end
