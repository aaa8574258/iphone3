//
//  GroupPurchaseItemView.h
//  360du
//
//  Created by linghang on 15/12/25.
//  Copyright © 2015年 wangjian. All rights reserved.
//

#import "BaseView.h"
@class GroupPurchasrItemListModel;
@interface GroupPurchaseItemView : BaseView
@property(nonatomic,copy)NSString *cpid;
- (id)initWithFrame:(CGRect)frame andModle:(GroupPurchasrItemListModel *)model andStoreCount:(NSString *)countStr andPictureUrl:(NSString *)pictureUrl;
@end
