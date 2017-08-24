//
//  GroupCollectionViewCell.h
//  360du
//
//  Created by 利美 on 16/9/13.
//  Copyright © 2016年 wangjian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GroupCollectionViewCell : UICollectionViewCell
@property(nonatomic,strong)UILabel *label;
@property(nonatomic,strong) UILabel *money1Lab;
@property(nonatomic,strong) UILabel *money2Lab;
@property(nonatomic,strong)UIImageView *imageView, *imageView1;
@property ( nonatomic , strong) UIView *lineMoney;
@property(nonatomic,assign)CGFloat numSingleVesion;

@end
