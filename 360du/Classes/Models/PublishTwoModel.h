//
//  PublishTwoModel.h
//  360du
//
//  Created by 利美 on 16/4/26.
//  Copyright © 2016年 wangjian. All rights reserved.
//

#import "BaseModel.h"

@interface PublishTwoModel : BaseModel<NSCoding>

@property (nonatomic ,strong) NSString *pid;
@property (nonatomic ,copy) NSString *name;

@end
