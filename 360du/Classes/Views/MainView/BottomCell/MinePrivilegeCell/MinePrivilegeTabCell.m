//
//  MinePrivilegeTabCell.m
//  360du
//
//  Created by linghang on 15/12/11.
//  Copyright © 2015年 wangjian. All rights reserved.
//

#import "MinePrivilegeTabCell.h"
#import "MinePrivilageModel.h"
#import "NSString+NSString.h"
@interface MinePrivilegeTabCell(){
    UILabel *_yhName;//优惠券名称
    UILabel *_yhMone;//优惠钱数
    UILabel *_shopName;//点
    UIImageView *_expiredImg;//过期
    
}

@end
@implementation MinePrivilegeTabCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self makeUI];
    }
    return self;
}
- (void)makeUI{
    CGFloat height = 10 * self.numSingleVersion;
    //背景图
    UIImageView *bgImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTENTVIEW, 130 * self.numSingleVersion)];
    bgImage.image = [UIImage imageNamed:@"coupons_info_bg.jpg"];
    [self.contentView addSubview:bgImage];
    //优惠券名称
    _yhName = [[UILabel alloc] initWithFrame:CGRectMake(10 * self.numSingleVersion , 5 * self.numSingleVersion + height, 130 * self.numSingleVersion, 15 * self.numSingleVersion)];
    _yhName.textColor = SMSColor(21, 158, 230);
    _yhName.font = [UIFont systemFontOfSize:18];
    [bgImage addSubview:_yhName];
    //优惠券钱数
    _yhMone = [[UILabel alloc] initWithFrame:CGRectMake(10 * self.numSingleVersion, 45 * self.numSingleVersion + height, 200 * self.numSingleVersion, 15 * self.numSingleVersion)];
    _yhMone.font = [UIFont systemFontOfSize:30];
    _yhMone.textColor = SMSColor(21, 158, 230);
    [bgImage addSubview:_yhMone];
    NSString *timeStr = @"2015-11-21--2015-11-21";
    CGSize size = [timeStr returnSizeFont:13 andWidth:WIDTH_CONTENTVIEW];

    for (NSInteger i = 0; i < 3; i++) {
        UILabel *tempLab = [[UILabel alloc] initWithFrame:CGRectZero];
        if (i == 0 || i == 2) {
            tempLab.font  = [UIFont systemFontOfSize:13];
            
            tempLab.textColor = SMSColor(211, 211, 211);
            tempLab.frame = CGRectMake(WIDTH_CONTENTVIEW - 5 * self.numSingleVersion - size.width - 10 * self.numSingleVersion, 5 * self.numSingleVersion + 40 * i * self.numSingleVersion + height, size.width + 10 * self.numSingleVersion, 40 * self.numSingleVersion);
            if (i == 0) {
                tempLab.numberOfLines = 2;
            }
        }else{
            tempLab.font = [UIFont systemFontOfSize:15];
            tempLab.textColor = SMSColor(51, 51, 51);
            tempLab.frame = CGRectMake(WIDTH_CONTENTVIEW - 5 * self.numSingleVersion - size.width / 2 - 5 * self.numSingleVersion - 10 * self.numSingleVersion, 5 * self.numSingleVersion + 40 * i * self.numSingleVersion + height, size.width, 40 * self.numSingleVersion);
            
        }
        tempLab.tag = 2100 + i;
        [bgImage addSubview:tempLab];
    }
    UIImageView *arrowImg = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH_CONTENTVIEW - 30 * self.numSingleVersion,5 * self.numSingleVersion + 40  * self.numSingleVersion + height + 4 * self.numSingleVersion, 20 * self.numSingleVersion, 25 * self.numSingleVersion)];
    arrowImg.image = [UIImage imageNamed:@"右箭.png"];
    [bgImage addSubview:arrowImg];
   // arrowImg.center = CGPointMake(WIDTH_CONTENTVIEW - 120 * self.numSingleVersion, 55 * self.numSingleVersion);
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 122 * self.numSingleVersion, WIDTH_CONTENTVIEW, 1 * self.numSingleVersion)];
    line.backgroundColor = SMSColor(211, 211, 211);
    [self.contentView addSubview:line];
    
    //过期、使用
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake( 10 * self.numSingleVersion, 10 * self.numSingleVersion, 40 * self.numSingleVersion, 40 * self.numSingleVersion)];
    imgView.image = [UIImage imageNamed:@""];
   // imgView.layer.cornerRadius = 30 * self.numSingleVersion;
    [bgImage addSubview:imgView];
    _expiredImg = imgView;
    imgView.transform = CGAffineTransformMakeRotation(M_PI / 4);
}
- (void)setModel:(MinePrivilageModel *)model{
    NSArray *tempArr = @[model.businessName,[NSString stringWithFormat:@"满%@可用",model.startMoney],[NSString stringWithFormat:@"%@--%@",model.startTime,model.endTime]];
    //这是三个，店名，满多少可用，日期
    for (NSInteger i = 0; i < tempArr.count; i++) {
        UILabel *tempLab = (UILabel *)[self.contentView viewWithTag:2100 + i];
        tempLab.text = tempArr[i];
    }
    //优惠券名称
    _yhName.text = model.ysTypeName;
    //优惠钱数
    _yhMone.text = [NSString stringWithFormat:@"￥%@",model.ysMoney];
//    if (model.expiredDay) {
//        <#statements#>
//    }
}
- (void)setUserStatus:(NSString *)userStatus{
    //useStatus： 用户优惠券状态：1、未使用;2、已使用;3、已过期

    if([userStatus isEqual:@"1"]){
        
    }else if ([userStatus isEqual:@"2"]){
        _expiredImg.image = [UIImage imageNamed:@"coupons_have_used.png"];
    }else if([userStatus isEqual:@"3"]){
        _expiredImg.image = [UIImage imageNamed:@"coupons_haved_out.png"];
 
    }
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
