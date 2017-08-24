//
//  JfIconListTableViewCell.h
//  360du
//
//  Created by 利美 on 17/3/15.
//  Copyright © 2017年 wangjian. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface JfIconListTableViewCell : UICollectionViewCell
@property (nonatomic ,strong) UILabel *firstLab;
@property (nonatomic ,strong) UILabel *secLab;
@property (nonatomic ,strong) UILabel *thirdLab;
@property (nonatomic ,strong) UILabel *fourthLab;
@property (nonatomic ,strong) UIImageView *imageView1;
@property(nonatomic,assign)CGFloat numSingleVersion;

@end
