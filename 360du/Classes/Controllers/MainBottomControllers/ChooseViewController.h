//
//  ChooseViewController.h
//  360du
//
//  Created by 利美 on 16/4/22.
//  Copyright © 2016年 wangjian. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol sendSearchBody <NSObject>

- (void) sendSearchBodyWithAddr: (NSString *)addrId andleiXId:(NSString *)leiX andPaiXId:(NSString *)paiX andSearch:(NSString *)search;
-(void) searchIOPWithxqid:(NSString *)xqid andqyCode:(NSString *)qycode andsortType:(NSString *)sortType andTwoType:(NSString *)twoType andlocation:(NSString *)location;
@end

@interface ChooseViewController : UIViewController

@property (nonatomic, copy) NSString *addr;
@property (nonatomic, copy) NSString *leiX;
@property (nonatomic, copy) NSString *addrId;
@property (nonatomic, copy) NSString *leiXId;
@property (nonatomic, copy) NSString *search;
@property (nonatomic ,copy) NSString *PaiXId;
@property (nonatomic, copy) NSString *PaiX;

@property (nonatomic ,assign) id<sendSearchBody> bodyDelegate;

@property (nonatomic ,strong) NSDictionary *bodyDic;
@property (nonatomic ,assign) id target;
@end
