//
//  JSCartModel.h
//  JSShopCartModule
//
//  Created by 乔同新 on 16/6/9.
//  Copyright © 2016年 乔同新. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSCartModel : NSObject

@property (nonatomic, strong) NSString  *p_id;

@property (nonatomic, assign) float     p_price;

@property (nonatomic, strong) NSString  *p_name;

@property (nonatomic, strong) NSString  *p_imageUrl;

@property (nonatomic, assign) NSInteger p_stock;

@property (nonatomic, assign) NSInteger p_quantity;







@property (nonatomic ,copy) NSString *shopCarId;//购物车ID
@property (nonatomic ,copy) NSString *shopType;//商家类型 1 便利店 2 团购
@property (nonatomic ,copy) NSString *shopName;//商家名称
@property (nonatomic ,copy) NSString *pid,*did,*cpid;//产品 ID
@property (nonatomic ,copy) NSString *proName;// 产品名字
@property (nonatomic ,copy) NSString *picUrl;//产品图片
@property (nonatomic ,copy) NSString *proRule;//产品规格
@property (nonatomic ,copy) NSString *beforePrice;//产品原价
@property (nonatomic ,assign) float unitPrice;//产品单价价格

@property (nonatomic ,assign) NSInteger count;//产品数量

@property (nonatomic ,copy) NSString *SendEndTime;
@property (nonatomic ,copy) NSString *faPiao;
@property (nonatomic ,copy) NSString *isArrivedPay;
@property (nonatomic ,copy) NSString *remark;
//商品是否被选中
@property (nonatomic, assign) BOOL      isSelect;


@property (nonatomic, copy) NSString *isXuni;

@end
