//
//  AddrSecondTableViewController.h
//  360du
//
//  Created by 利美 on 16/4/26.
//  Copyright © 2016年 wangjian. All rights reserved.
//

#import <UIKit/UIKit.h>

//@protocol sendSecondAddr <NSObject>
//
//-(void) sendSecondAddr:(NSString *)string andCode:(NSString *)code;
//
//@end

@interface AddrSecondTableViewController : UITableViewController
@property(nonatomic,strong)NSString *name;
@property(nonatomic,copy)NSString *code;
@property(nonatomic,strong)NSArray *secondArr;
@property(nonatomic,copy) NSString *FirstName;

@property (nonatomic ,copy) NSString *flagStr;

//@property (nonatomic ,assign) id<sendSecondAddr>delegate;


-(id)initWithSecondArray:(NSArray *)array;

@end
