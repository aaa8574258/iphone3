//
//  CleanerPublishViewController.h
//  360du
//
//  Created by 利美 on 16/4/21.
//  Copyright © 2016年 wangjian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
@interface CleanerPublishViewController : UIViewController
@property (copy, nonatomic) NSString *memnerId;
@property (copy, nonatomic) NSString *xqids;
@property (copy, nonatomic) NSString *shopname;
@property (copy, nonatomic) NSString *codename;
@property (copy, nonatomic) NSString *qycode;
@property (copy, nonatomic) NSString *scid;
@property (copy, nonatomic) NSString *mobile;
@property (copy, nonatomic) NSString *companyaddress;
@property (copy, nonatomic) NSString *serviceFeatures;

@property (copy ,nonatomic) NSString *chooseName;
@property (nonatomic ,copy) NSString *type;

@property(nonatomic,strong)CLGeocoder *geocoder;

@property (nonatomic ,copy) NSString *chooseNameID;
@property (nonatomic ,copy) NSString *typeID;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *DianPuNameToTopConstraint;
@property (weak, nonatomic) IBOutlet UIView *photoView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *photoHieght;



@property (copy ,nonatomic) NSString *latitude;
@property (copy,nonatomic) NSString *longitude;

@end
