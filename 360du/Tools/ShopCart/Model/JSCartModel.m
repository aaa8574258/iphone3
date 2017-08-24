//
//  JSCartModel.m
//  JSShopCartModule
//
//  Created by 乔同新 on 16/6/9.
//  Copyright © 2016年 乔同新. All rights reserved.
//

#import "JSCartModel.h"

@implementation JSCartModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"count"]) {
        self.p_quantity = key.integerValue;
    }
//    if ([key isEqualToString:@"unitPrice"]) {
//        self.p_price = key.floatValue;
//    }
   
    //    NSLog(@"%@",key);
    
}





@end
