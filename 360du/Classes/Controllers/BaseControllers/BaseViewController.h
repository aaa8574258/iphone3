//
//  BaseViewController.h
//  360du
//
//  Created by linghang on 15-4-11.
//  Copyright (c) 2015年 wangjian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController<MBProgressHUDDelegate>
@property(nonatomic,assign)CGFloat numSingleVesion;
@property(nonatomic,strong)MBProgressHUD *hudProgress;
-(void)setBack;//返回按钮
-(void)setLeftItem:(UIView *)view;//左边视图
-(void)setRightItem:(UIView *)view;//右边视图
-(void)setNavTitleItemWithNameAndImage:(NSString *)name imageName:(NSString *)imageName;//中间图和名字
-(void)setNavTitleItemWithName:(NSString *)name;//中间名字
-(void)setBackgroud:(NSString *)name;//背景图
-(void)setNavBarImage:(NSString *)name;//导航条背景
-(void)setNavBack:(NSString *)name;
//返回按钮
-(void)setBackImageStateName:(NSString *)state AndHighlightedName:(NSString *)highligh;
//没有导航条的返回
-(void)setBackNoNavgationImageStateName:(NSString *)state AndHightlightedName:(NSString *)highligh;
//两个左边视图
-(void)setTwoViewWithLeftOne:(NSString *)leftOne AndLefTwo:(NSString *)leftTwo;
//make加载图
-(void)makeHUd;
-(void)hudWasHidden:(MBProgressHUD *)hud;
@end
