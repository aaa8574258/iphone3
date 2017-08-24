//
//  CleanerPublishTwoTableViewController.m
//  360du
//
//  Created by 利美 on 16/4/26.
//  Copyright © 2016年 wangjian. All rights reserved.
//

#import "CleanerPublishTwoTableViewController.h"
#import "hy_DataDownloadTools.h"
#import "PublishTwoModel.h"
#import "CleanerPublishViewController.h"

@interface CleanerPublishTwoTableViewController ()

@end

@implementation CleanerPublishTwoTableViewController

//-(void)loadView{
//    if (self.tableView == nil) {
//        UIStoryboard *cleanerSB = [UIStoryboard storyboardWithName:@"Cleaner" bundle:nil];
//        
//        self.tableView  = [cleanerSB instantiateViewControllerWithIdentifier:@"publishTwo"];
//    }
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(WIDTH_CONTROLLER - 32 , (44 - 2) / 2, 25, 25);
    [leftBtn setImage:[UIImage imageNamed:@"fanhuijian2222.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(setBack) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setImageEdgeInsets:UIEdgeInsetsMake(6, 5, 6, 5)];
    UIBarButtonItem *leftSecondItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftSecondItem;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.

//    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
//    NSString *path = [doc stringByAppendingPathComponent:CLEANERTYPE];
//    NSArray *arr = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
//    _dataArr = [NSMutableArray arrayWithArray:arr];
    _dataArr = [NSMutableArray arrayWithCapacity:0];
//    if (!arr) {
    NSString *url = CLEANERPUBLISHTWO;
    NSString *url1 = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSString *url2 = [url1 stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [hy_DataDownloadTools downloadDataWithURL:url2 andMethod:@"get" andBody:nil andBlock:^(NSData *data) {
        NSArray *arr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        self.dataArr = [NSMutableArray arrayWithCapacity:0];
//        NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
//        NSString *dataPath = [docPath stringByAppendingString:CLEANERTYPE];
        NSLog(@"%@",arr);
        for (NSDictionary *dic in arr) {
            PublishTwoModel *model = [[PublishTwoModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [self.dataArr addObject:model];
//            [NSKeyedArchiver archiveRootObject:_dataArr toFile:dataPath];
        }
        [self.tableView reloadData];
    }];
// }
}

-(void)setBack{
    
    [self.navigationController popViewControllerAnimated:YES];
}

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
    return _dataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"publishTwo"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"publishTwo"];
    }
    PublishTwoModel *model = self.dataArr[indexPath.row];
    cell.textLabel.text = model.name;
    // Configure the cell...
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PublishTwoModel *model = self.dataArr[indexPath.row];
//
//    UIStoryboard *cleanerSB = [UIStoryboard storyboardWithName:@"Cleaner" bundle:nil];
//
//    CleanerPublishViewController *CPVC = [cleanerSB instantiateViewControllerWithIdentifier:@"cleanerPublish"];
//    CleanerPublishViewController *CPVC = [[CleanerPublishViewController alloc]initWithNibName:@"cleanerPublish" bundle:nil];
//    CPVC.type = model.name;
    [self.delegate popString:model.name andCode:model.pid];
//    [self.navigationController pushViewController:CPVC animated:YES];
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
