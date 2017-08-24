




/********************* 有任何问题欢迎反馈给我 liuweiself@126.com ****************************************/
/***************  https://github.com/waynezxcv/Gallop 持续更新 ***************************/
/******************** 正在不断完善中，谢谢~  Enjoy ******************************************************/










#import "MomentsViewController.h"
#import "LWImageBrowser.h"
#import "TableViewCell.h"
#import "TableViewHeader.h"
#import "StatusModel.h"
#import "CellLayout.h"
#import "CommentView.h"
#import "CommentModel.h"
#import "LWAlertView.h"
#import "InfoPublishViewController.h"
#import "StoreageMessage.h"
#import "UIView+Toast.h"
#import "ImageAndNameViewController.h"
#import "NSString+URLEncoding.h"
@interface MomentsViewController ()

<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSArray* fakeDatasource;
@property (nonatomic,strong) UITableView* tableView;
@property (nonatomic,strong) NSMutableArray* dataSource;
@property (nonatomic,strong) TableViewHeader* tableViewHeader;
@property (nonatomic,strong) CommentView* commentView;
@property (nonatomic,strong) CommentModel* postComment;
@property (nonatomic,assign,getter = isNeedRefresh) BOOL needRefresh;
@property (nonatomic,assign) BOOL displaysAsynchronously;//是否异步绘制
@property (nonatomic ,copy) NSString *userImageUrl;
@property (nonatomic ,copy) NSString *userName;
@property (nonatomic ,copy) NSString *userSex;
@property (nonatomic ,assign) BOOL isMasterRoNot;
@property (nonatomic ,strong) UIView *Tview;
@property (nonatomic ,strong) CommentModel *selfModel;
@property (nonatomic ,assign) BOOL isLikeAppear;
@property (nonatomic ,copy) NSArray *AppearData;
@end



const CGFloat kRefreshBoundary = 170.0f;




@implementation MomentsViewController

#pragma mark - ViewControllerLifeCycle

- (void)loadView {
    [super loadView];
    [self setup];
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self makeNavAndUI];
}

-(void)haveNameAndImage{
    AFNetworkTwoPackaging *twoPacking = [[AFNetworkTwoPackaging alloc] init];
    [twoPacking getUrl:[NSString stringWithFormat:USERNAMEANDIMAGE,[StoreageMessage getMessage][2]] andFinishBlock:^(id getResult) {
        NSLog(@"%@",getResult);
        [self isMaster];
        if (getResult[@"datas"][@"nickName"] && getResult[@"datas"][@"imgHead"] && getResult[@"datas"][@"Sex"]) {
            self.userName = getResult[@"datas"][@"nickName"];
            self.userImageUrl = getResult[@"datas"][@"imgHead"];
            self.userSex  = getResult[@"datas"][@"Sex"];
        }else{
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请完善您的信息" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
            alertView.tag = 987654;
            [alertView show];
            
        }
        
        
        NSLog(@"%@--%@--%@",self.userSex,self.userImageUrl,self.userName);
    }];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 987654) {
        if (buttonIndex == 0) {
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            ImageAndNameViewController *name  = [[ImageAndNameViewController alloc] init];
            [self.navigationController pushViewController:name animated:YES];
        }
    }
}


-(void) isMaster{
    AFNetworkTwoPackaging *twoPacking = [[AFNetworkTwoPackaging alloc] init];
    [twoPacking getUrl:[NSString stringWithFormat:ISMASTERORNOT,[StoreageMessage getCommuntityId],[StoreageMessage getMessage][2]] andFinishBlock:^(id getResult) {
        NSLog(@"%@",getResult);
        [self isLikeOrPing];
        if ([getResult[@"code"] isEqualToString:@"000000"]) {
            self.isMasterRoNot = YES;
        }else{
            self.isMasterRoNot = NO;
        }
    }];
}


-(void) isLikeOrPing{
    AFNetworkTwoPackaging *twoPacking = [[AFNetworkTwoPackaging alloc] init];
    [twoPacking getUrl:[NSString stringWithFormat:ISLIKEORPINGLUN,[StoreageMessage getCommuntityId]] andFinishBlock:^(id getResult) {
        NSLog(@"%@",getResult);
        self.isLikeAppear = NO;

        if ([[NSString stringWithFormat:@"%@",getResult[@"comment_flag"]] isEqualToString:@"0"]) {
            NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
            for (NSDictionary *dic in getResult[@"data"]) {
                NSLog(@"%@",dic);
                if ([dic[@"memberId"] isEqualToString:[StoreageMessage getMessage][2]]) {
                    self.isLikeAppear = YES;
                }
                [arr addObject:dic[@"memberId"]];
            }
            self.AppearData = arr.mutableCopy;
        }else{
            self.isLikeAppear = YES;
        }
        [self checkUser];

    }];

}



-(void)checkUser{
    NSLog(@"%@",[StoreageMessage getMessage][2]);
    AFNetworkTwoPackaging *twoPacking = [[AFNetworkTwoPackaging alloc] init];
    [twoPacking getUrl:[NSString stringWithFormat:ISPUBLISHINFO,[StoreageMessage getCommuntityId]] andFinishBlock:^(id getResult) {
        NSLog(@"%@",getResult);
        
        if ([[NSString stringWithFormat:@"%@",getResult[@"flag"]] isEqualToString:@"1"]) {
            [self makeNavAndUI];
        }else if ([[NSString stringWithFormat:@"%@",getResult[@"flag"]] isEqualToString:@"0"]){
            for (NSDictionary *dic in getResult[@"data"]) {
                if ([[NSString stringWithFormat:@"%@",dic[@"memberId"]] isEqualToString:[StoreageMessage getMessage][2]]) {
                    [self makeNavAndUI];
                }else{
                    [self makeNavAndUI2];
                }
            }
        
        }
    }];
}



-(void)makeNavAndUI{
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(WIDTH_CONTROLLER - 32 , (44 - 2) / 2, 30, 30);
    [leftBtn setImage:[UIImage imageNamed:@"fanhuijian2222.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(setBack) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setImageEdgeInsets:UIEdgeInsetsMake(6, 5, 6, 5)];
    UIBarButtonItem *leftSecondItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftSecondItem;
    
    UIButton *searchBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn1.frame = CGRectMake(WIDTH_CONTROLLER + 30 , 0,30, 30);
    [searchBtn1 setImage:[UIImage imageNamed:@"发布@2x.png"] forState:UIControlStateNormal];
    searchBtn1.titleLabel.font = [UIFont systemFontOfSize:14];
    [searchBtn1 addTarget:self action:@selector(backDown:) forControlEvents:UIControlEventTouchUpInside];
    searchBtn1.userInteractionEnabled = YES;
    searchBtn1.tag = 10086;
    UIBarButtonItem *right1 = [[UIBarButtonItem alloc] initWithCustomView:searchBtn1];
    searchBtn1.hidden = YES;
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.frame = CGRectMake(WIDTH_CONTROLLER + 30 , 0,50, 30);
    [searchBtn setTitle:@"发布" forState:UIControlStateNormal];
    [searchBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    searchBtn.backgroundColor = [UIColor colorWithRed:255/255.0 green:39/255.0 blue:77/255.0 alpha:1];
    searchBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [searchBtn addTarget:self action:@selector(backDown:) forControlEvents:UIControlEventTouchUpInside];
    searchBtn.userInteractionEnabled = YES;
    searchBtn.tag = 10087;
    UIBarButtonItem *right2 = [[UIBarButtonItem alloc] initWithCustomView:searchBtn];
    self.navigationItem.rightBarButtonItems = @[right2,right1];
    
    
    
    UIView *fontView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    fontView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.commentView];
    [self.view addSubview:fontView];
}



-(void)makeNavAndUI2{
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(WIDTH_CONTROLLER - 32 , (44 - 2) / 2, 30, 30);
    [leftBtn setImage:[UIImage imageNamed:@"fanhuijian2222.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(setBack) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setImageEdgeInsets:UIEdgeInsetsMake(6, 5, 6, 5)];
    UIBarButtonItem *leftSecondItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftSecondItem;

    
    
    
    UIView *fontView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    fontView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.commentView];
    [self.view addSubview:fontView];
}








-(void)backDown:(UIButton *)sender{
    InfoPublishViewController *controller = [[InfoPublishViewController alloc] initWithTag:@"1"];
    
    [self.navigationController pushViewController:controller animated:YES];
}

-(void)setBack{

    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self haveNameAndImage];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidAppearNotifications:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHidenNotifications:)
                                                 name:UIKeyboardWillHideNotification object:nil];

}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardDidShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardDidHideNotification
                                                  object:nil];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
//    if (self.isNeedRefresh) {
        [self refreshBegin];
//    }
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CellLayout* layout = self.dataSource[indexPath.row];
    return layout.cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* cellIdentifier = @"cellIdentifier";
    TableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    [self confirgueCell:cell atIndexPath:indexPath];
    CellLayout* layout = [self.dataSource objectAtIndex:indexPath.row];
    NSLog(@"%@--%@--%id",layout.statusModel.statusID,[StoreageMessage getMessage][2],_isMasterRoNot);
    if ([layout.statusModel.statusID isEqualToString:[StoreageMessage getMessage][2]] || _isMasterRoNot) {
        cell.deleateButton.hidden = NO;
        cell.deleateButton.tag =  indexPath.row + 1234567;
        [cell.deleateButton addTarget:self action:@selector(deletMessageAct:) forControlEvents:UIControlEventTouchUpInside];
    }else{
        [cell.deleateButton removeFromSuperview];
    }
    NSLog(@"%id",self.isLikeAppear);
       if ( self.isLikeAppear == NO) {
//            cell.menuButton.hidden = NO;
           cell.menuButton.hidden = YES;

       }
    
    
    cell.webBtn.tag =  indexPath.row + 12345678;
//    cell.menuButton .hidden = YES;
    [cell.webBtn addTarget:self action:@selector(web:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

-(void)deletMessageAct:(UIButton *)sender{
    CellLayout* layout = [self.dataSource objectAtIndex:sender.tag - 1234567];
    AFNetworkTwoPackaging *twoPacking = [[AFNetworkTwoPackaging alloc] init];
    [twoPacking getUrl:[NSString stringWithFormat:DELETEMESSAGE,layout.statusModel.ccid] andFinishBlock:^(id getResult) {
        NSLog(@"%@",getResult);
        [self refreshBegin];
    }];
}

-(void)web:(UIButton *)sender{
    CellLayout* layout = [self.dataSource objectAtIndex:sender.tag - 12345678];

    NSURL *cleanURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@",layout.statusModel.content]];
    [[UIApplication sharedApplication] openURL:cleanURL];
}


- (void)confirgueCell:(TableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.displaysAsynchronously = self.displaysAsynchronously;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.indexPath = indexPath;
    CellLayout* cellLayout = self.dataSource[indexPath.row];
    cell.cellLayout = cellLayout;
    [self callbackWithCell:cell];
}

- (void)callbackWithCell:(TableViewCell *)cell {
    
    __weak typeof(self) weakSelf = self;
    cell.clickedLikeButtonCallback = ^(TableViewCell* cell,BOOL isLike) {
        __strong typeof(weakSelf) sself = weakSelf;
        NSLog(@"%id",isLike);
        [sself tableViewCell:cell didClickedLikeButtonWithIsLike:isLike];
    };
    
    cell.clickedCommentButtonCallback = ^(TableViewCell* cell) {
        __strong typeof(weakSelf) sself = weakSelf;
        [sself commentWithCell:cell];
    };
    
    cell.clickedReCommentCallback = ^(TableViewCell* cell,CommentModel* model) {
        NSLog(@"%@",model.to);
        __strong typeof(weakSelf) sself = weakSelf;
        [sself reCommentWithCell:cell commentModel:model];
    };
    
    cell.clickedOpenCellCallback = ^(TableViewCell* cell) {
        __strong typeof(weakSelf) sself = weakSelf;
        [sself openTableViewCell:cell];
    };
    
    cell.clickedCloseCellCallback = ^(TableViewCell* cell) {
        __strong typeof(weakSelf) sself = weakSelf;
        [sself closeTableViewCell:cell];
    };
    
    cell.clickedAvatarCallback = ^(TableViewCell* cell) {
        __strong typeof(weakSelf) sself = weakSelf;
        [sself showAvatarWithCell:cell];
    };
    
    cell.clickedImageCallback = ^(TableViewCell* cell,NSInteger imageIndex) {
        __strong typeof(weakSelf) sself = weakSelf;
        [sself tableViewCell:cell showImageBrowserWithImageIndex:imageIndex];
    };
}

#pragma mark - Actions
//开始评论
- (void)commentWithCell:(TableViewCell *)cell  {
    self.postComment.from = self.userName;
    self.postComment.to = @"";
    self.postComment.toId = @"NULL";
    self.postComment.index = cell.indexPath.row;
    self.commentView.placeHolder = @"评论";
    if (![self.commentView.textView isFirstResponder]) {
        [self.commentView.textView becomeFirstResponder];
    }
}

//开始回复评论
- (void)reCommentWithCell:(TableViewCell *)cell commentModel:(CommentModel *)commentModel {
    NSLog(@"%@",commentModel.toId);
    self.selfModel = commentModel;
    
    if (ISMASTERORNOT) {
        [self makeDeleteView];
    }else{
        
        self.postComment.from = self.userName;
        self.postComment.to = commentModel.to;
        self.postComment.index = commentModel.index;
        self.postComment.toId = commentModel.toId;
        self.commentView.placeHolder = [NSString stringWithFormat:@"回复%@:",commentModel.to];
        if (![self.commentView.textView isFirstResponder]) {
            [self.commentView.textView becomeFirstResponder];
        }
    }
    
    
}

-(void) makeDeleteView{
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    view1.backgroundColor = [UIColor colorWithRed:20/255.0 green:29/255.0 blue:44/255.0 alpha:0.3];
    [self.view addSubview:view1];
    self.Tview = view1;

    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10 , self.view.frame.size.height - 100, self.view.frame.size.width - 20 , 100)];
    view.backgroundColor = [UIColor colorWithRed:20/255.0 green:29/255.0 blue:44/255.0 alpha:0.3];
    [view1 addSubview:view];
    UILabel *labDelete = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, 30)];
    labDelete.backgroundColor = [UIColor whiteColor];
    labDelete.text = @"删除";
    labDelete.textColor = [UIColor redColor];
    labDelete.font = [UIFont systemFontOfSize:13];
    labDelete.textAlignment = NSTextAlignmentCenter;
    labDelete.tag = 100000;
    [view addSubview:labDelete];
    
    UILabel *labh = [[UILabel alloc] initWithFrame:CGRectMake(0, 31, view.frame.size.width, 30)];
    labh.backgroundColor = [UIColor whiteColor];
    labh.text = @"回复";
    labh.textColor = [UIColor redColor];
    labh.font = [UIFont systemFontOfSize:13];
    labh.textAlignment = NSTextAlignmentCenter;
    labh.tag = 99999;
    [view addSubview:labh];
    
    UILabel *labqx = [[UILabel alloc] initWithFrame:CGRectMake(0, 65, view.frame.size.width, 30)];
    labqx.backgroundColor = [UIColor whiteColor];
    labqx.text = @"取消";
    labqx.textColor = [UIColor redColor];
    labqx.font = [UIFont systemFontOfSize:13];
    labqx.textAlignment = NSTextAlignmentCenter;
    labqx.tag = 99998;
    [view addSubview:labqx];
    UITapGestureRecognizer *tapPay11 =[[ UITapGestureRecognizer alloc ] initWithTarget : self action : @selector (tapAction:)];
    [labDelete addGestureRecognizer :tapPay11];
    labDelete. userInteractionEnabled = YES ;
    UITapGestureRecognizer *tapPay12 =[[ UITapGestureRecognizer alloc ] initWithTarget : self action : @selector (tapAction:)];
    [labh addGestureRecognizer :tapPay12];
    labh. userInteractionEnabled = YES ;
    UITapGestureRecognizer *tapPay13 =[[ UITapGestureRecognizer alloc ] initWithTarget : self action : @selector (tapAction:)];
    [labqx addGestureRecognizer :tapPay13];
    labqx. userInteractionEnabled = YES ;
    
}

-(void)tapAction:( UITapGestureRecognizer *)gestureRecognizer{
    [self.Tview removeFromSuperview];
    if (gestureRecognizer.view.tag == 100000) {
        CommentModel *model = self.selfModel;
        CellLayout* layout = [self.dataSource objectAtIndex:model.index];
        NSLog(@"%ld---%@",model.i,layout.statusModel.commentList);

        NSMutableArray* newCommentLists = [[NSMutableArray alloc] initWithArray:layout.statusModel.commentListIds];
       
        [newCommentLists removeObjectAtIndex:model.i];
        StatusModel* statusModel = layout.statusModel;
        statusModel.commentListIds = newCommentLists;
        CellLayout* newLayout = [self layoutWithStatusModel:statusModel index:model.index];
//        [self pingLunWithCcid:layout.statusModel.ccid from:[StoreageMessage getMessage][2] to:model.toId content:model.content];
        [self deleMessageP:model.mcid];
        UITableViewCell* cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:model.index inSection:0]];
        [self coverScreenshotAndDelayRemoveWithCell:cell cellHeight:newLayout.cellHeight];
        
        [self.dataSource replaceObjectAtIndex:model.index withObject:newLayout];
        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:model.index inSection:0]]
                              withRowAnimation:UITableViewRowAnimationNone];
        
    }else if (gestureRecognizer.view.tag == 99999){
        CommentModel *commentModel = self.selfModel;
        self.postComment.from = self.userName;
        self.postComment.to = commentModel.to;
        self.postComment.index = commentModel.index;
        self.postComment.toId = commentModel.toId;
        self.commentView.placeHolder = [NSString stringWithFormat:@"回复%@:",commentModel.to];
        if (![self.commentView.textView isFirstResponder]) {
            [self.commentView.textView becomeFirstResponder];
        }
    }else if (gestureRecognizer.view.tag == 99998){
    
    
    }
    
}


-(void)deleMessageP:(NSString *)mcid{
    AFNetworkTwoPackaging *twoPacking = [[AFNetworkTwoPackaging alloc] init];
    [twoPacking getUrl:[NSString stringWithFormat:DELETEUSERMESSAGE,mcid] andFinishBlock:^(id getResult) {
        NSLog(@"%@",getResult);
        if ([getResult[@"code"] isEqualToString:@"000000"]) {
            [self.view makeToast:@"删除评论成功"];

        }
        
    }];
}





//点击查看大图
- (void)tableViewCell:(TableViewCell *)cell showImageBrowserWithImageIndex:(NSInteger)imageIndex {
    NSMutableArray* tmps = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < cell.cellLayout.imagePostions.count; i ++) {
        LWImageBrowserModel* model = [[LWImageBrowserModel alloc]
                                      initWithplaceholder:nil
                                      thumbnailURL:[NSURL URLWithString:[cell.cellLayout.statusModel.imgs objectAtIndex:i]]
                                      HDURL:[NSURL URLWithString:[cell.cellLayout.statusModel.imgs objectAtIndex:i]]
                                      containerView:cell.contentView
                                      positionInContainer:CGRectFromString(cell.cellLayout.imagePostions[i])
                                      index:i];
        [tmps addObject:model];
    }
    LWImageBrowser* browser = [[LWImageBrowser alloc] initWithImageBrowserModels:tmps
                                                                    currentIndex:imageIndex];
    
    [browser show];
}

//查看头像
- (void)showAvatarWithCell:(TableViewCell *)cell {
//    [LWAlertView shoWithMessage:[NSString stringWithFormat:@"点击了头像:%@",cell.cellLayout.statusModel.name]];
}


/* 由于是异步绘制，而且为了减少View的层级，整个显示内容都是在同一个UIView上面，所以会在刷新的时候闪一下，这里可以先把原先Cell的内容截图覆盖在Cell上，
 延迟0.25s后待刷新完成后，再将这个截图从Cell上移除 */
- (void)coverScreenshotAndDelayRemoveWithCell:(UITableViewCell *)cell cellHeight:(CGFloat)cellHeight {
    
    UIImage* screenshot = [GallopUtils screenshotFromView:cell];
    
    UIImageView* imgView = [[UIImageView alloc] initWithFrame:[self.tableView convertRect:cell.frame toView:self.tableView]];
    
    imgView.frame = CGRectMake(imgView.frame.origin.x,
                               imgView.frame.origin.y,
                               imgView.frame.size.width,
                               cellHeight);
    
    imgView.contentMode = UIViewContentModeTop;
    imgView.backgroundColor = [UIColor whiteColor];
    imgView.image = screenshot;
    [self.tableView addSubview:imgView];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [imgView removeFromSuperview];
    });
    
}


//点赞
- (void)tableViewCell:(TableViewCell *)cell didClickedLikeButtonWithIsLike:(BOOL)isLike {
    
    
    CellLayout* layout = [self.dataSource objectAtIndex:cell.indexPath.row];
    NSMutableArray* newLikeList = [[NSMutableArray alloc] initWithArray:layout.statusModel.likeList];
    if (isLike) {
        [newLikeList addObject:self.userName];
        [self likeThisMessageWithCcid:layout.statusModel.ccid];
    } else {
        [newLikeList removeObject:self.userName];
        [self donotLikeThisMessageWithCcid:layout.statusModel.ccid];

    }
    
    StatusModel* statusModel = layout.statusModel;
    statusModel.likeList = newLikeList;
    statusModel.isLike = isLike;
    layout = [self layoutWithStatusModel:statusModel index:cell.indexPath.row];
    
    [self coverScreenshotAndDelayRemoveWithCell:cell cellHeight:layout.cellHeight];
    
    [self.dataSource replaceObjectAtIndex:cell.indexPath.row withObject:layout];
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:cell.indexPath.row inSection:0]]
                          withRowAnimation:UITableViewRowAnimationNone];
}

-(void)likeThisMessageWithCcid:(NSString *)ccid{
    NSLog(@"%@",ccid);
    AFNetworkTwoPackaging *twoPacking = [[AFNetworkTwoPackaging alloc] init];
    [twoPacking getUrl:[NSString stringWithFormat:LIKEUSERMESSAGE,ccid,[StoreageMessage getMessage][2]] andFinishBlock:^(id getResult) {
        NSLog(@"%@",getResult);
        
    }];
    
}

-(void)donotLikeThisMessageWithCcid:(NSString *)ccid{
    AFNetworkTwoPackaging *twoPacking = [[AFNetworkTwoPackaging alloc] init];
    [twoPacking getUrl:[NSString stringWithFormat:NOLIKEUSERMESSAGE,ccid,[StoreageMessage getMessage][2]] andFinishBlock:^(id getResult) {
        NSLog(@"%@",getResult);
        
    }];
}

//展开Cell
- (void)openTableViewCell:(TableViewCell *)cell {
    CellLayout* layout =  [self.dataSource objectAtIndex:cell.indexPath.row];
    StatusModel* model = layout.statusModel;
    CellLayout* newLayout = [[CellLayout alloc] initContentOpendLayoutWithStatusModel:model
                                                                                index:cell.indexPath.row
                                                                        dateFormatter:self.dateFormatter];
    
    [self coverScreenshotAndDelayRemoveWithCell:cell cellHeight:newLayout.cellHeight];
    
    
    [self.dataSource replaceObjectAtIndex:cell.indexPath.row withObject:newLayout];
    [self.tableView reloadRowsAtIndexPaths:@[cell.indexPath]
                          withRowAnimation:UITableViewRowAnimationNone];
}

//折叠Cell
- (void)closeTableViewCell:(TableViewCell *)cell {
    CellLayout* layout =  [self.dataSource objectAtIndex:cell.indexPath.row];
    StatusModel* model = layout.statusModel;
    CellLayout* newLayout = [[CellLayout alloc] initWithStatusModel:model
                                                              index:cell.indexPath.row
                                                      dateFormatter:self.dateFormatter];
    
    [self coverScreenshotAndDelayRemoveWithCell:cell cellHeight:newLayout.cellHeight];
    
    
    [self.dataSource replaceObjectAtIndex:cell.indexPath.row withObject:newLayout];
    [self.tableView reloadRowsAtIndexPaths:@[cell.indexPath]
                          withRowAnimation:UITableViewRowAnimationNone];
}

//发表评论
- (void)postCommentWithCommentModel:(CommentModel *)model {
//    model = self.selfModel;
    CellLayout* layout = [self.dataSource objectAtIndex:model.index];
    NSMutableArray* newCommentLists = [[NSMutableArray alloc] initWithArray:layout.statusModel.commentListIds];
    NSLog(@"%@--%@--%@--%@--%ld--%@",model.fromId,model.toId,model.from,model.to,model.index,layout.statusModel.ccid);
    NSDictionary* newComment = @{@"from_nickName":model.from,
                                 @"to_nickName":model.to,
                                 @"commentContent":model.content };
    [newCommentLists addObject:newComment];
    StatusModel* statusModel = layout.statusModel;
    statusModel.commentListIds = newCommentLists;
    CellLayout* newLayout = [self layoutWithStatusModel:statusModel index:model.index];
    [self pingLunWithCcid:layout.statusModel.ccid from:[StoreageMessage getMessage][2] to:model.toId content:model.content];
    NSLog(@"%lu",(unsigned long)statusModel.commentListIds.count);
    if (statusModel.commentListIds.count == 1) {
        [self refreshBegin];
    }else{
    UITableViewCell* cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:model.index inSection:0]];
    [self coverScreenshotAndDelayRemoveWithCell:cell cellHeight:newLayout.cellHeight];
    [self.dataSource replaceObjectAtIndex:model.index withObject:newLayout];
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:model.index inSection:0]]
                          withRowAnimation:UITableViewRowAnimationNone];
    }
//    layout = [self layoutWithStatusModel:statusModel index:cell.indexPath.row];
//    
//    [self coverScreenshotAndDelayRemoveWithCell:cell cellHeight:layout.cellHeight];
//    
//    [self.dataSource replaceObjectAtIndex:cell.indexPath.row withObject:layout];
//    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:cell.indexPath.row inSection:0]]
//                          withRowAnimation:UITableViewRowAnimationNone];
}

-(void)pingLunWithCcid:(NSString *)ccid from:(NSString *)from to:(NSString *)to content:(NSString *)content{
    NSLog(@"%@---%@--%@-%@",ccid,from,to,content);
    AFNetworkTwoPackaging *twoPacking = [[AFNetworkTwoPackaging alloc] init];
    [twoPacking getUrl:[NSString stringWithFormat:INFOLISTSHEQPINGLUN,[NSString stringWithFormat:@"%@",ccid],from,to,[[content urlEncodeString] urlEncodeString]] andFinishBlock:^(id getResult) {
        NSLog(@"%@",getResult);
        
    }];
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.commentView endEditing:YES];
    CGFloat offset = scrollView.contentOffset.y;
    [self.tableViewHeader loadingViewAnimateWithScrollViewContentOffset:offset];
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    CGFloat offset = scrollView.contentOffset.y;
    if (offset <= -kRefreshBoundary) {
        [self refreshBegin];
    }
}

#pragma mark - Keyboard

- (void)tapView:(id)sender {
    [self.commentView endEditing:YES];
}

- (void)keyboardDidAppearNotifications:(NSNotification *)notifications {
    NSDictionary *userInfo = [notifications userInfo];
    CGSize keyboardSize = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    CGFloat keyboardHeight = keyboardSize.height;
    self.commentView.frame = CGRectMake(0.0f, SCREEN_HEIGHT - 44.0f - keyboardHeight, SCREEN_WIDTH, 44.0f);
}

- (void)keyboardDidHidenNotifications:(NSNotification *)notifications {
    self.commentView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 44.0f);
}

#pragma mark - Data

//模拟下拉刷新
- (void)refreshBegin {
    [UIView animateWithDuration:0.2f animations:^{
        self.needRefresh = YES;
        self.tableView.contentInset = UIEdgeInsetsMake(kRefreshBoundary, 0.0f, 0.0f, 0.0f);
    } completion:^(BOOL finished) {
        [self.tableViewHeader refreshingAnimateBegin];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.f * NSEC_PER_SEC)),
                       dispatch_get_main_queue(), ^{
                           [self fakeDownload];
                       });
    }];
}

//模拟下载数据
- (void)fakeDownload {
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        if (self.needRefresh) {
//            [self.dataSource removeAllObjects];
//            for (NSInteger i = 0 ; i < 10; i ++) {//让数据更多
//                for (NSInteger i = 0; i < self.fakeDatasource.count; i ++) {
//                    LWLayout* layout = [self layoutWithStatusModel:
//                                        [[StatusModel alloc] initWithDict:self.fakeDatasource[i]]
//                                                             index:i];
//                    [self.dataSource addObject:layout];
//                }
//            }
//        }
//        dispatch_sync(dispatch_get_main_queue(), ^{
//            [self refreshComplete];
//        });
//    });
    AFNetworkTwoPackaging *twoPacking = [[AFNetworkTwoPackaging alloc] init];
    [twoPacking getUrl:[NSString stringWithFormat:INFOLISTSHEQU,[StoreageMessage getMessage][2],[StoreageMessage getCommuntityId],@"1000",@"1"] andFinishBlock:^(id getResult) {
        NSLog(@"%@",getResult);
        if (self.needRefresh) {
            [self.dataSource removeAllObjects];
            self.fakeDatasource = getResult[@"datas"];
            NSLog(@"%@",self.fakeDatasource);
            if ([getResult[@"code"] isEqualToString:@"000000"]) {
                for (NSInteger i = 0; i < self.fakeDatasource.count; i ++) {
                    LWLayout* layout = [self layoutWithStatusModel:
                                    [[StatusModel alloc] initWithDict:self.fakeDatasource[i]]
                                                         index:i];
                    [self.dataSource addObject:layout];
                }
            }
                        [self refreshComplete];

        }
    }];
}

//模拟刷新完成
- (void)refreshComplete {
    [self.tableViewHeader refreshingAnimateStop];
    [self.tableView reloadData];
    [UIView animateWithDuration:0.35f animations:^{
        self.tableView.contentInset = UIEdgeInsetsMake(64.0f, 0.0f, 0.0f, 0.0f);
    } completion:^(BOOL finished) {
        self.needRefresh = NO;
    }];
}


- (CellLayout *)layoutWithStatusModel:(StatusModel *)statusModel index:(NSInteger)index {
    CellLayout* layout = [[CellLayout alloc] initWithStatusModel:statusModel
                                                           index:index
                                                   dateFormatter:self.dateFormatter];
    return layout;
}

//- (void)segmentControlIndexChanged:(UISegmentedControl *)segmentedControl {
//    NSInteger idx = segmentedControl.selectedSegmentIndex;
//    switch (idx) {
//        case 0:
//            self.displaysAsynchronously = YES;
//            break;
//        case 1:
//            self.displaysAsynchronously = NO;
//            break;
//    }
//}

#pragma mark - Getter

- (void)setup {
//    self.needRefresh = YES;
    self.displaysAsynchronously = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    
//    UISegmentedControl* segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"异步绘制开",@"异步绘制关"]];
//    segmentedControl.selectedSegmentIndex = 0;
//    [segmentedControl addTarget:self
//                         action:@selector(segmentControlIndexChanged:)
//               forControlEvents:UIControlEventValueChanged];
    self.navigationItem.title = @"社区文化";
}


- (CommentView *)commentView {
    if (_commentView) {
        return _commentView;
    }
    __weak typeof(self) wself = self;
    _commentView = [[CommentView alloc]
                    initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 54.0f)
                    sendBlock:^(NSString *content) {
                        __strong  typeof(wself) swself = wself;
                        swself.postComment.content = content;
                        [swself postCommentWithCommentModel:swself.postComment];
                        
                    }];
    return _commentView;
}

- (UITableView *)tableView {
    if (_tableView) {
        return _tableView;
    }
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    _tableView.tableHeaderView = self.tableViewHeader;
    return _tableView;
}

- (TableViewHeader *)tableViewHeader {
    if (_tableViewHeader) {
        return _tableViewHeader;
    }
    _tableViewHeader =
    [[TableViewHeader alloc] initWithFrame:CGRectMake(0.0f,
                                                      0.0f,
                                                      SCREEN_WIDTH,
                                                      0.0f)];
    return _tableViewHeader;
}

- (NSMutableArray *)dataSource {
    if (_dataSource) {
        return _dataSource;
    }
    _dataSource = [[NSMutableArray alloc] init];
    return _dataSource;
}

- (NSDateFormatter *)dateFormatter {
    static NSDateFormatter* dateFormatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MM月dd日 hh:mm"];
    });
    return dateFormatter;
}

- (CommentModel *)postComment {
    if (_postComment) {
        return _postComment;
    }
    _postComment = [[CommentModel alloc] init];
    return _postComment;
}

- (NSArray *)fakeDatasource {
    if (_fakeDatasource) {
        return _fakeDatasource;
    }
    _fakeDatasource =
    @[@{@"type":@"image",
        @"name":@"型格志style",
        @"avatar":@"http://tp4.sinaimg.cn/5747171147/50/5741401933/0",
        @"content":@"春天卫衣的正确打开方式https://github.com/waynezxcv/Gallop",
        @"date":@"1459668442",
        @"imgs":@[@"http://ww2.sinaimg.cn/mw690/006gWxKPgw1f2jeloxwhnj30fu0g0ta5.jpg",
                  @"http://ww3.sinaimg.cn/mw690/006gWxKPgw1f2jelpn9bdj30b40gkgmh.jpg",
                  @"http://ww1.sinaimg.cn/mw690/006gWxKPgw1f2jelriw1bj30fz0g175g.jpg",
                  @"http://ww3.sinaimg.cn/mw690/006gWxKPgw1f2jelt1kh5j30b10gmt9o.jpg",
                  @"http://ww4.sinaimg.cn/mw690/006gWxKPgw1f2jeluxjcrj30fw0fz0tx.jpg",
                  @"http://ww3.sinaimg.cn/mw690/006gWxKPgw1f2jelzxngwj30b20godgn.jpg",
                  @"http://ww2.sinaimg.cn/mw690/006gWxKPgw1f2jelwmsoej30fx0fywfq.jpg",
                  @"http://ww4.sinaimg.cn/mw690/006gWxKPgw1f2jem32ccrj30xm0sdwjt.jpg",
                  @"http://ww4.sinaimg.cn/mw690/006gWxKPgw1f2jelyhutwj30fz0fxwfr.jpg",],
        @"statusID":@"8",
        @"commentList":@[@{@"from":@"SIZE潮流生活",
                           @"to":@"waynezxcv",
                           @"content":@"nice~使用Gallop。支持异步绘制，让滚动如丝般顺滑。"}],
        @"isLike":@(NO),
        @"likeList":@[@"waynezxcv"]},
      
      @{@"type":@"image",
        @"name":@"SIZE潮流生活",
        @"avatar":@"http://tp2.sinaimg.cn/1829483361/50/5753078359/1",
        @"content":@"近日[心][心][心][心][心][心][face]，adidas Originals😂为经典鞋款Stan Smith打造Primeknit版本，并带来全新的“OG”系列。简约的鞋身采用白色透气Primeknit针织材质制作，再将Stan Smith代表性的绿、红、深蓝三个元年色调融入到鞋舌和后跟点缀，最后搭载上米白色大底来保留其复古风味。据悉该鞋款将在今月登陆全球各大adidas Originals指定店舖。https://github.com/waynezxcv/Gallop <-",
        @"date":@"1459668442",
        @"imgs":@[@"http://ww2.sinaimg.cn/mw690/6d0bb361gw1f2jim2hgxij20lo0egwgc.jpg",
                  @"http://ww3.sinaimg.cn/mw690/6d0bb361gw1f2jim2hsg6j20lo0egwg2.jpg",
                  @"http://ww1.sinaimg.cn/mw690/6d0bb361gw1f2jim2d7nfj20lo0eg40q.jpg",
                  @"http://ww1.sinaimg.cn/mw690/6d0bb361gw1f2jim2hka3j20lo0egdhw.jpg",
                  @"http://ww2.sinaimg.cn/mw690/6d0bb361gw1f2jim2hq61j20lo0eg769.jpg"],
        @"statusID":@"1",
        @"commentList":@[@{@"from":@"SIZE潮流生活",
                           @"to":@"",
                           @"content":@"使用Gallop来快速构建图文混排界面。享受如丝般顺滑的滚动体验。"},
                         @{@"from":@"waynezxcv",
                           @"to":@"SIZE潮流生活",
                           @"content":@"哈哈哈哈"},
                         @{@"from":@"SIZE潮流生活",
                           @"to":@"waynezxcv",
                           @"content":@"nice~使用Gallop。支持异步绘制，让滚动如丝般顺滑。"}],
        @"isLike":@(NO),
        @"likeList":@[@"waynezxcv",@"伊布拉希莫维奇",@"权志龙",@"郜林",@"扎克伯格"]},
      
      @{@"type":@"website",
        @"name":@"Ronaldo",
        @"avatar":@"https://avatars0.githubusercontent.com/u/8408918?v=3&s=460",
        @"content":@"Easy to use yet capable of so much, iOS 9 was engineered to work hand in hand with the advanced technologies built into iPhone.",
        @"date":@"1459668442",
        @"imgs":@[@"http://ww2.sinaimg.cn/mw690/6d0bb361gw1f2jim2hgxij20lo0egwgc.jpg"],
        @"detail":@"LWAlchemy,A fast and lightweight ORM framework for Cocoa and Cocoa Touch.",
        @"statusID":@"1",
        @"commentList":@[@{@"from":@"伊布拉西莫维奇",
                           @"to":@"",
                           @"content":@"使用Gallop来快速构建图文混排界面。享受如丝般顺滑的滚动体验。"}],
        @"isLike":@(NO),
        @"likeList":@[@"waynezxcv",@"Gallop"]},
      
      
      @{@"type":@"image",
        @"name":@"妖妖小精",
        @"avatar":@"http://tp2.sinaimg.cn/2185608961/50/5714822219/0",
        @"content":@"出国留学的儿子为思念自己的家人们寄来一个用自己照片做成的人形立牌",
        @"date":@"1459668442",
        @"imgs":@[@"http://ww3.sinaimg.cn/mw690/8245bf01jw1f2jhh2ohanj20jg0yk418.jpg",
                  @"http://ww4.sinaimg.cn/mw690/8245bf01jw1f2jhh34q9rj20jg0px77y.jpg",
                  @"http://ww1.sinaimg.cn/mw690/8245bf01jw1f2jhh3grfwj20jg0pxn13.jpg",
                  @"http://ww4.sinaimg.cn/mw690/8245bf01jw1f2jhh3ttm6j20jg0el76g.jpg",
                  @"http://ww3.sinaimg.cn/mw690/8245bf01jw1f2jhh43riaj20jg0pxado.jpg",
                  @"http://ww2.sinaimg.cn/mw690/8245bf01jw1f2jhh4mutgj20jg0ly0xt.jpg",
                  @"http://ww3.sinaimg.cn/mw690/8245bf01jw1f2jhh4vc7pj20jg0px41m.jpg",],
        @"statusID":@"2",
        @"commentList":@[@{@"from":@"炉石传说",
                           @"to":@"",
                           @"content":@"#炉石传说#"},
                         @{@"from":@"waynezxcv",
                           @"to":@"SIZE潮流生活",
                           @"content":@"哈哈哈哈"},
                         @{@"from":@"SIZE潮流生活",
                           @"to":@"waynezxcv",
                           @"content":@"nice~使用Gallop。支持异步绘制，让滚动如丝般顺滑。"}],
        @"isLike":@(NO),
        @"likeList":@[@"waynezxcv"]},
      
      @{@"type":@"image",
        @"name":@"Instagram热门",
        @"avatar":@"http://tp4.sinaimg.cn/5074408479/50/5706839595/0",
        @"content":@"Austin Butler & Vanessa Hudgens  想试试看扑到一个一米八几的人怀里是有多舒服[心]",
        @"date":@"1459668442",
        @"imgs":@[@"http://ww1.sinaimg.cn/mw690/005xpHs3gw1f2jg132p3nj309u0goq62.jpg",
                  @"http://ww3.sinaimg.cn/mw690/005xpHs3gw1f2jg14per3j30b40ctmzp.jpg",
                  @"http://ww3.sinaimg.cn/mw690/005xpHs3gw1f2jg14vtjjj30b40b4q5m.jpg",
                  @"http://ww1.sinaimg.cn/mw690/005xpHs3gw1f2jg15amskj30b40f1408.jpg",
                  @"http://ww3.sinaimg.cn/mw690/005xpHs3gw1f2jg16f8vnj30b40g4q4q.jpg",
                  @"http://ww4.sinaimg.cn/mw690/005xpHs3gw1f2jg178dxdj30am0gowgv.jpg",
                  @"http://ww2.sinaimg.cn/mw690/005xpHs3gw1f2jg17c5urj30b40ghjto.jpg"],
        @"statusID":@"3",
        @"commentList":@[@{@"from":@"waynezxcv",
                           @"to":@"SIZE潮流生活",
                           @"content":@"哈哈哈哈"},
                         @{@"from":@"SIZE潮流生活",
                           @"to":@"waynezxcv",
                           @"content":@"nice~使用Gallop。支持异步绘制，让滚动如丝般顺滑。"}],
        @"isLike":@(NO),
        @"likeList":@[@"Tim Cook"]},
      
      
      @{@"type":@"image",
        @"name":@"头条新闻",
        @"avatar":@"http://tp1.sinaimg.cn/1618051664/50/5735009977/0",
        @"content":@"#万象# 【熊孩子！4名小学生铁轨上设障碍物逼停火车】4名小学生打赌，1人认为火车会将石头碾成粉末，其余3人不信，认为只会碾碎，于是他们将道碴摆放在铁轨上。火车司机发现前方不远处的铁轨上，摆放了影响行车安全的障碍物，于是紧急采取制动，列车中途停车13分钟。O4名学生铁轨上设障碍物逼停火车#waynezxcv# nice",
        @"date":@"1459668442",
        @"imgs":@[@"http://ww2.sinaimg.cn/mw690/60718250jw1f2jg46smtmj20go0go77r.jpg"],
        @"statusID":@"4",
        @"commentList":@[@{@"from":@"waynezxcv",
                           @"to":@"SIZE潮流生活",
                           @"content":@"哈哈哈哈"},
                         @{@"from":@"SIZE潮流生活",
                           @"to":@"waynezxcv",
                           @"content":@"nice~使用Gallop。支持异步绘制，让滚动如丝般顺滑。"}],
        @"isLike":@(NO),
        @"likeList":@[@"Tim Cook"]},
      
      
      @{@"type":@"image",
        @"name":@"Kindle中国",
        @"avatar":@"http://tp1.sinaimg.cn/3262223112/50/5684307907/1",
        @"content":@"#只限今日#《简单的逻辑学》作者D.Q.麦克伦尼在书中提出了28种非逻辑思维形式，抛却了逻辑学一贯的刻板理论，转而以轻松的笔触带领我们畅游这个精彩无比的逻辑世界；《蝴蝶梦》我错了，我曾以为付出自己就是爱你。全球公认20世纪伟大的爱情经典，大陆独家合法授权。",
        @"date":@"",
        @"imgs":@[@"http://ww2.sinaimg.cn/mw690/c2719308gw1f2hav54htyj20dj0l00uk.jpg",
                  @"http://ww4.sinaimg.cn/mw690/c2719308gw1f2hav47jn7j20dj0j341h.jpg"],
        @"statusID":@"6",
        @"commentList":@[@{@"from":@"Kindle中国",
                           @"to":@"",
                           @"content":@"统一回复,使用Gallop来快速构建图文混排界面。享受如丝般顺滑的滚动体验。"}],
        @"isLike":@(NO),
        @"likeList":@[@"waynezxcv"]},
      
      
      
      @{@"type":@"image",
        @"name":@"G-SHOCK",
        @"avatar":@"http://tp3.sinaimg.cn/1595142730/50/5691224157/1",
        @"content":@"就算平时没有时间，周末也要带着G-SHOCK到户外走走，感受大自然的满满正能量！",
        @"date":@"1459668442",
        @"imgs":@[@"http://ww2.sinaimg.cn/mw690/5f13f24ajw1f2hc1r6j47j20dc0dc0t4.jpg"],
        @"statusID":@"7",
        @"commentList":@[@{@"from":@"SIZE潮流生活",
                           @"to":@"",
                           @"content":@"使用Gallop来快速构建图文混排界面。享受如丝般顺滑的滚动体验。"},
                         @{@"from":@"waynezxcv",
                           @"to":@"SIZE潮流生活",
                           @"content":@"哈哈哈哈"},
                         @{@"from":@"SIZE潮流生活",
                           @"to":@"waynezxcv",
                           @"content":@"nice~使用Gallop。支持异步绘制，让滚动如丝般顺滑。"}],
        @"isLike":@(NO),
        @"likeList":@[@"waynezxcv"]},
      
      
      
      
      
      @{@"type":@"image",
        @"name":@"数字尾巴",
        @"avatar":@"http://tp1.sinaimg.cn/1726544024/50/5630520790/1",
        @"content":@"外媒 AndroidAuthority 日前曝光诺基亚首款回归作品 NOKIA A1 的渲染图，手机的外形很 N 记，边框控制的不错。这是一款纯正的 Android 机型，传闻手机将采用 5.5 英寸 1080P 屏幕，搭载骁龙 652，Android 6.0 系统，并使用了诺基亚自家的 Z 启动器，不过具体发表的时间还是未知。尾巴们你会期待吗？",
        @"date":@"1459668442",
        @"imgs":@[@"http://ww3.sinaimg.cn/mw690/66e8f898gw1f2jck6jnckj20go0fwdhb.jpg"],
        @"statusID":@"9",
        @"commentList":@[@{@"from":@"SIZE潮流生活",
                           @"to":@"",
                           @"content":@"使用Gallop来快速构建图文混排界面。享受如丝般顺滑的滚动体验。"},
                         @{@"from":@"waynezxcv",
                           @"to":@"SIZE潮流生活",
                           @"content":@"哈哈哈哈"},
                         @{@"from":@"SIZE潮流生活",
                           @"to":@"waynezxcv",
                           @"content":@"nice~使用Gallop。支持异步绘制，让滚动如丝般顺滑。"}],
        @"isLike":@(NO),
        @"likeList":@[@"waynezxcv"]},
      
      
      @{@"type":@"image",
        @"name":@"欧美街拍XOXO",
        @"avatar":@"http://tp4.sinaimg.cn/1708004923/50/1283204657/0",
        @"content":@"3.31～4.2 肯豆",
        @"date":@"1459668442",
        @"imgs":@[@"http://ww2.sinaimg.cn/mw690/65ce163bjw1f2jdkd2hgjj20cj0gota8.jpg",
                  @"http://ww1.sinaimg.cn/mw690/65ce163bjw1f2jdkjdm96j20bt0gota9.jpg",
                  @"http://ww2.sinaimg.cn/mw690/65ce163bjw1f2jdkvwepij20go0clgnd.jpg",
                  @"http://ww4.sinaimg.cn/mw690/65ce163bjw1f2jdl2ao77j20ci0gojsw.jpg",],
        @"statusID":@"10",
        @"commentList":@[@{@"from":@"waynezxcv",
                           @"to":@"SIZE潮流生活",
                           @"content":@"哈哈哈哈"}],
        @"isLike":@(NO),
        @"likeList":@[@"waynezxcv"]},
      ];
    return _fakeDatasource;
}

@end
