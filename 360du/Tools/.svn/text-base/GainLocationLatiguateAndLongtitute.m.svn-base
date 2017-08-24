//
//  GainLocationLatiguateAndLongtitute.m
//  360du
//
//  Created by linghang on 15-4-19.
//  Copyright (c) 2015年 wangjian. All rights reserved.
//

#import "GainLocationLatiguateAndLongtitute.h"

@implementation GainLocationLatiguateAndLongtitute
-(void)returnlatitudeAndlongitudeAndBlock:(LatitudeAndLongitudeBlock)latitudeAndLongtitudeBlock{
    self.latitudeAndLongtitudeBlock = latitudeAndLongtitudeBlock;
    CLLocationManager *locationManager = [[CLLocationManager alloc] init];
    if (![CLLocationManager locationServicesEnabled]) {
        //return;
    }
    if (IOS8) {
        //定位管理器
        //_locationManager=[[CLLocationManager alloc]init];
        
        if (![CLLocationManager locationServicesEnabled]) {
            NSLog(@"定位服务当前可能尚未打开，请设置打开！");
            return;
        }
        
        //如果没有授权则请求用户授权
        if ([CLLocationManager authorizationStatus]==kCLAuthorizationStatusNotDetermined){
            [locationManager requestWhenInUseAuthorization];
        }else if([CLLocationManager authorizationStatus]==kCLAuthorizationStatusAuthorizedWhenInUse){
            //设置代理
            locationManager.delegate=self;
            //设置定位精度
            locationManager.desiredAccuracy=kCLLocationAccuracyBest;
            //定位频率,每隔多少米定位一次
            CLLocationDistance distance=0.5;//十米定位一次
            locationManager.distanceFilter=distance;
            //启动跟踪定位
            [locationManager startUpdatingLocation];
        }
        
    }else{
        //设置代理
        locationManager.delegate=self;
        //设置定位精度
        locationManager.desiredAccuracy=kCLLocationAccuracyBest;
        //定位频率,每隔多少米定位一次
        CLLocationDistance distance=0.5;//十米定位一次
        locationManager.distanceFilter=distance;
        //启动跟踪定位
        [locationManager startUpdatingLocation];
    }
   
}
#pragma mark 跟踪定位代理方法，每次位置发生变化即会执行（只要定位到相应位置）
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    NSLog(@"%@",newLocation);
}
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    //可以通过模拟器设置一个虚拟位置，否则在模拟器中无法调用此方法
    CLLocation *location = [locations firstObject];//取出第一个位置
#warning message location
    NSLog(@"%@",location);
    CLLocationCoordinate2D coordinate = location.coordinate;//位置坐标


    NSLog(@"经度：%f,纬度：%f,海拔：%f,航向：%f,行走速度：%f",coordinate.longitude,coordinate.latitude,location.altitude,location.course,location.speed);
    NSArray *tempArr = @[[NSString stringWithFormat:@"%f",coordinate.longitude],[NSString stringWithFormat:@"%f",coordinate.latitude]];
    [self.locationManager stopUpdatingLocation];
    if(self.latitudeAndLongtitudeBlock){
        self.latitudeAndLongtitudeBlock(tempArr);
    }
    
}
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    // The location "unknown" error simply means the manager is currently unable to get the location.
    // We can ignore this error for the scenario of getting a single location fix, because we already have a
    // timeout that will stop the location manager to save power.
    //
    NSLog(@"%@",error);
    if ([error code] != kCLErrorLocationUnknown) {
        NSLog(@"%@",error);    }
}

@end
