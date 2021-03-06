//
//  CleanerPublishViewController.m
//  360du
//
//  Created by 利美 on 16/4/21.
//  Copyright © 2016年 wangjian. All rights reserved.
//

#import "CleanerPublishViewController.h"
#import "XYTextView.h"
#import "JSDropDownMenu.h"
#import "AFNetworkTwoPackaging.h"
#import "PopViewLikeQQView.h"
#import "MBProgressHUD.h"
#import "AddrModel.h"
#import "hy_DataDownloadTools.h"
#import "CleanerViewController.h"
#import "CleanerPublishTwoTableViewController.h"
#import "AddrFirstTableViewController.h"
#import "AddrSecondTableViewController.h"
#import "StoreageMessage.h"
#import "SendMessage.h"
#import "HeaderContent.h"
#import "ImagePickerChooseView.h"
#import "AGImagePickerController.h"
#import "ShowImageViewController.h"
#import "NFPickerView.h"
#import "NSString+URLEncoding.h"
@interface CleanerPublishViewController ()<popString>
@property (nonatomic ,weak) UIButton *addPictureButton;

@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UITextField *NameText;
@property (weak, nonatomic) IBOutlet UITextField *adrrText;
@property (weak, nonatomic) IBOutlet UITextField *telText;
@property (weak, nonatomic) IBOutlet UIView *lView;

@property (weak, nonatomic) IBOutlet UIView *teSeTextView;
@property (weak, nonatomic) IBOutlet UIView *discrpView;
@property (weak, nonatomic) IBOutlet UIView *tView;
@property (weak, nonatomic) IBOutlet UIView *mView;
@property (weak, nonatomic) IBOutlet UIView *leiXView;
@property (weak, nonatomic) IBOutlet UIView *addreView;
@property (weak, nonatomic) IBOutlet UIButton *leiXButton;
@property (weak, nonatomic) IBOutlet UIScrollView *mainScro;

@property (weak, nonatomic) IBOutlet UIButton *addrButton;

@property(strong, nonatomic)XYTextView * textView;
@property(strong, nonatomic)XYTextView * textView2;
@property(strong, nonatomic)AFHTTPSessionManager *rom;
@property(nonatomic,strong)MBProgressHUD *hudProgress;
@property (nonatomic ,strong) NSMutableArray *imagePickerArray;
@property (nonatomic ,weak) ImagePickerChooseView *IPCView;
@property (nonatomic ,strong) AGImagePickerController *imagePicker;
@end

@implementation CleanerPublishViewController

-(CLGeocoder *)geocoder
{
    if (_geocoder==nil) {
        _geocoder=[[CLGeocoder alloc]init];
    }
    return _geocoder;
}


-(void)viewWillAppear:(BOOL)animated{
    [self initHeaderView];

    if ([SendMessage shareInstance].singleValue) {
        //    if (!self.chooseName) {
        self.chooseName = [SendMessage shareInstance].singleValue;
        self.chooseNameID = [SendMessage shareInstance].singleCode;
        [self.addrButton setTitle:_chooseName forState:UIControlStateNormal];
    }
    if (self.addrButton.titleLabel.text == nil) {
        [self.addrButton setTitle:@"请选择区域" forState:UIControlStateNormal];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [SendMessage shareInstance].singleValue = nil;
    [SendMessage shareInstance].singleCode = nil;
//     [self.addrButton setTitle:@"请选择区域" forState:UIControlStateNormal];

    
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"landi.png"] forBarMetrics:UIBarMetricsDefault];
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(WIDTH_CONTROLLER - 32 , (44 - 2) / 2, 25, 25);
    [leftBtn setImage:[UIImage imageNamed:@"fanhuijian2222.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(setBack) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setImageEdgeInsets:UIEdgeInsetsMake(6, 5, 6, 5)];
    UIBarButtonItem *leftSecondItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftSecondItem;
    // Do any additional setup after loading the view.
    
    
    _textView = [[XYTextView alloc]initWithFrame:CGRectMake(self.tView.frame.origin.x, self.tView.frame.origin.y, WIDTH_VIEW - self.tView.frame.origin.x - 8, self.tView.frame.size.height)];
    [_textView.countNumLabel removeFromSuperview];
    _textView.backgroundColor = [UIColor whiteColor];
    _textView.font = [UIFont systemFontOfSize:14.f];
    _textView.textColor = [UIColor blackColor];
    _textView.textAlignment = NSTextAlignmentLeft;
    [self.textView setPlaceholder:@"服务起价、理念等展示您特色或优势的信息"];
//    self.textView setPlaceholderColor:[UIColor ]
    [self.teSeTextView addSubview:_textView];
    
    
    _textView2 = [[XYTextView alloc]initWithFrame:CGRectMake(self.mView.frame.origin.x, self.mView.frame.origin.y, WIDTH_VIEW - self.mView.frame.origin.x - 8, self.mView.frame.size.height)];
    _textView2.backgroundColor = [UIColor whiteColor];
    _textView2.font = [UIFont systemFontOfSize:14.f];
    _textView2.textColor = [UIColor blackColor];
    _textView2.textAlignment = NSTextAlignmentLeft;
    [self.textView2 setPlaceholder:@"店铺的主营项目、基本报价、当前规模和经营理念等，以便更多的客户了解您的店铺，增强点击效果！"];
    [self.discrpView addSubview:_textView2];
//    [self DorpDownMenu];
//    [self.addrButton addTarget:self action:@selector(leiXAction) forControlEvents:UIControlEventTouchUpInside];
//    [self.addrButton addTarget:self action:@selector(addressAction) forControlEvents:UIControlEventTouchUpInside];
//    if (!self.chooseName) {
//        self.chooseName = @"请选择区域";
//    [self.addrButton setTitle:@"请选择区域" forState:UIControlStateNormal];
//    }
//    [self.addrButton setTitle:self.chooseName forState:UIControlStateNormal];
    
//    if (!self.type) {
//        self.type = @"请选择服务类型";
//    }
//    [self.leiXButton setTitle:@"请选择服务类型" forState:UIControlStateNormal];




    
}

//-(void) sendAddr:(NSString *)string andCode:(NSString *)code{
//    [self.addrButton setTitle:string forState:UIControlStateNormal];
//    self.chooseName = string;
//    self.chooseNameID = code;
//}

- (IBAction)typeAction:(UIButton *)sender {
    CleanerPublishTwoTableViewController *two = [[CleanerPublishTwoTableViewController alloc]init];
//    UIStoryboard *cleanerSB = [UIStoryboard storyboardWithName:@"Cleaner" bundle:nil];
//    
//    CleanerPublishTwoTableViewController *two = [cleanerSB instantiateViewControllerWithIdentifier:@"publishTwo"];
//    two.delegate = self;
    two.delegate = self;
    
    

    [self.navigationController pushViewController:two animated:YES];
}
- (IBAction)addrAction:(UIButton *)sender {
    AddrFirstTableViewController *addrf = [[AddrFirstTableViewController alloc]init];
    addrf.sendAddrDelegate = self;
    [self.navigationController pushViewController:addrf animated:YES];
    
}

//选择类型传回的code
-(void)popString:(NSString *)String andCode:(NSString *)code{
    [self.leiXButton setTitle:String forState:UIControlStateNormal];
    self.type = String;
    self.typeID = code;
}









-(void)setBack{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)publishOKButton:(UIButton *)sender {
    if (!_NameText.text.length) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入店铺名！" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
        [alertView show];
        return;
    }else if (!_adrrText.text.length){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入您的详细地址！" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
        [alertView show];
        return;
    }else if (!_telText.text.length){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入您的联系方式！" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
        [alertView show];
        return;
    }else if (!_textView.text.length){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入店铺的服务特色！" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
        [alertView show];
        return;
    }else if (!_chooseName.length){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请选择服务区域！" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
        [alertView show];
        return;
    }else if (!_type.length){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请选择类型！" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
        [alertView show];
        return;
    }else{
        //小区id xqid
//        NSString *urlToServer = [NSString stringWithFormat:CLEANERPUBLISH111,[StoreageMessage getMessage][2],[StoreageMessage getCommuntityId],_NameText.text,@"5",_chooseNameID,_typeID,_telText.text,_adrrText.text,_textView.text,_textView2.text];
//        NSLog(@"%@",urlToServer);
        [self pushToServer];
    }
}


#define NUMBERS @"0123456789."//只允许输入数字或者点号



- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSCharacterSet *cs;
    cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    BOOL basicTest = [string isEqualToString:filtered];
    if(!basicTest) {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"请输入数字或点"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        return NO;
    }
    return YES;
}

-(BOOL)jugeTel:(NSString *)telPhone{
    //手机号以13， 15，18开头，八个 \d 数字字符
    // NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSString *phoneRegex = @"^((13[0-9])|(17[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:telPhone];
}

-(void)pushToServer{
    
    
    NSString *address = [NSString stringWithFormat:@"%@%@",_addrButton.titleLabel.text,_adrrText.text];
    NSLog(@"%@",address);
    if (address.length==0) {return;}
    //2.开始地理编码
    //说明：调用下面的方法开始编码，不管编码是成功还是失败都会调用block中的方法
    [self.geocoder geocodeAddressString:address completionHandler:^(NSArray *placemarks, NSError *error) {
        //如果有错误信息，或者是数组中获取的地名元素数量为0，那么说明没有找到
        if (error || placemarks.count==0) {
            //                    self.detailAddressLabel.text=@"你输入的地址没找到，可能在月球上";
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您输入的详细地址无法查找" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
            [alertView show];

        }else   //  编码成功，找到了具体的位置信息
        {
            //打印查看找到的所有的位置信息
            /*
             61                     name:名称
             62                     locality:城市
             63                     country:国家
             64                     postalCode:邮政编码
             65                  */
            for (CLPlacemark *placemark in placemarks) {
//                NSLog(@"name=%@ locality=%@ country=%@ postalCode=%@",placemark.name,placemark.locality,placemark.country,placemark.postalCode);
            }
            
            //取出获取的地理信息数组中的第一个显示在界面上
            CLPlacemark *firstPlacemark=[placemarks firstObject];
            //详细地址名称
            //                    self.detailAddressLabel.text=firstPlacemark.name;
            //纬度
            CLLocationDegrees latitude=firstPlacemark.location.coordinate.latitude;
            //经度
            CLLocationDegrees longitude=firstPlacemark.location.coordinate.longitude;
            //                    self.latitudeLabel.text=[NSString stringWithFormat:@"%.2f",latitude];
            //                    self.longitudeLabel.text=[NSString stringWithFormat:@"%.2f",longitude];
            self.latitude = [NSString stringWithFormat:@"%f",latitude];
            self.longitude = [NSString stringWithFormat:@"%f",longitude];
//            NSLog(@"121212%@,%@",_latitude,_longitude);









    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //申明返回的结果是json类型
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //申明请求的数据是json类型
//    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    //如果报接受类型不一致请替换一致text/html或别的
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/json",@"text/html",@"application/json",@"text/plain",nil];
    //传入的参数  十八里店横街子
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"memberId":[StoreageMessage getMessage][2],@"xqids":[StoreageMessage getCommuntityId],@"shopname":[_NameText.text urlEncodeString],@"codename":@"5",@"qycode":[_chooseNameID urlEncodeString],@"scid":[_typeID urlEncodeString],@"mobile":[_telText.text urlEncodeString] ,@"companyaddress":[_adrrText.text urlEncodeString],@"serviceFeatures":[_textView.text urlEncodeString],@"dldesc":[_textView2.text urlEncodeString],@"didLocation":[NSString stringWithFormat:@"%@,%@",_longitude,_latitude]};
            NSLog(@"%@",[NSString stringWithFormat:@"%@,%@",_longitude,_latitude]);
    //你的接口地址
            NSLog(@"%@",dic);
    NSString *url = [NSString stringWithFormat:CLEANERPUBLISH];
    [manager POST:url parameters:dic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"rerere%@",responseObject);
        [StoreageMessage getErrorMessage:@"NULL" fromUrl:url];

        if ([responseObject[@"code"] isEqualToString:@"000000"]) {
            [self sendImageDataToSeverWithShopId:responseObject[@"shopId"]];
            
        }
//        NSLog(@"s: %@", responseObject[@"message"]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error: %@", error);
    }];

        }
    }];
}



//租房发布图片上传
-(void)sendImageDataToSeverWithShopId:(NSString *)shopId{
    NSMutableDictionary *dicmu = [[NSMutableDictionary alloc]initWithCapacity:0];
    NSMutableArray *arrayImage = [NSMutableArray arrayWithCapacity:0];
    
    for (NSInteger i = 0; i < self.imagePickerArray.count; i ++) {
        if ([self.imagePickerArray[i] isKindOfClass:[UIImage class]]) {
            [arrayImage addObject:self.imagePickerArray[i]];
            [dicmu setObject:self.imagePickerArray[i] forKey:[NSString stringWithFormat:@"%@",self.imagePickerArray[i]]];
        }
        if ([self.imagePickerArray[i] isKindOfClass:[ALAsset class]]){
            
            ALAssetRepresentation *assetRep = [self.imagePickerArray[i] defaultRepresentation];
            CGImageRef imgRef = [assetRep fullResolutionImage];
            UIImage *img = [UIImage imageWithCGImage:imgRef
                                               scale:assetRep.scale
                                         orientation:(UIImageOrientation)assetRep.orientation];
            //            NSLog(@"%@",img);
            [arrayImage addObject:img];
            //        [arrayImage writeToFile:SendImageFromFile atomically:YES];
            [dicmu setObject:img forKey:[NSString stringWithFormat:@"%@",self.imagePickerArray[i]]];
        }
    }
    
//    NSLog(@"%@--%@",self.houseId,dicmu);
    [self PostImagesToServer:IMAGEUPDATEBAOJIE dicPostParams:@{@"shopId":shopId} dicImages:dicmu];
    
    
}


-(void)PostImagesToServer:(NSString *) strUrl dicPostParams:(NSMutableDictionary *)params dicImages:(NSMutableDictionary *) dicImages{
    NSString * res;
    
    //分界线的标识符
    NSString *TWITTERFON_FORM_BOUNDARY = @"AaB03x";
    //根据url初始化request
    //NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:strUrl] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10];
    
    NSURL *url = [NSURL URLWithString:strUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //分界线 --AaB03x
    NSString *MPboundary=[[NSString alloc]initWithFormat:@"--%@",TWITTERFON_FORM_BOUNDARY];
    //结束符 AaB03x--
    NSString *endMPboundary=[[NSString alloc]initWithFormat:@"%@--",MPboundary];
    //要上传的图片
    UIImage *image;//=[params objectForKey:@"pic"];
    //得到图片的data
    //NSData* data = UIImagePNGRepresentation(image);
    //http body的字符串
    NSMutableString *body=[[NSMutableString alloc]init];
    //参数的集合的所有key的集合
    NSArray *keys= [params allKeys];
    
    //遍历keys
    for(int i=0;i<[keys count];i++) {
        //得到当前key
        NSString *key=[keys objectAtIndex:i];
        //如果key不是pic，说明value是字符类型，比如name：Boris
        //if(![key isEqualToString:@"pic"]) {
        //添加分界线，换行
        [body appendFormat:@"%@\r\n",MPboundary];
        //添加字段名称，换2行
        [body appendFormat:@"Content-Disposition: form-data; name=%@\r\n\r\n",key];
        //[body appendString:@"Content-Transfer-Encoding: 8bit"];
        //添加字段的值
        [body appendFormat:@"%@\r\n",[params objectForKey:key]];
        //}
    }
    ////添加分界线，换行
    //[body appendFormat:@"%@\r\n",MPboundary];
    
    //声明myRequestData，用来放入http body
    NSMutableData *myRequestData=[NSMutableData data];
    //将body字符串转化为UTF8格式的二进制
    [myRequestData appendData:[body dataUsingEncoding:NSUTF8StringEncoding]];
    
    //循环加入上传图片
    keys = [dicImages allKeys];
    for(int i = 0; i< [keys count] ; i++){
        //要上传的图片
        image = [dicImages objectForKey:[keys objectAtIndex:i ]];
        //得到图片的data
        NSData* data =  UIImageJPEGRepresentation(image, 0.0);
        NSMutableString *imgbody = [[NSMutableString alloc] init];
        //此处循环添加图片文件
        //添加图片信息字段
        //声明pic字段，文件名为boris.png
        
        
        ////添加分界线，换行
        [imgbody appendFormat:@"%@\r\n",MPboundary];
        [imgbody appendFormat:@"Content-Disposition: form-data; name=File%d; filename=%@.jpg\r\n", i, [keys objectAtIndex:i]];
        //声明上传文件的格式
        [imgbody appendFormat:@"Content-Type: application/octet-stream; charset=utf-8\r\n\r\n"];
        
        //        NSLog(@"上传的图片：%d  %@", i, [keys objectAtIndex:i]);
        
        //将body字符串转化为UTF8格式的二进制
        //[myRequestData appendData:[body dataUsingEncoding:NSUTF8StringEncoding]];
        [myRequestData appendData:[imgbody dataUsingEncoding:NSUTF8StringEncoding]];
        //将image的data加入
        [myRequestData appendData:data];
        [myRequestData appendData:[ @"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    }
    //声明结束符：--AaB03x--
    NSString *end=[[NSString alloc]initWithFormat:@"%@\r\n",endMPboundary];
    //加入结束符--AaB03x--
    [myRequestData appendData:[end dataUsingEncoding:NSUTF8StringEncoding]];
    //设置HTTPHeader中Content-Type的值
    NSString *content=[[NSString alloc]initWithFormat:@"multipart/form-data; boundary=%@",TWITTERFON_FORM_BOUNDARY];
    //设置HTTPHeader
    [request setValue:content forHTTPHeaderField:@"Content-Type"];
    //设置Content-Length
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[myRequestData length]] forHTTPHeaderField:@"Content-Length"];
    //设置http body
    [request setHTTPBody:myRequestData];
    //http method
    [request setHTTPMethod:@"POST"];
    //    NSLog(@"%@",request);
    //建立连接，设置代理
    //NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    //设置接受response的data
    NSData *mResponseData;
    NSError *err = nil;
    mResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&err];
    
    if(mResponseData == nil){
        //        NSLog(@"err code : %@", [err localizedDescription]);
    }
    res = [[NSString alloc] initWithData:mResponseData encoding:NSUTF8StringEncoding];
    //    resid = mResponseData;
        NSLog(@"服务器返回：%@", res);
    //    if (![resid[@"code"] isEqualToString:@"000000"]) {
    //        [self.view makeToast:@"上传失败请重新上传"];
    //    }
    //    NSLog(@"%@",res);
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"发布成功！" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
    
    [alertView show];
    //            UIStoryboard *cleanerSB = [UIStoryboard storyboardWithName:@"Cleaner" bundle:nil];
    //            CleanerViewController *cleanerViewController = [cleanerSB instantiateViewControllerWithIdentifier:@"cleaner"];
    [self.navigationController popViewControllerAnimated:YES];
}


//- (NSInteger)numberOfColumnsInMenu:(JSDropDownMenu *)menu {
//    if (_menu == menu) {
//        return 1;
//    }
//    
//    return 2;
//}
//
//-(BOOL)displayByCollectionViewInColumn:(NSInteger)column{
//    
//        if (column==2) {
//
//            return YES;
//        }
//
//    return NO;
//}
//
//-(BOOL)haveRightTableViewInColumn:(NSInteger)column{
//    
//    if (column==0) {
//        return YES;
//    }
//    return NO;
//}
//
//-(CGFloat)widthRatioOfLeftColumn:(NSInteger)column{
//    
//    if (column==0) {
//        return 0.8;
//    }else if(column == 1){
//        return 0.5;
//    }
//    
//    return 1;
//}
//
//-(NSInteger)currentLeftSelectedRow:(NSInteger)column{
//    
//    if (column==0) {
//        
//        return _currentData2Index;
//        
//    }
//    if (column==1) {
//        
//        return _currentData3Index;
//    }
//    
//    return 0;
//}
////制作下拉tableView
//- (NSInteger)menu:(JSDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column leftOrRight:(NSInteger)leftOrRight leftRow:(NSInteger)leftRow{
//    
//    if (column==0) {
//        if (leftOrRight==0) {
//
//            return _data1.count;
//        } else{
//
//            NSDictionary *menuDic = [_data1 objectAtIndex:leftRow];
//            return [[menuDic objectForKey:@"data"] count];
//        }
//        return _data2.count;
//    } else if (column==1){
//        
//        return _data2.count;
//        
//    } else if (column==2){
//        
//        return _data3.count;
//    }
//    
//    return 0;
//}
//显示数据
//- (NSString *)menu:(JSDropDownMenu *)menu titleForColumn:(NSInteger)column{
//    
//    switch (column) {
//        case 0: return [[_data1[0] objectForKey:@"data"] objectAtIndex:0];
//        case 0 : return _data2[0];
//            break;
//        case 1: return _data2[0];
//            break;
//        case 2: return _data3[0];
//            break;
//        default:
//            return nil;
//            break;
//    }
//}
//点击后显示
//- (NSString *)menu:(JSDropDownMenu *)menu titleForRowAtIndexPath:(JSIndexPath *)indexPath {
//    
//    if (indexPath.column==0) {
//        if (indexPath.leftOrRight==0) {
//            NSDictionary *menuDic = [_data1 objectAtIndex:indexPath.row];
//            return [menuDic objectForKey:@"title"];
//        } else{
////            NSInteger leftRow = indexPath.leftRow;
////            NSDictionary *menuDic = [_data1 objectAtIndex:leftRow];
////            return [[menuDic objectForKey:@"data"] objectAtIndex:indexPath.row];
////        }
//        return _data2[indexPath.row];
//    } else if (indexPath.column==1) {
//        
//        return _data2[indexPath.row];
//        
//    } else {
//        
//        return _data3[indexPath.row];
//    }
//}
//
//
//
////点击
//- (void)menu:(JSDropDownMenu *)menu didSelectRowAtIndexPath:(JSIndexPath *)indexPath {
//    
//    if (indexPath.column == 0) {
//        
////        if(indexPath.leftOrRight==0){
////            
////            _currentData1Index = indexPath.row;
////            
////            return;
////        }
//        _currentData2Index = indexPath.row;
//
//        
//    } else if(indexPath.column == 1){
//        
//        _currentData2Index = indexPath.row;
////        NSLog(@"%ld",(long)indexPath.row);
//        
//    } else{
//        
//        _currentData3Index = indexPath.row;
//    }
//}
-(NSMutableArray *)imagePickerArray
{
    if (!_imagePickerArray) {
        _imagePickerArray = [[NSMutableArray alloc]init];
    }
    return _imagePickerArray;
}

/**
 *  社区生活图片选择
 *
 *  @param padding <#padding description#>
 *
 *  @return <#return value description#>
 */
#define pictureHW (screenWidth - 5*padding)/4
#define MaxImageCount 8
#define deleImageWH 25 // 删除按钮的宽高
-(void)initHeaderView
{
    [self.photoView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    //    UIView *headView = [[UIView alloc]initWithFrame:CGRectZero];
    NSInteger imageCount = [self.imagePickerArray count];
    for (NSInteger i = 0; i < imageCount; i++) {
        UIImageView *pictureImageView = [[UIImageView alloc]initWithFrame:CGRectMake(padding + (i%4)*(pictureHW+padding),padding +(i/4)*(pictureHW+padding), pictureHW, pictureHW)];
        //用作放大图片
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImageView:)];
        [pictureImageView addGestureRecognizer:tap];
        
        //添加删除按钮
        UIButton *dele = [UIButton buttonWithType:UIButtonTypeCustom];
        dele.frame = CGRectMake(pictureHW - deleImageWH + 5, -10 , deleImageWH, deleImageWH);
        [dele setImage:[UIImage imageNamed:@"deletePhoto"] forState:UIControlStateNormal];
        [dele addTarget:self action:@selector(deletePic:) forControlEvents:UIControlEventTouchUpInside];
        [pictureImageView addSubview:dele];
        pictureImageView.tag = imageTag + i;
        pictureImageView.userInteractionEnabled = YES;
        if ([self.imagePickerArray[i] isKindOfClass:[ALAsset class]]) {
            pictureImageView.image = [UIImage imageWithCGImage:((ALAsset *)[self.imagePickerArray objectAtIndex:i]).thumbnail];
        }else{
            pictureImageView.image = self.imagePickerArray[i];
        }
        [self.photoView addSubview:pictureImageView];
    }
    if (imageCount < MaxImageCount) {
        UIButton *addPictureButton = [[UIButton alloc]initWithFrame:CGRectMake(padding + (imageCount%4)*(pictureHW+padding), padding +(imageCount/4)*(pictureHW+padding), pictureHW, pictureHW)];
        [addPictureButton setBackgroundImage:[UIImage imageNamed:@"add_photo.png"] forState:UIControlStateNormal];
        [addPictureButton addTarget:self action:@selector(addPicture) forControlEvents:UIControlEventTouchUpInside];
        [self.photoView addSubview:addPictureButton];
        self.addPictureButton = addPictureButton;
    }
    
    self.photoHieght.constant = 10+ (10 + pictureHW)*([self.imagePickerArray count]/4 + 1 );
    self.DianPuNameToTopConstraint.constant = 10+ (10 + pictureHW)*([self.imagePickerArray count]/4 + 1 ) + 1;
}


-(void)addPicture{
    
    [self initImagePickerChooseView];
}

#pragma mark - gesture method
-(void)tapImageView:(UITapGestureRecognizer *)tap
{
    NSLog(@"%@--%ld",self.imagePickerArray,tap.view.tag);
    ShowImageViewController *vc = [[ShowImageViewController alloc] init];
    vc.clickTag = tap.view.tag;
    vc.imageViews = self.imagePickerArray;
    [self.navigationController pushViewController:vc animated:YES];
}



// 删除图片
-(void)deletePic:(UIButton *)btn
{
    if ([(UIButton *)btn.superview isKindOfClass:[UIImageView class]]) {
        UIImageView *imageView = (UIImageView *)btn.superview;
        
        [self.imagePickerArray removeObjectAtIndex:(imageView.tag - imageTag)];
        [imageView removeFromSuperview];
    }
    [self initHeaderView];
}

#define IPCViewHeight 120
-(void)initImagePickerChooseView
{
    ImagePickerChooseView *IPCView = [[ImagePickerChooseView alloc]initWithFrame:CGRectMake(0, screenHeight, screenWidth, IPCViewHeight) andAboveView:self.view];
    [IPCView setImagePickerBlock:^{
        self.imagePicker = [[AGImagePickerController alloc] initWithFailureBlock:^(NSError *error) {
            
            if (error == nil)
            {
                [self dismissViewControllerAnimated:YES completion:^{}];
                [self.IPCView disappear];
            } else
            {
                //                NSLog(@"Error: %@", error);
                
                // Wait for the view controller to show first and hide it after that
                double delayInSeconds = 0.5;
                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
                dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                    [self dismissViewControllerAnimated:YES completion:^{}];
                });
            }
            
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
            
        } andSuccessBlock:^(NSArray *info) {
            [self.imagePickerArray addObjectsFromArray:info];
            [self dismissViewControllerAnimated:YES completion:^{}];
            [self.IPCView disappear];
            [self initHeaderView];
            
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
        }];
        
        self.imagePicker.maximumNumberOfPhotosToBeSelected = 9 - [self.imagePickerArray count];
        [self presentViewController:self.imagePicker animated:YES completion:^{}];
    }];
    
    [IPCView setImagePickerblock1:^{
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:imagePickerController animated:YES completion:^{}];
        
    }];
    
    
    
    
    
    
    [UIView animateWithDuration:0.25f animations:^{
        IPCView.frame = CGRectMake(0, screenHeight - IPCViewHeight-64, screenWidth, IPCViewHeight);
    } completion:^(BOOL finished) {
    }];
    [self.view addSubview:IPCView];
    self.IPCView = IPCView;
    [self.IPCView addImagePickerChooseView];
}



- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self saveImage:image withName:@"currentImage.png"];
    
    
    
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"currentImage.png"];
    
    
    UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
    //    NSLog(@"%@",savedImage);
    UIImage *newImage = [self image:savedImage byScalingToSize:CGSizeMake(savedImage.size.width/4, savedImage.size.height/4)];
    [self.imagePickerArray addObject:newImage];
    [self dismissViewControllerAnimated:YES completion:^{}];
    [self.IPCView disappear];
    [self initHeaderView];
    
}


-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}

- (UIImage *)image:(UIImage*)image byScalingToSize:(CGSize)targetSize {
    UIImage *sourceImage = image;
    UIImage *newImage = nil;
    
    UIGraphicsBeginImageContext(targetSize);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = CGPointZero;
    thumbnailRect.size.width  = targetSize.width;
    thumbnailRect.size.height = targetSize.height;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage ;
}


//取到的图片保存到沙盒
- (void) saveImage:(UIImage *)currentImage withName:(NSString *)imageName
{
    
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.5);
    
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    
    [imageData writeToFile:fullPath atomically:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

