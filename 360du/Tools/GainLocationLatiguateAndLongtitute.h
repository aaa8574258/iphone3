//
//  GainLocationLatiguateAndLongtitute.h
//  360du
//
//  Created by linghang on 15-4-19.
//  Copyright (c) 2015年 wangjian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
typedef void(^LatitudeAndLongitudeBlock) (id latitudeAndLongtitudeArr);
@interface GainLocationLatiguateAndLongtitute : NSObject<CLLocationManagerDelegate>
@property(nonatomic,strong)CLGeocoder *geocoder;
@property(nonatomic,strong)CLLocationManager *locationManager;
@property(nonatomic,copy)LatitudeAndLongitudeBlock latitudeAndLongtitudeBlock;
-(void)returnlatitudeAndlongitudeAndBlock:(LatitudeAndLongitudeBlock)latitudeAndLongtitudeBlock;
@end
