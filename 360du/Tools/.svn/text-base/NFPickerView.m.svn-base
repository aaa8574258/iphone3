//
//  NFPickerView.m
//  NFPickerView
//
//  Created by A_Dirt on 16/5/9.
//  Copyright © 2016年 A_Dirt. All rights reserved.
//

#import "NFPickerView.h"

@implementation NFPickerView
{
    UIView *view;
    UIPickerView *picker;

    
    NSInteger _pickerRow;
    NSInteger _pickerComponent;
}
@synthesize cancelbtn,surebtn;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.userInteractionEnabled = YES;
        self.layer.borderColor = [UIColor clearColor].CGColor;
        self.layer.borderWidth =  1;
        [self.layer setMasksToBounds:YES];
        
        cancelbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [cancelbtn addTarget:self action:@selector(selectbtn:) forControlEvents:UIControlEventTouchUpInside];
        [cancelbtn setTitle:@"取消" forState:0];
        cancelbtn.titleLabel.font = [UIFont systemFontOfSize:14];
        cancelbtn.tag = 1;
        cancelbtn.frame = CGRectMake(10, 5, 40, 35);
        [cancelbtn setTitleColor:[UIColor lightGrayColor] forState:0];
        [cancelbtn.layer setMasksToBounds:YES];
        [self addSubview:cancelbtn];
        
        surebtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [surebtn addTarget:self action:@selector(selectbtn:) forControlEvents:UIControlEventTouchUpInside];
        [surebtn setTitle:@"完成" forState:0];
        surebtn.tag = 2;
        cancelbtn.titleLabel.font = [UIFont systemFontOfSize:14];
        surebtn.frame = CGRectMake(CGRectGetWidth(frame)-50, 5, 40, 35);
        [self addSubview:surebtn];
        
        picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 30, CGRectGetWidth(frame), CGRectGetHeight(frame)-50)];
        picker.delegate  = self;
        picker.dataSource = self;
//        picker.backgroundColor = [UIColor yellowColor];
        picker.showsSelectionIndicator = YES;
        [self addSubview:picker];
        


    }
    return self;
}

- (void)selectbtn:(UIButton *)sender
{
    if (sender.tag == 2) {
        if(0 == _pickerComponent || 1 == _pickerComponent || 2 == _pickerComponent){
            if (0 == _pickerComponent) {
                [picker reloadComponent:0];
//                [picker reloadComponent:2];
            }
            else if(1 == _pickerComponent){
                [picker reloadComponent:1];
            }
            
            NSInteger rowOne = [picker selectedRowInComponent:0];
            NSInteger rowTow = [picker selectedRowInComponent:1];
            if (_country != nil) {
                
            NSInteger rowThree = [picker selectedRowInComponent:2];
            if (self.delegate) {
                
                [self.delegate pickerDidSelectWithSelfView:self ProvinceName:_province[rowOne] cityName:_city[rowTow] countrys:_country[rowThree]];
                }
            }else{
                if (self.delegate) {
                    [self.delegate pickerDidSelectWithSelfView:self ProvinceName:_province[rowOne] cityName:_city[rowTow] countrys:nil];
                }

            
            
            }
        }
    }
    [self dismmis];
}

#pragma mark - 该方法的返回值决定该控件包含多少列
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView*)pickerView
{
    if (_country == nil) {
        return 2;
    }
    return 3;
}
#pragma mark - 该方法的返回值决定该控件指定列包含多少个列表项
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (0 == component)
    {
        return _province.count;
    }
    else if (1 == component) {
//        NSInteger rowProvince = [pickerView selectedRowInComponent:1];
//        NSString *provinceName = _province[rowProvince];
//        NSString *citys = _city[provinceName];
        return _city.count;
    }else{
//        NSInteger rowProvince = [pickerView selectedRowInComponent:2];
//        NSString *provinceName = _province[rowProvince];
//        NSArray *citys = _city[provinceName];
//        NSInteger rowCity = [pickerView selectedRowInComponent:1];
//        NSString *cityName = citys[rowCity];
//        NSArray *country = _country[cityName];
        return _country.count;
    }
}
#pragma mark - 该方法返回的NSString将作为UIPickerView中指定列和列表项的标题文本
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (0 == component) {
        return _province[row];
    }
    else if(1 == component){
//        NSInteger rowProvince = [pickerView selectedRowInComponent:0];
//        NSString *provinceName = _province[rowProvince];
//        NSArray *citys = _city[provinceName];
        return _city[row];
    }else{
//        NSInteger rowProvince = [pickerView selectedRowInComponent:0];
//        NSString *provinceName = _province[rowProvince];
//        NSArray *citys = _city[provinceName];
//        NSInteger rowCity = [pickerView selectedRowInComponent:1];
//        NSString *cityName = citys[rowCity];
//        NSArray *country = _country[cityName];
        return _country[row];
    }
}

#pragma mark - 当用户选中UIPickerViewDataSource中指定列和列表项时激发该方法
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if(0 == component || 1 == component){
        
        if (0 == component) {
            [picker reloadComponent:0];
//            [picker reloadComponent:2];
        }
        else if(1 == component){
            [picker reloadComponent:1];
        }
        //当第一个滚轮发生变化时,刷新第二个滚轮的数据
//        [picker reloadComponent:2];
        //让刷新后的第二个滚轮重新回到第一行
//        [picker selectRow:0 inComponent:2 animated:YES];
    }

    _pickerRow = row;
    _pickerComponent = component;
}

//出现
-(void)show
{
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    view = [[UIView alloc] initWithFrame:keyWindow.bounds];
    view.alpha = 0.3;
    view.backgroundColor = [UIColor blackColor];
    [keyWindow addSubview:view];
    
    self.alpha = 1;
    [keyWindow addSubview:self];
    [keyWindow bringSubviewToFront:self];
    
    CAKeyframeAnimation *bounceAnimation = [CAKeyframeAnimation animation];
    bounceAnimation.duration = 0.3;
    bounceAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    bounceAnimation.values = [NSArray arrayWithObjects:
                              [NSNumber numberWithFloat:0.01],
                              [NSNumber numberWithFloat:1.1],
                              [NSNumber numberWithFloat:0.9],
                              [NSNumber numberWithFloat:1.0],
                              nil];
    
    [self.layer addAnimation:bounceAnimation forKey:@"transform.scale"];
    
    CABasicAnimation *fadeInAnimation = [CABasicAnimation animation];
    fadeInAnimation.duration = 0.3;
    fadeInAnimation.fromValue = [NSNumber numberWithFloat:0];
    fadeInAnimation.toValue = [NSNumber numberWithFloat:1];
    [self.superview.layer addAnimation:fadeInAnimation forKey:@"opacity"];
}

//消失
-(void)dismmis
{
    [UIView animateWithDuration:0.25
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^
     {
         self.transform = CGAffineTransformConcat(self.transform, CGAffineTransformMakeScale(0.01, 0.01));
         view.alpha = 0;
     }
                     completion:^(BOOL finished)
     {
         [view removeFromSuperview];
         [self removeFromSuperview];
         
     }];
}

- (void)drawRect:(CGRect)rect {

    
}


@end
