//
//  AddrFirstTableViewController.m
//  360du
//
//  Created by 利美 on 16/4/26.
//  Copyright © 2016年 wangjian. All rights reserved.
//

#import "AddrFirstTableViewController.h"
#import "hy_DataDownloadTools.h"
#import "AddrModel.h"
#import "AddrSecondTableViewController.h"
#import "CleanerPublishViewController.h"
#import "SendMessage.h"
#import "StoreageMessage.h"
@interface AddrFirstTableViewController ()

@end

@implementation AddrFirstTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"0.png"] forBarMetrics:UIBarMetricsDefault];
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(WIDTH_CONTROLLER - 32 , (44 - 2) / 2, 25, 25);
    [leftBtn setImage:[UIImage imageNamed:@"fanhuijian2222.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(setBack) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setImageEdgeInsets:UIEdgeInsetsMake(6, 5, 6, 5)];
    UIBarButtonItem *leftSecondItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftSecondItem;
    NSString *url = [NSString stringWithFormat:SHENGADDRESS,[StoreageMessage getCity]];
    NSString *url1 = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSString *url2 = [url1 stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    _dataArr = [NSMutableArray arrayWithCapacity:0];
        [hy_DataDownloadTools downloadDataWithURL:url2 andMethod:@"get" andBody:nil andBlock:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        self.dataArr = [NSMutableArray arrayWithCapacity:0];
        self.dataDic = [NSMutableDictionary dictionaryWithCapacity:0];
        NSArray *arr1 = dic[@"data"];
        for (NSDictionary *dic2 in arr1) {
            AddrModel *model = [[AddrModel alloc] init];
            [model setValuesForKeysWithDictionary:dic2];
            [self.dataArr addObject:model];
        }
            [self.tableView reloadData];
        }];
    }
    
//}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.dataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"addrFirstCell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"addrFirstCell"];
    }
    AddrModel *model = _dataArr[indexPath.row];
    cell.textLabel.text = model.name;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AddrModel *model = _dataArr[indexPath.row];
    NSString *url = [NSString stringWithFormat:SHIADDRESS,model.code,model.treeLevel];
//    NSLog(@"%@",url);
    NSString *url1 = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSString *url2 = [url1 stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/json",@"text/html",@"application/json",@"text/plain",nil];
    [manager GET:url2 parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [StoreageMessage getErrorMessage:@"NULL" fromUrl:url2];

        if ([responseObject[@"data"] count] == 0) {
//            [self.sendAddrDelegate sendAddr:model.name andCode:model.code];
            [SendMessage shareInstance].singleCode = model.code;
            [SendMessage shareInstance].singleValue = model.name;
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            self.secondArr = [NSMutableArray arrayWithCapacity:0];
            NSArray *arr = responseObject[@"data"];
            for (NSDictionary *dic in arr) {
                AddrModel *model1 = [[AddrModel alloc]init];
                [model1 setValuesForKeysWithDictionary:dic];
                [self.secondArr addObject:model1];
            }
            AddrSecondTableViewController *second = [[AddrSecondTableViewController alloc]initWithSecondArray:self.secondArr];
            second.FirstName = model.name;
            [self.navigationController pushViewController:second animated:YES];
            }
        }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//             NSLog(@"%@",error);
    }];
}


//code
-(void)sendAddr:(NSString *)string andCode:(NSString *)code{
    self.address = string;
}


-(void)setBack{
    [self.navigationController popViewControllerAnimated:YES];
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
