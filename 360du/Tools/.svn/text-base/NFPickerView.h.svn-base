//
//  NFPickerView.h
//  NFPickerView
//
//  Created by A_Dirt on 16/5/9.
//  Copyright © 2016年 A_Dirt. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol NFPickerViewDelegete <NSObject>

-(void) pickerDidSelectWithSelfView:(UIView *)view  ProvinceName:(NSString *)provinceName cityName:(NSString *)cityName countrys:(NSString *)countrys;

@end
@interface NFPickerView : UIView<UIPickerViewDelegate,UIPickerViewDataSource>

@property(nonatomic,retain)UIButton *cancelbtn;
@property(nonatomic,retain)UIButton *surebtn;
@property (nonatomic,retain) id<NFPickerViewDelegete> delegate;
@property (nonatomic ,strong)    NSArray *province;
@property (nonatomic ,strong)NSArray *city;
@property (nonatomic ,strong)NSArray *country;
-(void)show;
//消失
-(void)dismmis;
@end
