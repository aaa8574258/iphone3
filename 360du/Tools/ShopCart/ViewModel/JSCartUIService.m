//
//  JSCartUIService.m
//  JSShopCartModule
//
//  Created by 乔同新 on 16/6/9.
//  Copyright © 2016年 乔同新. All rights reserved.
//

#import "JSCartUIService.h"
#import "JSCartViewModel.h"
#import "JSCartCell.h"
#import "JSCartHeaderView.h"
#import "JSCartFooterView.h"
#import "JSCartModel.h"
#import "JSNummberCount.h"
#import "StoreageMessage.h"
#import "NSString+URLEncoding.h"
@implementation JSCartUIService

#pragma mark - UITableView Delegate/DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.viewModel.cartData.count;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return [self.viewModel.cartData[section] count];
}

#pragma mark - header view

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return [JSCartHeaderView getCartHeaderHeight];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    NSMutableArray *shopArray = self.viewModel.cartData[section];
    NSLog(@"222222%@",shopArray);
    JSCartHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"JSCartHeaderView"];
    //店铺全选
    [[[headerView.selectStoreGoodsButton rac_signalForControlEvents:UIControlEventTouchUpInside]takeUntil:headerView.rac_prepareForReuseSignal] subscribeNext:^(UIButton *xx) {
        xx.selected = !xx.selected;
        BOOL isSelect = xx.selected;
        [self.viewModel.shopSelectArray replaceObjectAtIndex:section withObject:@(isSelect)];
        for (JSCartModel *model in shopArray) {
            NSLog(@"%@",model.shopName);
            [model setValue:@(isSelect) forKey:@"isSelect"];
        }
        [self.viewModel.cartTableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationNone];
        
        self.viewModel.allPrices = [self.viewModel getAllPrices];
    }];
    JSCartModel *model = self.viewModel.sectionData[section];
    NSLog(@"uuuu%@,%@",self.viewModel.sectionData,model.p_name);
    [headerView.storeNameButton setTitle:model.p_name
                          forState:UIControlStateNormal];

    //店铺选中状态
    headerView.selectStoreGoodsButton.selected = [self.viewModel.shopSelectArray[section] boolValue];
    
//    [RACObserve(headerView.selectStoreGoodsButton, selected) subscribeNext:^(NSNumber *x) {
//        
//        BOOL isSelect = x.boolValue;
//        
//        [self.viewModel.shopSelectArray replaceObjectAtIndex:section withObject:@(isSelect)];
//        for (JSCartModel *model in shopArray) {
//            [model setValue:@(isSelect) forKey:@"isSelect"];
//        }
//        [self.viewModel.cartTableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationNone];
//    }];
    
    return headerView;
}

#pragma mark - footer view

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return [JSCartFooterView getCartFooterHeight];
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    NSMutableArray *shopArray = self.viewModel.cartData[section];
    
    JSCartFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"JSCartFooterView"];
    
    footerView.shopGoodsArray = shopArray;
    
    return footerView;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [JSCartCell getCartCellHeight];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JSCartCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JSCartCell"
                                                       forIndexPath:indexPath];
    
    [self configureCell:cell forRowAtIndexPath:indexPath];
//    cell.showsReorderControl =YES; 
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSInteger section = indexPath.section;
        NSInteger row = indexPath.row;
        JSCartModel *model = self.viewModel.cartData[section][row];

        JSCartModel *model1 = self.viewModel.cartData[section][0];
        NSArray *arr = self.viewModel.cartData;
        [self.viewModel.cartData[indexPath.section] removeObjectAtIndex:indexPath.row];
        // Delete the row from the data source.
        [self.viewModel.cartTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        NSLog(@"%@",self.viewModel.cartData);
        if ([arr[section] count] == 0) {
            
            NSLog(@"%@",model1.shopCarId);
            AFNetworkTwoPackaging *twoPacking = [[AFNetworkTwoPackaging alloc] init];

            [twoPacking getUrl:[NSString stringWithFormat:DELSHOPPINGCARPRO,[StoreageMessage getMessage][2],model1.shopCarId] andFinishBlock:^(id getResult) {
                NSLog(@"22222：：%@",getResult);
                //            [self.viewModel.cartTableView reloadData];
            }];
            return;
        }
        AFNetworkTwoPackaging *twoPacking = [[AFNetworkTwoPackaging alloc] init];

        
        NSLog(@"%@",[NSString stringWithFormat:DELSHOPPINGCARPRO,[StoreageMessage getMessage][2],model.shopCarId]);
        [twoPacking getUrl:[NSString stringWithFormat:DELSHOPPINGCARPRO,[StoreageMessage getMessage][2],model.shopCarId] andFinishBlock:^(id getResult) {
            NSLog(@"22222：：%@",getResult);
//            [self.viewModel.cartTableView reloadData];
        }];
        
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}


- (void)configureCell:(JSCartCell *)cell
    forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    JSCartModel *model = self.viewModel.cartData[section][row];
    //cell 选中
    WEAK
    [[[cell.selectShopGoodsButton rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(UIButton *x) {
        STRONG
        x.selected = !x.selected;
//        NSLog(@"选中了");
        [self.viewModel rowSelect:x.selected IndexPath:indexPath];
    }];
    //数量改变
    cell.nummberCount.NumberChangeBlock = ^(NSInteger changeCount){
        STRONG
        NSLog(@"%lD,%@",(long)changeCount,indexPath);
        [self plusOrmintWithIndexPath:indexPath andChengeCount:changeCount];
        [self.viewModel rowChangeQuantity:changeCount indexPath:indexPath];
    };
    cell.model = model;
}


-(void) plusOrmintWithIndexPath:(NSIndexPath *)indexPath andChengeCount:(NSInteger )chengeCount{
    NSString *strCPID;
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    JSCartModel *model = self.viewModel.cartData[section][row];
    AFNetworkTwoPackaging *twoPacking = [[AFNetworkTwoPackaging alloc] init];
    if ([model.shopType isEqualToString:@"1"]) {
        strCPID = model.did;
    }else{
        strCPID = model.cpid;
    }
    
    
    NSLog(@"%@",[NSString stringWithFormat:OPERATORSHOPPINGCAR,[StoreageMessage getMessage][2],strCPID,[NSString stringWithFormat:@"%ld",model.count],model.pid,model.shopType,model.proRule]);
    [twoPacking getUrl:[NSString stringWithFormat:OPERATORSHOPPINGCAR,[StoreageMessage getMessage][2],strCPID,[NSString stringWithFormat:@"%ld",model.count],model.pid,model.shopType,[[model.proRule urlEncodeString] urlEncodeString]] andFinishBlock:^(id getResult) {
        NSLog(@"22222：：%@",getResult);
    }];
}



@end
