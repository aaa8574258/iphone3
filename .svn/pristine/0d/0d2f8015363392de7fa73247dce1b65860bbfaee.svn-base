//
//  MinePrivilageCollectionViewCell.m
//  360du
//
//  Created by linghang on 15/12/11.
//  Copyright © 2015年 wangjian. All rights reserved.
//

#import "MinePrivilageCollectionViewCell.h"
#import "MinePrivilegeTabCell.h"
#import "MinePrivilageViewController.h"
#define MINEPRIVILAGETABCELL @"minePrivilageTabCell"
@interface MinePrivilageCollectionViewCell()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,weak)UITableView *tableView;
@property(nonatomic,assign)CGFloat numSingleVesion;
@property(nonatomic,strong)NSArray *tempArr;
@property(nonatomic,copy)NSString *userStatustep;

@end
@implementation MinePrivilageCollectionViewCell
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.numSingleVesion = [VersionTranlate returnVersionRateAnyIphone:1];
        [self makeUI];
    }return self;
}
- (void)setDataArr:(NSArray *)dataArr{
    self.tempArr = dataArr;
    [self.tableView reloadData];
}
- (void)setUserStatus:(NSString *)userStatus{
    self.userStatustep = userStatus;
}
-(void)makeUI{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTENTVIEW, HEIGHT_CONTENTVIEW - 64) style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.separatorStyle = NO;
    [self.contentView addSubview:tableView];
    tableView.showsVerticalScrollIndicator = NO;
        //[tableView registerClass:[MinePrivilegeTabCell class] forCellReuseIdentifier:MINEPRIVILAGETABCELL];
        //[tableView registerClass:[StudyDetailTableViewCell class] forCellReuseIdentifier:STUDYD_EATILTABVIEWCELL];
    self.tableView = tableView;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tempArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
 
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150 * self.numSingleVesion;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return nil;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //StudyDetailTableViewCell *cell = nil;
    MinePrivilegeTabCell *cell = [tableView dequeueReusableCellWithIdentifier:MINEPRIVILAGETABCELL];
    if (!cell) {
        cell = [[MinePrivilegeTabCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MINEPRIVILAGETABCELL];
    }
    [cell.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [cell init];
    cell.model = self.tempArr[indexPath.row];
    cell.userStatus = self.userStatustep;
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.num == 0) {
        MinePrivilageModel *model = self.tempArr[indexPath.row];
        if ([self.target isKindOfClass:[MinePrivilageViewController class]]) {
            [self.target returnPrivilageModel:model];
        }
    }
}

@end
