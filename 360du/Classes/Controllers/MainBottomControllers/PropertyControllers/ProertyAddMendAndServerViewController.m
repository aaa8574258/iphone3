//
//  ProertyAddMendAndServerViewController.m
//  360du
//
//  Created by linghang on 15/7/21.
//  Copyright (c) 2015年 wangjian. All rights reserved.
//

#import "ProertyAddMendAndServerViewController.h"
#import "FileOperation.h"
#import <AVFoundation/AVFoundation.h>
#import <CoreMedia/CoreMedia.h>
#import "TranlateTime.h"
#import "lame.h"
#import "NSString+URLEncoding.h"
#import "CommitOrderViewController.h"
#import "StoreageMessage.h"
#import "AddressModel.h"
#import "IQKeyboardManager.h"
#import "UITableView+Improve.h"
#import "UIImage+ReSize.h"
#import "HeaderContent.h"
#import "ImagePickerChooseView.h"
#import "AGImagePickerController.h"
#import "ShowImageViewController.h"
#import "NFPickerView.h"
#import "UIView+Toast.h"
#import "ProertyMendAndServerListViewController.h"
#import "ProertyMendSeverViewController.h"
@interface ProertyAddMendAndServerViewController ()<UIWebViewDelegate,UIImagePickerControllerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,AVAudioRecorderDelegate,UIGestureRecognizerDelegate,sendNewAddress,UITextViewDelegate,NFPickerViewDelegete>
@property(nonatomic,weak)UITextField *textField;
@property(nonatomic,weak)UIDatePicker *datePicker;
@property(nonatomic,assign)BOOL isDateBool;
@property(nonatomic,copy)NSString *courseId;
@property(nonatomic,copy)NSString *addressStr;
@property(nonatomic,copy)NSString *uuid;
@property(nonatomic,strong)NSMutableArray *addressArr;
@property(nonatomic,weak)UILabel *addresslab;//地址Lab
@property(nonatomic,copy)NSString *addressId;//地址ID
@property(nonatomic,weak)UIButton *commitBtn;//提交按钮

@property (nonatomic ,strong) NSMutableArray *imagePickerArray;
@property (strong, nonatomic) UIView *photoView;
@property (nonatomic ,weak) UIButton *addPictureButton;
@property (nonatomic ,weak) ImagePickerChooseView *IPCView;
@property (nonatomic ,strong) AGImagePickerController *imagePicker;
@property (nonatomic ,strong) UILabel *labTime;
@property (nonatomic ,strong) UITextView *textView;
@property (nonatomic ,copy) NSString *textViewText;
//下边是录音、图像、视频的所需要的
@property(nonatomic,weak)UIWebView *webView;
@property(nonatomic,copy)NSString *htmlStr;
@property(nonatomic,copy)NSString *cachePath;
@property(nonatomic,copy)NSString *documentPath;//保存录制视频，在Cache不能保存
@property(nonatomic,assign)NSInteger allNum;//一次性提交多少个
@property(nonatomic,strong)NSMutableArray *numArr;
@property(nonatomic,assign)NSInteger tempNum;//临时的数
@property(nonatomic,strong)NSTimer *timerNum;
@property(nonatomic,strong)NSMutableArray *saveFileArr;//保存返回的URL
@property(nonatomic,strong)NSMutableArray *saveThumbFileArr;//保存缩小图片返回的URL
@property(nonatomic,strong)NSMutableArray *saveFidArr;//保存fid
@property(nonatomic,weak)UILabel *titleLable;//笔记标题
@property(nonatomic,strong)NSMutableArray *saveImageAndVideoAndAudioUrl;//保存返回的URL和文件名称
@property(nonatomic,copy)NSString *noteId;
@property(nonatomic,copy)NSString *contentNote;
//下边是相册、照相、录音、视频
//录音
@property(nonatomic,strong)AVAudioRecorder *audioRecorder;//音频录音机
@property(nonatomic,strong)AVAudioPlayer *audioPlayer;//音频播放器，用于播放音频文件
@property(nonatomic,strong)UIProgressView *audioPower;//音频波动
@property(nonatomic,strong)UIButton *record;//开始录音
@property(nonatomic,strong)NSTimer *timer;//录音声波监控
@property(nonatomic,strong)NSURL *recordUrl;
@property(nonatomic,assign)BOOL recordBtnState;
@property(nonatomic,copy)NSString *recordStr;

//录制视频
@property(nonatomic,strong)NSURL *videoURL;
@property(nonatomic,assign)NSInteger imageBtnState;
@property(nonatomic,strong)NSString *mp4Quality;
@property(nonatomic,copy)NSString *videoString;
@property(nonatomic,copy)NSString *htmlSourceString;
//voiceLable
@property(nonatomic,weak)UILabel *voiceLable;
//提示录音文字
@property(nonatomic,strong)UILabel *recordLable;
@property(nonatomic,strong)UIView *messageView;
@property(nonatomic,strong)UILabel *messageLable;
@property(nonatomic,weak)UIButton *leftBtn;


@property (nonatomic,copy) NSString *time111;
@end

@implementation ProertyAddMendAndServerViewController
-(id)initWithNavTitle:(NSString *)navTitle andTitleId:(NSString *)titleId{
    self = [super init];
    if (self) {
        self.titleId = titleId;
        self.isDateBool = NO;
        self.courseId = @"mendAndServe";
        self.numArr = [NSMutableArray arrayWithCapacity:0];
        self.saveFileArr = [NSMutableArray arrayWithCapacity:0];
        self.saveThumbFileArr = [NSMutableArray arrayWithCapacity:0];
        self.saveImageAndVideoAndAudioUrl = [NSMutableArray arrayWithCapacity:0];
        self.saveFidArr = [NSMutableArray arrayWithCapacity:0];
        [self loadAddress];
        [self laodData];
        [self makeUI];
        [self makeAddressView];

        [self makeNav:navTitle];
    }
    return self;
}



-(void)viewWillAppear:(BOOL)animated{
    [self viewDidLoad];
//    NSLog(@"%@",self.titleId);
    UIButton *commit = [UIButton buttonWithType:UIButtonTypeCustom];
    commit.frame = CGRectMake(WIDTH_CONTROLLER - 60 * self.numSingleVesion, 5 * self.numSingleVesion, 50 * self.numSingleVesion, 34 * self.numSingleVesion);
    [commit setTitle:@"提交" forState:UIControlStateNormal];
    [commit setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [commit addTarget:self action:@selector(commitBtnDown:) forControlEvents:UIControlEventTouchUpInside];
    commit.titleLabel.font = [UIFont systemFontOfSize:15];
    self.commitBtn = commit;
    
    UIBarButtonItem *commitItem = [[UIBarButtonItem alloc] initWithCustomView:commit];
    self.navigationItem.rightBarButtonItem = commitItem;
//    [self loadAddress];


}



-(void)laodData{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [paths objectAtIndex:0];
    self.cachePath = cachePath;
    NSString *htmlString = @"<html><head><body><div class=\"editor\" contenteditable=\"true\"  width=\"100%\" height=\"100%\"><p><img  src=\"4.jpg\" width=\"100%\"></p></div><body></head></html>";
    //<p><img id='img' src=\"10.jpg\" width=\"100%\" ></p><p><img id='img' src=\"10.jpg\" width=\"100%\" ></p><p>ccc</p><p><embed src=\"9533522808.f4v.mp4\" width=\"100%\"; height=""; autostart-=”true”;></embed> </p><p><audio src=\"jn.mp3\" type=\"audio/mp3\"  autostart=true loop=false controls=\"controls\"> 发挥发挥</audio></p>
    
    
}
//请求地址列表
- (void)loadAddress{
    //#define ADDRESSLIST MAININTERFACE@"serviceServlet?serviceName=MyAccountXmlGenerator&medthodName=addressJson&MemberID=%@&gotoPage=%ld&pageSize=%ld"
    NSString *addressStr = @"地址-尚未填写地址                                                          ";
    
    self.addressStr = addressStr;
    UILabel *addressLab = [[UILabel alloc] initWithFrame:CGRectMake(10 * self.numSingleVesion, 64, 300 *self.numSingleVesion, 80 * self.numSingleVesion)];
    addressLab.text = addressStr;
    addressLab.numberOfLines = 0;
    //    addressLab.backgroundColor = [UIColor redColor];
    addressLab.font = [UIFont systemFontOfSize:15];
    //    [addressLab sizeToFit];
    //    addressLab.center = CGPointMake(10 * self.numSingleVesion + addressLab.frame.size.width / 2, 64 + 20 * self.numSingleVesion);
    self.addresslab = addressLab;
    [self.view addSubview:self.addresslab];
    NSDate *datenow = [NSDate date];
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
    self.addressArr = [NSMutableArray arrayWithCapacity:0];
    AFNetworkTwoPackaging *twoPacking = [[AFNetworkTwoPackaging alloc] init];
    [twoPacking getUrl:[NSString stringWithFormat:@"%@&%@",[NSString stringWithFormat:ADDRESSLIST,[StoreageMessage getMessage][2],(long)1,(long)5],timeSp] andFinishBlock:^(id getResult) {
        if ([getResult[@"code"] isEqualToString:@"000001"]) {
            return ;
        }else{
            for (NSInteger i = 0;i < [getResult[@"datas"] count];i++) {
                AddressModel *model = [[AddressModel alloc] initWithDictionary:getResult[@"datas"][i]];
                if ([model.isDefault isEqual:@"Y"]) {
//                    self.addresslab.text = model.address;
                    
                    self.addresslab.text = [NSString stringWithFormat:@"%@ %@    %@\n\n%@-%@",model.name,model.sex,model.phone,model.xqName,model.address];
                    self.addressId = model.ID;
                    NSLog(@"%@",model.ID);
                }
                [self.addressArr addObject:model];
            }
        }

    }];
}
-(void)makeNav:(NSString *)navTitle{
    [self setNavBarImage:@"landi.png"];
    //[self setBackgroud:@"lantiao x.png"];
    [self setBackImageStateName:@"fanhuijian02.png" AndHighlightedName:@""];
    
    
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    //view.backgroundColor = MAINVIEWNAVBARCOLOR;
    //[self.view addSubview:view];
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectZero];
    lable.text = navTitle;
    lable.font = [UIFont systemFontOfSize:16 * self.numSingleVesion];
    lable.textColor = [UIColor blackColor];
    [lable sizeToFit];
    lable.frame = CGRectMake(5 * self.numSingleVesion, 0 + (44 - 15) / 2, lable.frame.size.width, 15);
    [view addSubview:lable];
    view.frame = CGRectMake(0, 0, lable.frame.size.width, 44);
    //UIBarButtonItem *centerBar = [[UIBarButtonItem alloc] initWithCustomView:view];
    //self.navTitle = lable;
    self.navigationItem.titleView = view;
    
   
}
-(void)commitBtnDown:(UIButton *)commitBtn{
//    commitBtn.userInteractionEnabled = NO;
//    NSString *jsToGetHTMLSource = @"document.getElementsByTagName('html')[0].innerHTML";
//    NSString *HTMLSource = [self.webView stringByEvaluatingJavaScriptFromString:jsToGetHTMLSource];
//    [self upLoadFileHtml:HTMLSource];
//    [self upLoadAudioAndVideoAndPhoto];
    [self.textView endEditing:YES];
    [self.textView resignFirstResponder];
    [self sendImageDataToSever];
//    [self sendOtherToSever];
}
//-(void)sendOtherToSever{
//    
//    [self upLoadNoteContent];
//}





//图片上传
-(void)sendImageDataToSever{
    
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
            [arrayImage addObject:img];
            [dicmu setObject:img forKey:[NSString stringWithFormat:@"%@",self.imagePickerArray[i]]];
        }
    }
    NSString *timeStr = [TranlateTime gainTimeStamp];
    self.uuid = timeStr;
    [self PostImagesToServer:UPLOADPHOTOANDVOICEANDVIDEO dicPostParams:@{@"uuid":self.uuid} dicImages:dicmu];
//    [self PostImagesToServer:RENTGETIMAGE dicPostParams:@{@"houseId":@"777",@"flag":@"0"} dicImages:dicmu];
    
}

-(void)PostImagesToServer:(NSString *) strUrl dicPostParams:(NSMutableDictionary *)params dicImages:(NSMutableDictionary *) dicImages{
    NSLog(@"%@",dicImages);
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
        
                NSLog(@"上传的图片：%d  %@", i, [keys objectAtIndex:i]);
        
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
//    NSLog(@"%@",myRequestData);
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
        NSLog(@"%@",request);
    //建立连接，设置代理
    //NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    //设置接受response的data
    NSData *mResponseData;
    NSError *err = nil;
    mResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&err];
    
    if(mResponseData == nil){
        //        NSLog(@"err code : %@", [err localizedDescription]);
        [self.view makeToast:@"服务器上传图片失败"];
    }
    res = [[NSString alloc] initWithData:mResponseData encoding:NSUTF8StringEncoding];
    //    resid = mResponseData;
        NSLog(@"服务器返回：%@", res);
    //    if (![resid[@"code"] isEqualToString:@"000000"]) {
    //        [self.view makeToast:@"上传失败请重新上传"];
    //    }
    //    NSLog(@"%@",res);
    [self upLoadNoteContent];
    
}


-(void)makeUI{
//    [self makeInit];
    [self storCachePath];
//    [self makeAddressView];
//    [self makeWebView];
//    [self makeBottom];
//    if ([self.titleId isEqualToString:@"2"]) {
//        
//    }else{
        [self makeDatePicker];
//    }
    [self makeTextViewAndPhoto];
}
//下边为调用相机，照片
-(void)makeInit{
    self.recordBtnState = NO;
    self.imageBtnState = 0;
    self.mp4Quality = AVAssetExportPresetLowQuality;
}
-(void)storCachePath{
    self.cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    self.documentPath = [paths objectAtIndex:0];
    
    self.documentPath = [FileOperation createCacheDocument:@"NoteVideoCache" andDocument:self.documentPath];
    self.cachePath = [FileOperation createCacheDocument:@"NoteOtherCache" andDocument:self.cachePath];
#warning message documentPath
//    NSLog(@"%@",self.documentPath);
//    NSLog(@"%@",self.cachePath);
}

-(void)makeAddressView{
//     NSString *cache = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
//
//    BOOL cacheBool = [FileOperation jugeFileExist:@"address.txt" andPath:@"address" andDocument:cache];
//    NSString *addressStr = nil;
//    if (cacheBool) {
//        
//        NSString *tempStr = [FileOperation getCachePathFile:@"address.txt"  andPath:@"address" andDocument:cache];
//        NSArray *tepArr = [NSKeyedUnarchiver unarchiveObjectWithFile:tempStr];
//        addressStr = [tepArr[0] objectForKey:@"address"];
//        self.addressArr = tepArr;
//    }else{
//        addressStr = @"新增地址";
//    }
    
    
    

    //箭头
    UIButton *arrowBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    arrowBtn.frame = CGRectMake(WIDTH_CONTROLLER - 10 * self.numSingleVesion - 40 * self.numSingleVesion, 64 + 35 * self.numSingleVesion, 30 * self.numSingleVesion, 18 * self.numSingleVesion);
    [arrowBtn setImage:[UIImage imageNamed:@"下一步"] forState:UIControlStateNormal];
    [arrowBtn addTarget:self action:@selector(arrowBtnDown:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:arrowBtn];
    arrowBtn.tag = 1600;
    

    //横线
    UILabel *lineLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 64 + 99 * self.numSingleVesion, WIDTH_CONTROLLER, 1 * self.numSingleVesion)];
    lineLab.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:lineLab];
    
    
    
    if ([self.titleId isEqualToString:@"1"]) {

    //时间
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 64 + 100 * self.numSingleVesion, WIDTH_CONTROLLER, 41 * self.numSingleVesion)];
    [self.view addSubview:view];
//    view.backgroundColor = SMSColor(213, 213, 213);
    //预约
    UILabel *orderLab = [[UILabel alloc] initWithFrame:CGRectMake(10 * self.numSingleVesion, (60 - 40) * self.numSingleVesion / 2, 100 * self.numSingleVesion, 20 * self.numSingleVesion)];
    orderLab.text = @"预约时间";
    orderLab.font = [UIFont systemFontOfSize:14];
    [view addSubview:orderLab];
    
//    //输入时间
//    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(10 * self.numSingleVesion + orderLab.frame.size.width + 10 * self.numSingleVesion, 10 * self.numSingleVesion, WIDTH_CONTROLLER - (10 * self.numSingleVesion + orderLab.frame.size.width + 10 * self.numSingleVesion) - 60 * self.numSingleVesion, 40 * self.numSingleVesion)];
//    textField.placeholder = @"请选择时间或者填写时间";
//    textField.borderStyle = UITextBorderStyleRoundedRect;
//    [view addSubview:textField];
//    self.textField = textField;
    
    //时间按钮
    UIButton *dateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    dateBtn.frame = CGRectMake(WIDTH_CONTROLLER - 10 * self.numSingleVesion - 40 * self.numSingleVesion, (60 - 40) * self.numSingleVesion / 2, 20 * self.numSingleVesion, 20 * self.numSingleVesion);
    [dateBtn setImage:[UIImage imageNamed:@"下一步"] forState:UIControlStateNormal];
    [view addSubview:dateBtn];
    [dateBtn addTarget:self action:@selector(arrowBtnDown:) forControlEvents:UIControlEventTouchUpInside];
    dateBtn.tag = 1601;
    
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(10 * self.numSingleVesion + orderLab.frame.size.width + 10 * self.numSingleVesion, 0 * self.numSingleVesion, WIDTH_CONTROLLER - (10 * self.numSingleVesion + orderLab.frame.size.width + 10 * self.numSingleVesion) - 60 * self.numSingleVesion, 40 * self.numSingleVesion)];
    [view addSubview:lab];
    UITapGestureRecognizer *tap=[[ UITapGestureRecognizer alloc ] initWithTarget : self action : @selector (arrowBtnDown1:)];
    [lab addGestureRecognizer :tap];
    lab. userInteractionEnabled = YES ;
    lab.text = @"请选择时间";
    lab.font = [UIFont systemFontOfSize:14];

    lab.tag = 1062;
    lab.textAlignment = UITextAlignmentRight;
    self.labTime = lab;
        
    
    //横线
    UILabel *lineLab1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 40 * self.numSingleVesion, WIDTH_CONTROLLER, 1 * self.numSingleVesion)];
    lineLab1.backgroundColor = [UIColor lightGrayColor];
    [view addSubview:lineLab1];
        
    }
    
}
-(void)arrowBtnDown:(UIButton *)arrowBtn{
    //箭头
    [self.webView endEditing:YES];

    if (arrowBtn.tag == 1600) {
        
        
        CommitOrderViewController *commit = [[CommitOrderViewController alloc] initWithAddressArr:self.addressArr];
        commit.target = self;
        commit.delegate = self;
        [self.navigationController pushViewController:commit animated:YES];
    }else{//时间
        if (!self.isDateBool) {
            self.datePicker.hidden = NO;
        }
        else{
            self.datePicker.hidden = YES;
        }
        self.isDateBool = !self.isDateBool;
//        [self.textField resignFirstResponder];
//        [numberField resignFirstResponder];
    }
}


-(void)arrowBtnDown1:(UILabel *)arrowBtn{
    if (!self.isDateBool) {
        self.datePicker.hidden = NO;
    }
    else{
        self.datePicker.hidden = YES;
    }
    self.isDateBool = !self.isDateBool;



}

# pragma mark sendMessagedelegate
-(void)sendNewAddress:(NSString *)AddressStr andNumber:(NSString *)number andName:(NSString *)name andSex:(NSString *)sex andPhone:(NSString *)phone{
    self.addresslab.text = [NSString stringWithFormat:@"%@ %@    %@\n\n%@-%@",AddressStr,number,name,sex,phone];
}
//返回地址列表
- (void)retunAddress:(AddressModel *)model{
//    self.addresslab.text = model.address;
    self.addresslab.text = [NSString stringWithFormat:@"%@ %@    %@\n\n%@-%@",model.name,model.sex,model.phone,model.xqName,model.address];
    self.addressId = model.ID;
    [self cahngeAddress:model];
}


//更换默认地址
- (void)cahngeAddress:(AddressModel *)model{
    AFNetworkTwoPackaging *twoPack = [[AFNetworkTwoPackaging alloc] init];
#define DEFAULTADDRESS MAININTERFACE@"serviceServlet?serviceName=MyAccountXmlGenerator&medthodName=addressSetIsDefault&memberID=%@&addressId=%@&isDefault=Y"
//    self.addresslab.text = [NSString stringWithFormat:@"%@ %@    %@\n\n%@-%@",model.name,model.sex,model.phone,model.xqName,model.address];

    [twoPack getUrl:[NSString stringWithFormat:DEFAULTADDRESS,[StoreageMessage getMessage][2],model.ID] andFinishBlock:^(id getResult) {
        
    }];
}
#pragma mark 以下是笔记
-(void)makeWebView{
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(15 * self.numSingleVesion, 64 + 60 * self.numSingleVesion + 100 * self.numSingleVesion, WIDTH_CONTROLLER - 30 * self.numSingleVesion, HEIGHT_CONTROLLER - 64 - 60 * self.numSingleVesion - 300 * self.numSingleVesion - 45 * self.numSingleVesion)];
    webView.delegate = self;
//    [self.view addSubview:webView];
    webView.dataDetectorTypes = UIDataDetectorTypeAll;
    webView.userInteractionEnabled = YES;
    webView.scrollView.showsHorizontalScrollIndicator = NO;
    //webView.scrollView.showsVerticalScrollIndicator = NO;
    webView.layer.borderWidth = 1 * self.numSingleVesion;
    webView.layer.borderColor = [[UIColor colorWithRed:(CGFloat) 221 / 255.0  green:(CGFloat) 221 / 255.0 blue:(CGFloat) 221 / 255.0 alpha:1] CGColor];
    webView.scalesPageToFit = YES;
    self.webView = webView;
    self.htmlStr = @"<html><head><meta content=\"width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0;\" name=\"viewport\" /><meta content=\"yes\" name=\"apple-mobile-web-app-capable\" /><meta content=\"black\" name=\"apple-mobile-web-app-status-bar-style\" /><meta content=\"telephone=no\" name=\"format-detection\" /> <script type=\"text/javascript\">function inserthtml(str) { var idEdit = document.getElementByName('editor');idEdit.innerHTML += str;}</script></head><body><div class=\"editor\" name=\"editor\" contenteditable=\"true\"  style=\"height:80%%;width:90%%;\"></div><body></html>";
    //    border:1px solid #e7e7e7
    self.htmlSourceString = self.htmlStr;
    [webView loadHTMLString:self.htmlStr baseURL:nil];
    
        //添加手势
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesturePho)];
    tapGesture.numberOfTapsRequired = 1;
    tapGesture.delegate = self;
    webView.userInteractionEnabled = YES;
    [webView addGestureRecognizer:tapGesture];

    
}

-(void)tapGesturePho{
    self.datePicker.hidden = YES;
}
-(void)makeBottom{
    [self setAudioSession];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, HEIGHT_CONTROLLER - 44 * self.numSingleVesion, WIDTH_CONTROLLER, 44 * self.numSingleVesion)];
    view.backgroundColor = [UIColor colorWithRed:(CGFloat)246 / 255.0 green:(CGFloat)246 / 255.0 blue:(CGFloat)246 / 255.0 alpha:1];
    [self.view addSubview:view];
    NSArray *imageArr = @[@"notes_insert_camera@2x.png",@"notes_insert_video@2x.png",@"notes_insert_microphone@2x.png",@"notes_insert_photo@2x.png"];
    CGFloat leftWidth = (WIDTH_CONTROLLER - 33  * self.numSingleVesion * 3 - 30 * self.numSingleVesion * 4) / 2;
    for (NSInteger i = 0; i < imageArr.count; i++) {
        UIButton *imageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        imageBtn.frame = CGRectMake(0, 0, 30 * self.numSingleVesion, 30 * self.numSingleVesion);
        imageBtn.center = CGPointMake(leftWidth + 15 * self.numSingleVesion + (33 + 30) * self.numSingleVesion * i, 22 * self.numSingleVesion);
        [imageBtn setImage:[UIImage imageNamed:imageArr[i]] forState:UIControlStateNormal];
        if (i == 2) {
            UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
            [view addGestureRecognizer:longPress];
            //[imageBtn addTarget:self action:@selector(imgBtnDown:) forControlEvents:UIControlEventTouchUpInside];
        }else{
            [imageBtn addTarget:self action:@selector(imgBtnDown:) forControlEvents:UIControlEventTouchUpInside];
        }
        [view addSubview:imageBtn];
        imageBtn.tag = 1600 + i;
    }
}
-(void)longPress:(UILongPressGestureRecognizer *)pressGesture{
    if ([pressGesture state] == UIGestureRecognizerStateBegan) {
        self.voiceLable.text = @"正在录音";
        [self.voiceLable sizeToFit];
        self.voiceLable.center = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height - 80 * self.numSingleVesion);
        [self makeRecord];
    }else if([pressGesture state] == UIGestureRecognizerStateEnded){
        self.voiceLable.text = @"录音结束";
        [self.voiceLable sizeToFit];
        self.voiceLable.center = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height - 80 * self.numSingleVesion);
        [self stopRecord];
    }
}
-(void)imgBtnDown:(UIButton *)imgBtn{
    if (imgBtn.tag == 1602) {
        return;
    }
    switch (imgBtn.tag) {
        case 1600:{
            self.imageBtnState = 0;
            [self makePhotoOrImage:1];
            break;
        }
        case 1601:{
            self.imageBtnState = 3;
            [self makePhotoOrImage:3];
            
            break;
        }
        case 1602:{
            if (!self.recordBtnState) {
                self.voiceLable.text = @"正在录音";
                [self.voiceLable sizeToFit];
                self.voiceLable.center = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height - 80 * self.numSingleVesion);
                [self makeRecord];
                
            }
            else{
                self.voiceLable.text = @"录音结束";
                [self.voiceLable sizeToFit];
                self.voiceLable.center = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height - 80 * self.numSingleVesion);
                [self stopRecord];
            }
            self.recordBtnState = !self.recordBtnState;
            break;
        }
        case 1603:{
            self.imageBtnState = 0;
            [self makePhotoOrImage:2];
            break;
        }
        default:
            break;
    }
    
    
    
}
//相机
/*
 0.表示图片库 UIImagePickerControllerSourceTypePhotoLibrary,
 1.1表示相机 UIImagePickerControllerSourceTypeCamera,
 2.2表示照片 UIImagePickerControllerSourceTypeSavedPhotosAlbum
 */
-(void)makePhotoOrImage:(NSInteger)photoStr{
    UIImagePickerController *imagePicker=[[UIImagePickerController alloc] init];
    imagePicker.delegate=self;
    switch (photoStr) {
        case 0:{
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            break;
        }
        case 1:{
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            break;
        }
        case 2:{
            imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            break;
        }
        case 3:{
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            NSArray* availableMedia = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
            imagePicker.mediaTypes = [NSArray arrayWithObject:availableMedia[1]];
            imagePicker.videoQuality = UIImagePickerControllerQualityTypeLow;
            imagePicker.videoMaximumDuration = 30;
            break;
        }
        default:
            break;
    }
    //imagePicker.allowsEditing=YES;
    //[self.view addSubview:imagePicker.view];
    [self presentViewController:imagePicker animated:YES completion:^{
        
    }];
    
}

#pragma mark 相机的代理
//-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
//    
//    if (self.imageBtnState == 3) {
//        self.videoURL = info[UIImagePickerControllerMediaURL];
//        
//        [self tranlateMP4];
//        [picker dismissViewControllerAnimated:YES completion:nil];
//        
//        return;
//    }
//    //相册库
//    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum] ) {
//        
//    }
//    //照相机
//    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
//        UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
//        NSMutableString *fileNameImg = [[self gainCachePath] mutableCopy];
//        
//        
//        //效果
//        
//        //判断图片是不是png格式的文件
//        if (UIImagePNGRepresentation(image)) {
//            [fileNameImg appendString:@".png"];
//        }else {
//            [fileNameImg appendString:@".jpg"];
//        }
//#warning message cachePath
//        //NSLog(@"%@",self.cachePath);
//        NSString *fileNameImgPth =  [FileOperation createCacheFile:fileNameImg andPath:self.courseId andDocument:self.cachePath];
//        //        NSFileManager *manager = [NSFileManager defaultManager];
//        //        BOOL fileExits = [manager createFileAtPath:[NSString stringWithFormat:@"%@/%@",self.cachePath,fileNameImg] contents:nil attributes:nil];
//        //        if (!fileExits) {
//        //            NSLog(@"failer");
//        //        }
//        //        else{
//        //            fileNameImgPth = [NSString stringWithFormat:@"%@/%@",self.cachePath,fileNameImg];
//        //            NSLog(@"successs");
//        //        }
//        //        [UIImagePNGRepresentation(<#UIImage *image#>)]
//        //        [UIImageJPEGRepresentation(image, 0.4)]
//        if (UIImagePNGRepresentation(image)) {
//            //            HEIGHT_CONTROLLER / WIDTH_CONTROLLER *
//            UIImage *pngImg = [self imageWithImageSimple:image scaledToSize:CGSizeMake(200 * self.numSingleVesion,  300 * self.numSingleVesion)];
//            
//            [UIImagePNGRepresentation(pngImg) writeToFile:fileNameImgPth atomically:YES];
//        }else{
//            [UIImageJPEGRepresentation(image, 0.4) writeToFile:fileNameImgPth atomically:YES];
//        }
//        //#warning message
////        NSLog(@"fileNamepath：%f",[self fileSizeAtPath:fileNameImgPth] / (1024.0 * 1024.0) );
//        NSURL *fileNameImgUrl = [NSURL fileURLWithPath:fileNameImgPth];
//        [FileOperation tranlateAssertUrl:fileNameImgUrl];
//        //        NSData *dataImgD = [NSData dataWithContentsOfFile:fileNameImgPth];
//        //        UIImage *img = [UIImage imageWithData:dataImgD];
//        //        NSLog(@"%@",image);
//        //        UIImageView *bagImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 100, 300, 200)];
//        //        bagImg.image = img;
//        //        [self.webView addSubview:bagImg];
//        //        NSString *fialImgUrl = [NSString stringWithFormat:@"<p><img  src=\"%@\" width=\"%f\"></p>",fileNameImgUrl,WIDTH_CONTROLLER - 19 * self.numSingleVesion];
//        //        [self insertHtmlString:fialImgUrl];
//        //@"<p><img  src=\"%@\" width=\"80%%\" alt=\"\" id=\"\"></p>";
//        //NSString *fialImgUrl = [NSString stringWithFormat:@"<p><img  src=\"%@\" width=\"80%%\"></p>",fileNameImgUrl];
//        NSString *fialImgUrl = [NSString stringWithFormat:@"<p><img   src=\"%@\" width=\"80%%\" alt=\"\" id=\"\"></p>",fileNameImgUrl];
//        [self insertHtmlString:fialImgUrl];
//    }
//    //照相库
//    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
//    }
//    [picker dismissViewControllerAnimated:YES completion:nil];
//    
//}
#pragma mark 计算文件的大小
//单个文件的大小
- (CGFloat) fileSizeAtPath:(NSString*) filePath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}
//压缩图片
- (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark 录音
-(void)makeRecord{
    if (![self.audioRecorder isRecording]) {
        [self.audioRecorder record];//首次使用时如果调用record方法会询问用户是否允许使用麦克风
        self.timer.fireDate = [NSDate distantPast];
        [self.record setTitle:@"正在录音" forState:UIControlStateNormal];
    }
}
#pragma mark 获得录音机对象 1
//设置音频会话
-(void)setAudioSession{
    AVAudioSession *audionSession = [AVAudioSession sharedInstance];
    //设置播放和录音状态，以便可以在录制完之后录音
    [audionSession setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    [audionSession setActive:YES error:nil];
}
-(AVAudioRecorder *)audioRecorder{
    if (!_audioRecorder) {
        //创建录音文件保存路径
        NSURL *url = [self getSavePath];
        //创建录音格式设置
        NSDictionary *setting = [self getAudioSetting];
        //创建录音机
        NSError *error = nil;
        _audioRecorder = [[AVAudioRecorder alloc] initWithURL:url settings:setting error:&error];
        _audioRecorder.delegate = self;
        _audioRecorder.meteringEnabled = YES;//如果需要监控声波则必须设置为yes
        if(error){
//            NSLog(@"创建录音机对象时发生错误，错误信息%@",error.localizedDescription);
            return nil;
        }
        
    }
    return _audioRecorder;
}
//取得录音文件保存路径
-(NSURL *)getSavePath{
    NSMutableString *fileNameImg = [[self gainCachePath] mutableCopy];
    [fileNameImg appendString:@".caf"];
    NSString *urlStr = [FileOperation createCacheFile:fileNameImg andPath:self.courseId andDocument:self.cachePath];
    NSURL *url = [NSURL fileURLWithPath:urlStr];
    self.recordStr = urlStr;
    return url;
}
//取得录音文件设置 3
-(NSDictionary *)getAudioSetting{
    //    NSMutableDictionary *dicM = [NSMutableDictionary dictionary];
    //    //设置录音格式
    //    [dicM setObject:@(kAudioFormatLinearPCM) forKey:AVFormatIDKey];
    //    //设置录音采样率，8000是电话采样率，对于一般录音已经够了
    //    [dicM setObject:@(8000.0) forKey:AVSampleRateKey];
    //    //设置通道，这里采用单声道
    //    [dicM setObject:@(1) forKey:AVNumberOfChannelsKey];
    //    //每个采样点位数，分为8、16、24、32
    //    [dicM setObject:@(8) forKey:AVLinearPCMBitDepthKey];
    //    //是否使用浮点数采样
    //    [dicM setObject:@(YES) forKey:AVLinearPCMIsFloatKey];
    NSDictionary *recordSettings = [NSDictionary
                                    dictionaryWithObjectsAndKeys:
                                    [NSNumber numberWithInt:AVAudioQualityMin],
                                    AVEncoderAudioQualityKey,
                                    [NSNumber numberWithInt:16],
                                    AVEncoderBitRateKey,
                                    [NSNumber numberWithInt: 2],
                                    AVNumberOfChannelsKey,
                                    [NSNumber numberWithFloat:44100.0],
                                    AVSampleRateKey,
                                    nil];
    return recordSettings;
}
//录音停止
-(void)stopRecord{
    [self.audioRecorder stop];
}
#pragma mark 录音代理方法
//录音完成，录音完成后播放录音
-(void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag{
//    NSLog(@"录音完成");
    self.voiceLable.text = @"录音完成";
    //self.voiceLable
    [self.record setTitle:@"音频" forState:UIControlStateNormal];
    [self audio_PCMtoMP3:self.recordStr];
}
-(void)audioRecorderEncodeErrorDidOccur:(AVAudioRecorder *)recorder error:(NSError *)error{
#warning message error
//    NSLog(@"%@",error);
}
#pragma mark caf 转成 MP3
- (void)audio_PCMtoMP3:(NSString *)path{
#warning message mp3FilePath
//    NSLog(@"%@",path);
    NSString *cafFilePath = path;
    //NSMutableString *mutString = [path mutableCopy];
    NSString *temp =  [cafFilePath substringToIndex:path.length - 4];
#warning message 可以删除
    
    NSString *mp3FilePath = [NSString stringWithFormat:@"%@.mp3",temp];
    
    [FileOperation createCacheFile:mp3FilePath andPath:self.courseId andDocument:self.cachePath];
#warning message mp3FilePath
//    NSLog(@"%@",mp3FilePath);
//    NSLog(@"%@",path);
    NSFileManager* fileManager=[NSFileManager defaultManager];
    if([fileManager removeItemAtPath:mp3FilePath error:nil])
    {
//        NSLog(@"删除");
    }
    
    @try {
        int read, write;
        
        FILE *pcm = fopen([cafFilePath cStringUsingEncoding:1], "rb");  //source 被转换的音频文件位置
        fseek(pcm, 4*1024, SEEK_CUR);                                   //skip file header
        FILE *mp3 = fopen([mp3FilePath cStringUsingEncoding:1], "wb");  //output 输出生成的Mp3文件位置
        
        const int PCM_SIZE = 8192;
        const int MP3_SIZE = 8192;
        short int pcm_buffer[PCM_SIZE*2];
        unsigned char mp3_buffer[MP3_SIZE];
        
        lame_t lame = lame_init();
        lame_set_in_samplerate(lame, 44100);
        lame_set_VBR(lame, vbr_default);
        lame_init_params(lame);
        
        do {
            read = fread(pcm_buffer, 2*sizeof(short int), PCM_SIZE, pcm);
            if (read == 0)
                write = lame_encode_flush(lame, mp3_buffer, MP3_SIZE);
            else
                write = lame_encode_buffer_interleaved(lame, pcm_buffer, read, mp3_buffer, MP3_SIZE);
            
            fwrite(mp3_buffer, write, 1, mp3);
            
        } while (read != 0);
        
        lame_close(lame);
        fclose(mp3);
        fclose(pcm);
    }
    @catch (NSException *exception) {
//        NSLog(@"%@",[exception description]);
    }
    @finally {
        [fileManager removeItemAtPath:cafFilePath error:nil];
        NSURL *tempUrl = [NSURL fileURLWithPath:mp3FilePath];
        [FileOperation tranlateAssertUrl:tempUrl];
        //        NSString *recordString = [NSString stringWithFormat:@"<p><audio src=\"%@\" type=\"audio/mp3\"  autostart=false loop=false controls=\"controls\" width=\"%f\"> </audio></p>",tempUrl,WIDTH_CONTROLLER - 19 * self.numSingleVesion];
        //        [self insertHtmlString:recordString];
        
        NSString *recordString = [NSString stringWithFormat:@"<p><audio  style=\"width:200px;\" src=\"%@\" id=\"\" type=\"audio/mp3\"  autostart=false loop=false controls=\"controls\" width=\"480\" height=\"100\"> </audio></p>",tempUrl];
        //NSString *recordString = [NSString stringWithFormat:@"<p><audio  style=\"width:200px;\" src=\"%@\"   autostart=false loop=false controls=\"controls\" width=\"480\" height=\"100\"> </audio></p>",tempUrl];
        [self insertHtmlString:recordString];
    }
}
#pragma mark 视频转成MP4
-(void)tranlateMP4{
    AVURLAsset *avAsset = [AVURLAsset URLAssetWithURL:self.videoURL options:nil];
    NSArray *compatiblePresets = [AVAssetExportSession exportPresetsCompatibleWithAsset:avAsset];
#warning message compatiblePresets
//    NSLog(@"%@",compatiblePresets);
    if ([compatiblePresets containsObject:self.mp4Quality]) {
        AVAssetExportSession *exportSession = [[AVAssetExportSession alloc] initWithAsset:avAsset presetName:self.mp4Quality];
        //        NSDateFormatter* formater = [[NSDateFormatter alloc] init];
        //        [formater setDateFormat:@"yyyy-MM-dd-HH:mm:ss"];
        //        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        //        NSString *docDir = [paths objectAtIndex:0];
        //self.videoString = [docDir stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.mp4",[TranlateTime returnImageNameDate]]];
        NSMutableString *fileNameImg = [[self gainCachePath] mutableCopy];
        [fileNameImg appendString:@".mp4"];
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *docDir = [paths objectAtIndex:0];
        //self.videoString = [self.documentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.mp4",[TranlateTime returnImageNameDate]]];
        self.videoString = [self.documentPath stringByAppendingPathComponent:fileNameImg];
        //self.videoString = [FileOperation createCacheFile:fileNameImg andPath:self.courseId andDocument:self.documentPath];
#warning message fileNameImg
//        NSLog(@"%@",self.videoString);
        exportSession.outputURL = [NSURL fileURLWithPath: self.videoString];
        
#warning message outputUrl
//        NSLog(@"%@",exportSession.outputURL);
        exportSession.shouldOptimizeForNetworkUse = YES;
        exportSession.outputFileType = AVFileTypeMPEG4;
        [exportSession exportAsynchronouslyWithCompletionHandler:^{
#warning message status
//            NSLog(@"%d",[exportSession status]);
//            NSLog(@"%@",exportSession);
            
            switch ([exportSession status]) {
                case AVAssetExportSessionStatusFailed:{
                    
                    break;
                }
                case AVAssetExportSessionStatusCancelled:{
                    
                    break;
                }
                case AVAssetExportSessionStatusCompleted:{
                    self.videoURL = exportSession.outputURL;
                    [self performSelectorOnMainThread:@selector(completeSuccess) withObject:nil waitUntilDone:NO];
                    
                    break;
                }
                default:
                    break;
            }
        }];
    }
    
    
    
}
-(void)completeSuccess{
    //    NSString *videoUrl = [NSString stringWithFormat:@"<p><video src=\"%@\"  autostart-=\"true\" width=\"%f\"></video> </p>",self.videoURL,WIDTH_CONTROLLER - 19 * self.numSingleVesion];
    //    [self insertHtmlString:videoUrl];
    
    NSString *videoUrl = [NSString stringWithFormat:@"<p><video controls＝\"controls\" src=\"%@\" id=\"\" autostart-=\"true\" width=\"80%%\"></video> </p>",self.videoURL];
    [self insertHtmlString:videoUrl];
}


#pragma mark 插入到HTML的
-(void)insertHtmlString:(NSString *)htmlString{
    //修改文字
    NSString * js_result = [self.webView  stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.getElementsByTagName('div')[0].innerHTML+='%@'",htmlString]];
    NSString *jsToGetHTMLSource = @"document.getElementsByTagName('html')[0].innerHTML";
    NSString *HTMLSource = [self.webView stringByEvaluatingJavaScriptFromString:jsToGetHTMLSource];
    self.htmlSourceString = HTMLSource;
//    NSLog(@"%@",HTMLSource);
}
#pragma mark 获取Cache路径
-(NSString *)gainCachePath{
    NSMutableString *fileNameImg = [NSMutableString stringWithCapacity:0];
    NSMutableArray *fileNameArr = [NSMutableArray arrayWithCapacity:0];
    return [TranlateTime gainTimeStamp];
}
#pragma mark 获取Document路径
-(NSString *)getDocumentPathString{
    NSMutableString *fileNameImg = [NSMutableString stringWithCapacity:0];
    NSMutableArray *fileNameArr = [NSMutableArray arrayWithCapacity:0];
   return [TranlateTime gainTimeStamp];
}

#pragma mark 解析HTML
-(void)analysisHtml:(NSString *)str{
#warning message 调用获取图片的地址
    //[self uploadingFile:str];
}
#pragma mark html 解析、替换、上传
//找出文件名和Url
-(void)upLoadFileHtml:(NSString *)htmlSource{
    NSMutableArray *allArr = [NSMutableArray arrayWithCapacity:0];
    self.saveImageAndVideoAndAudioUrl = allArr;
    NSString *typeImgStr = nil;//上传时，确定哪一个类型
    NSInteger imgNum = [self.webView  stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('div')[0].getElementsByTagName('img').length"].integerValue;
    //图像
    for (NSInteger i = 0; i < imgNum; i++) {
        NSString *imgUrlStr = [self.webView  stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.getElementsByTagName('div')[0].getElementsByTagName('img')[%ld].src",(long)i]];
        NSArray *imgTempArr = [imgUrlStr componentsSeparatedByString:@"/"];
        NSString *fileName = [imgTempArr lastObject];
        if ([fileName hasSuffix:@"png"]) {
            typeImgStr = @"image/png";
        }else{
            typeImgStr = @"image/jpg";
        }
        NSURL *imgUrl = [NSURL URLWithString:imgUrlStr];
        [allArr addObject:@{@"typeImgStr":typeImgStr,@"imgUrl":imgUrl,@"fileName":fileName}];
    }
    //视频
    NSString *typeVideoStr = nil;
    NSInteger videoNum = [self.webView  stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('div')[0].getElementsByTagName('video').length"].integerValue;
    
    for (NSInteger i = 0; i < videoNum;i++) {
        NSString *imgUrlStr= [self.webView  stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.getElementsByTagName('div')[0].getElementsByTagName('video')[%ld].src",(long)i]];
        NSArray *imgTempArr = [imgUrlStr componentsSeparatedByString:@"/"];
        NSString *fileName = [imgTempArr lastObject];
        typeVideoStr=@"video/mp4";
        NSURL *imgUrl = [NSURL URLWithString:imgUrlStr];
        [allArr addObject:@{@"typeImgStr":typeVideoStr,@"imgUrl":imgUrl,@"fileName":fileName}];
    }
    //音频
    //录音
    NSString *typeAudioStr = nil;
    NSInteger audionNum = [self.webView  stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('div')[0].getElementsByTagName('audio').length"].integerValue;
    for (__block NSInteger i = 0; i < audionNum;i++) {
        NSString *imgUrlStr = [self.webView  stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.getElementsByTagName('div')[0].getElementsByTagName('audio')[%ld].src",(long)i]];
        NSArray *imgTempArr = [imgUrlStr componentsSeparatedByString:@"/"];
        NSString *fileName = [imgTempArr lastObject];
        typeAudioStr=@"audio/mp3";
        NSURL *imgUrl = [NSURL URLWithString:imgUrlStr];
        [allArr addObject:@{@"typeImgStr":typeAudioStr,@"imgUrl":imgUrl,@"fileName":fileName}];
    }
}
//上传图片、文字、音频、视频
-(void)upLoadAudioAndVideoAndPhoto{
    // NSURL *filePath = [NSURL URLWithString:imgUrl];
    if (self.saveImageAndVideoAndAudioUrl.count == 0) {
        [self upLoadNoteContent];
        return;
    }
    [self.numArr removeAllObjects];
    [self.saveFileArr removeAllObjects];
    [self.saveThumbFileArr removeAllObjects];
    [self.saveFidArr removeAllObjects];
    __block NSInteger saveFileNum = 0;
    NSString *timeStr = [TranlateTime gainTimeStamp];
    self.uuid = timeStr;
    NSDictionary *parameters = @{@"name":@"file",@"uuid":timeStr};
    AFHTTPSessionManager *requestManager = [AFHTTPSessionManager manager];
    requestManager.requestSerializer = [[AFHTTPRequestSerializer alloc] init];
    requestManager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    requestManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/json",@"text/html",@"application/json",@"text/plain",nil];
    for (NSInteger i = 0; i < self.saveImageAndVideoAndAudioUrl.count; i++) {
        //         STUDY_SAVEFILE
        
        [requestManager POST:UPLOADPHOTOANDVOICEANDVIDEO parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            [StoreageMessage getErrorMessage:@"NULL" fromUrl:UPLOADPHOTOANDVOICEANDVIDEO];

            /**
             *  appendPartWithFileURL   //  指定上传的文件
             *  name                    //  指定在服务器中获取对应文件或文本时的key
             *  fileName                //  指定上传文件的原始文件名
             *  mimeType                //  指定商家文件的MIME类型
             */
            //[formData appendPartWithFileData:<#(NSData *)#> name:<#(NSString *)#> fileName:<#(NSString *)#> mimeType:<#(NSString *)#>]
            [formData appendPartWithFileURL:[self.saveImageAndVideoAndAudioUrl[i] objectForKey:@"imgUrl"] name:@"file" fileName:[self.saveImageAndVideoAndAudioUrl[i] objectForKey:@"fileName"] mimeType:[self.saveImageAndVideoAndAudioUrl[i]  objectForKey:@"typeImgStr"] error:nil];
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
            NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
#warning message dict
//            NSLog(@"dict:%@",dict);
            if ([dict[@"code"] isEqual:@"000000"]) {
                //判断是不是图片
                NSString *tempImg = [self.saveImageAndVideoAndAudioUrl[i]  objectForKey:@"typeImgStr"];
                if (IOS8) {
                    if ([tempImg containsString:@"image/png"] || [tempImg containsString:@"image/jpg"]) {
                        
#warning message 原先的
                        
                        [self.saveThumbFileArr addObject:dict[@"fileUrl"]];
                        //[self.saveThumbFileArr addObject:dict[@"fileurl"]];
                        
                    }else{
                        [self.saveThumbFileArr addObject:@"fileUrl"];
                        
                    }
                    
                }else{
                    NSRange range1 = [tempImg rangeOfString:@"image/png"];
                    NSRange range2 = [tempImg rangeOfString:@"image/jpg"];
                    if (range1.location != NSNotFound || range2.location != NSNotFound) {
                        [self.saveThumbFileArr addObject:dict[@"fileUrl"]];
                        //[self.saveThumbFileArr addObject:dict[@"fileurl"]];
                        
                    }else{
                        [self.saveThumbFileArr addObject:@"fileUrl"];
                        
                    }                 }
                [self.numArr addObject:dict[@"uuid"]];
                [self.saveFileArr addObject:dict[@"fileUrl"]];
                [self.saveFidArr addObject:dict[@"uuid"]];

            }
//            if ([dict respondsToSelector:@selector(fileUrl)]) {
//                //判断是不是图片
//                NSString *tempImg = [self.saveImageAndVideoAndAudioUrl[i]  objectForKey:@"typeImgStr"];
//                if (IOS8) {
//                    if ([tempImg containsString:@"image/png"] || [tempImg containsString:@"image/jpg"]) {
//                        
//#warning message 原先的
//                        
//                        [self.saveThumbFileArr addObject:dict[@"fileurl_small"]];
//                        //[self.saveThumbFileArr addObject:dict[@"fileurl"]];
//                        
//                    }else{
//                        [self.saveThumbFileArr addObject:@"fileurl"];
//                        
//                    }
//                    
//                }else{
//                    NSRange range1 = [tempImg rangeOfString:@"image/png"];
//                    NSRange range2 = [tempImg rangeOfString:@"image/jpg"];
//                    if (range1.location != NSNotFound || range2.location != NSNotFound) {
//                        [self.saveThumbFileArr addObject:dict[@"fileurl_small"]];
//                        //[self.saveThumbFileArr addObject:dict[@"fileurl"]];
//                        
//                    }else{
//                        [self.saveThumbFileArr addObject:@"fileurl"];
//                        
//                    }                 }
//                [self.numArr addObject:dict[@"fid"]];
//                [self.saveFileArr addObject:dict[@"fileurl"]];
//                [self.saveFidArr addObject:dict[@"fid"]];
//                //[self.saveFileArr addObject:<#(id)#>]
//                
//            }
            
            if (saveFileNum == self.saveImageAndVideoAndAudioUrl.count - 1) {
                [self repalceVideoAndAudioAndIamgeUrl];
            }
            saveFileNum ++;
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
#warning message error
//            NSLog(@"%@",error);
//            NSLog(@"获取服务器响应出错");
            
            if (saveFileNum == self.saveImageAndVideoAndAudioUrl.count - 1) {
                [self repalceVideoAndAudioAndIamgeUrl];
            }
            saveFileNum ++;
        }];
        
    }
    
}

//- (void)textViewDidEndEditing:(UITextView *)textView{
////    self.textViewText = textView.text;
////    NSLog(@"%@",textView.text);
//}

- (void)textViewDidChange:(UITextView *)textView{

    self.textViewText = textView.text;
    NSLog(@"%@",textView.text);
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text

{
    
    if ([text isEqualToString:@"\n"]) {
        
        [textView resignFirstResponder];
        
        return NO;
        
    }
    
    return YES;
    
}

//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    //隐藏键盘
//    [_textView endEditing:YES];
//    [_textView resignFirstResponder];
//}

//替换各个Url
-(void)repalceVideoAndAudioAndIamgeUrl{
    
    for (NSInteger i = 0; i < self.saveFileArr.count; i++) {
        
        NSArray *imgTempArr = [self.saveFileArr[i] componentsSeparatedByString:@"/"];
        
        NSString *fileNameFirst = [imgTempArr lastObject];
        NSArray *fileNameArr = [fileNameFirst componentsSeparatedByString:@"_"];
        NSString *fileName = [fileNameArr componentsJoinedByString:@""];
        if([fileName hasSuffix:@"jpg"] || [fileName hasSuffix:@"png"]){
            NSInteger imgNum = [self.webView  stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('div')[0].getElementsByTagName('img').length"].integerValue;
            for (__block NSInteger j = 0; j < imgNum;j++) {
                NSString *imgUrl = [self.webView  stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.getElementsByTagName('div')[0].getElementsByTagName('img')[%ld].src",(long)j]];
                NSArray *imgTempArr = [imgUrl componentsSeparatedByString:@"/"];
                NSString *fileNameImg = [imgTempArr lastObject];
                if ([fileName isEqualToString:fileNameImg]) {
                    //换成现在的HTML
                    NSString *imgUrl = [NSString stringWithFormat:@"document.getElementsByTagName('div')[0].getElementsByTagName('img')[%ld].src='%@'",(long)j,self.saveThumbFileArr[i]];
                    [self.webView  stringByEvaluatingJavaScriptFromString:imgUrl];
                    
                    //换成现在的HTML
                    NSString *imgThubUrl = [NSString stringWithFormat:@"document.getElementsByTagName('div')[0].getElementsByTagName('img')[%ld].id='%@'",(long)j,self.saveFileArr[i]];
                    [self.webView  stringByEvaluatingJavaScriptFromString:imgThubUrl];
                    //换成现在的Fid
                    NSString *imgFid = [NSString stringWithFormat:@"document.getElementsByTagName('div')[0].getElementsByTagName('img')[%ld].alt='%@'",(long)j,self.saveFidArr[i]];
                    [self.webView  stringByEvaluatingJavaScriptFromString:imgFid];
                }
            }
        }
        if ([fileName hasSuffix:@"mp4"]) {
            
            //视频
            NSString *typeVideoStr = nil;
            NSInteger videoNum = [self.webView  stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('div')[0].getElementsByTagName('video').length"].integerValue;
            
            for (NSInteger m = 0; m < videoNum;m++) {
                NSString *imgUrl = [self.webView  stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.getElementsByTagName('div')[0].getElementsByTagName('video')[%ld].src",(long)m]];
                NSArray *imgTempArr = [imgUrl componentsSeparatedByString:@"/"];
                NSString *fileNameImg = [imgTempArr lastObject];
                if ([fileName isEqualToString:fileNameImg]) {
#warning message src.img
                    NSString *imgUrl = [NSString stringWithFormat:@"document.getElementsByTagName('div')[0].getElementsByTagName('video')[%ld].src='%@'",(long)m,self.saveFileArr[i]];
                    [self.webView  stringByEvaluatingJavaScriptFromString:imgUrl];
                    //换成现在的Fid
                    NSString *fidUrl = [NSString stringWithFormat:@"document.getElementsByTagName('div')[0].getElementsByTagName('video')[%ld].id='%@'",(long)m,self.saveFidArr[i]];
                    [self.webView  stringByEvaluatingJavaScriptFromString:fidUrl];
                    
                }
            }
            
        }
        //音频
        //录音
        if ([fileName hasSuffix:@"mp3"]) {
            
            NSString *typeAudioStr = nil;
            NSInteger audionNum = [self.webView  stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('div')[0].getElementsByTagName('audio').length"].integerValue;
            for (__block NSInteger h = 0; h < audionNum;h++) {
                NSString *imgUrl = [self.webView  stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.getElementsByTagName('div')[0].getElementsByTagName('audio')[%ld].src",(long)h]];
                NSArray *imgTempArr = [imgUrl componentsSeparatedByString:@"/"];
                
                
                NSString *fileNameImg = [imgTempArr lastObject];
                if ([fileName isEqualToString:fileNameImg]) {
                    NSString *imgUrl = [NSString stringWithFormat:@"document.getElementsByTagName('div')[0].getElementsByTagName('audio')[%ld].src='%@'",(long)h,self.saveFileArr[i]];
                    [self.webView  stringByEvaluatingJavaScriptFromString:imgUrl];
                    
                    NSString *fidUrl = [NSString stringWithFormat:@"document.getElementsByTagName('div')[0].getElementsByTagName('audio')[%ld].id='%@'",(long)h,self.saveFidArr[i]];
                    [self.webView  stringByEvaluatingJavaScriptFromString:fidUrl];
                }
                
            }
            
        }
    }
    [self upLoadNoteContent];
}
//上传笔记内容
-(void)upLoadNoteContent{
    NSLog(@"%@",self.textViewText);
    if (self.textViewText.length == 0) {
        [self.view makeToast:@"维修内容不能为空"];
        return;
    }
    if ([self.titleId isEqualToString:@"2"]) {
        NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
        NSTimeInterval a=[dat timeIntervalSince1970];
        NSString *timeString = [NSString stringWithFormat:@"%f",a];
        self.time111 = timeString;
    }else{
    if ([self.labTime.text isEqualToString:@"请选择时间"]) {
        [self.view makeToast:@"请选择预约时间"];
        return;
    }
    }
//    NSString *jsToGetHTMLSource = @"document.getElementsByTagName('html')[0].innerHTML";
//    NSString *HTMLSource = [self.webView stringByEvaluatingJavaScriptFromString:jsToGetHTMLSource];
//    [self.textView resignFirstResponder];
    
    

    
//    NSString *jsDivGetHTMLSource = @"document.getElementsByTagName('div')[0].innerHTML";
//    NSString *HTMLSource2 = [self.webView stringByEvaluatingJavaScriptFromString:jsDivGetHTMLSource];
    
    NSLog(@"%@",self.time111);
    
#warning message
//    NSLog(@"%@",HTMLSource2);
    
    
//    NSMutableString *fidString = [NSMutableString stringWithCapacity:0];
//    for (NSInteger i = 0; i < self.numArr.count; i++) {
//        [fidString appendString:self.numArr[i]];
//        if (i < self.numArr.count - 1) {
//            [fidString appendString:@","];
//        }
//    }
    NSLog(@"%@",[TranlateTime returnImageNameDate]);
    //保存笔记
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    manger.requestSerializer = [[AFHTTPRequestSerializer alloc] init];
    manger.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/json",@"text/html",@"application/json",nil];
    NSString *urlStr = [NSString stringWithFormat:UPLOADPROERTYCONTENT,self.classification,self.baseType,[StoreageMessage getMessage][2],self.time111.longLongValue * 1000,self.uuid,[StoreageMessage getCommuntityId],[self.textViewText urlEncodeString] ,self.addressId];
    NSLog(@"%@",urlStr);
//    MAININTERFACE@"serviceServlet?serviceName=PropertyService&medthodName=propertyReleaseInfo&classification=%@&baseType=%@@&memberId=%@&reservationTime=%@&uuid=%@&xqid=%@&repairContent=%@"
//    http://211.152.8.99/360duang/serviceServlet?serviceName=PropertyService&medthodName=releaseHistoryList&classification=1&baseType=2&memberId=26227
    urlStr = [NSString stringWithFormat:UPLOADPROERTYCONTENT,self.classification,self.baseType,[StoreageMessage getMessage][2],self.time111.longLongValue* 1000,self.uuid,[StoreageMessage getCommuntityId],[[self.textViewText urlEncodeString] urlEncodeString],self.addressId];
    NSLog(@"%@",self.time111);
//#warning message
//    NSLog(@"%@",self.itemModel.title);
//    NSString *tempStr = [StoreageMessage getSchoolUrl];
//    if (![tempStr isEqualToString:TIANQINGONG] && [tempStr isEqualToString:TIANQINGOLD]) {
//        tempStr = TIANQINGONG;
//    }
//#warning message
//    NSLog(@"%@",tempStr);
//    if (self.itemModel.title.length == 0) {
//        //urlStr = [NSString stringWithFormat:STUDY_SAVENOTE,@"",[HTMLSource2 urlEncodeString],[StoreageMessage getMessage][0],self.courseId,@"",@"",fidString,[StoreageMessage getMessage][2]];
//        urlStr = [NSString stringWithFormat:STUDY_SAVENOTE,tempStr,@"",[HTMLSource2 urlEncodeString],[StoreageMessage getMessage][0],self.courseId,@"",@"",fidString,[StoreageMessage getMessage][2]];
//    }else{
//        //urlStr = [NSString stringWithFormat:STUDY_SAVENOTE,@"",[HTMLSource2 urlEncodeString],[StoreageMessage getMessage][0],self.courseId,self.itemModel.mid,self.itemModel.item_id,fidString,[StoreageMessage getMessage][2]];
//        urlStr = [NSString stringWithFormat:STUDY_SAVENOTE,tempStr,@"",[HTMLSource2 urlEncodeString],[StoreageMessage getMessage][0],self.courseId,self.itemModel.mid,self.itemModel.item_id,fidString,[StoreageMessage getMessage][2]];
//    }
#warning message urlStr
//    NSLog(@"urlStr:%@",urlStr);
    [self makeHUd];
    [manger GET:urlStr parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [StoreageMessage getErrorMessage:@"NULL" fromUrl:urlStr];

        [self hudWasHidden:self.hudProgress];
        NSLog(@"%@",responseObject);
        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"111%@",dict);
        if ([dict[@"success"] isEqualToString:@"yes"]) {
#warning message dict
//            NSLog(@"%@",dict);
           // [[IQKeyboardManager sharedManager] keyboardAppearance] = NO;
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"提交成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
            [alertView show];
            if ([self.target isKindOfClass:[ProertyMendAndServerListViewController class]]) {
                for (UIViewController *controller in self.navigationController.viewControllers) {
                    if ([controller isKindOfClass:[ProertyMendSeverViewController class]]) {
                        [self.navigationController popToViewController:controller animated:YES];
                    }
                }
            }
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"提交失败" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
            [alertView show];
        }
                self.commitBtn.userInteractionEnabled = YES;

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"%@",error);
                [self hudWasHidden:self.hudProgress];
        self.commitBtn.userInteractionEnabled = YES;
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"警告" message:@"网络不流畅，请换个网络试试" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
        [alertView show];
        //        return ;
    }];
//    [manger POST:urlStr parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
//        
//        NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//#warning message str
//        NSLog(@"%@",str);
//        if (![str isEqual:@"false"]) {
//            self.messageLable.text = @"提交笔记成功";
//            for (id temp in self.messageView.subviews) {
//                [temp removeFromSuperview];
//            }
//            [self.messageView removeFromSuperview];
//            self.messageView = nil;
//            self.leftBtn.userInteractionEnabled = YES;
//            [self gainSource];
//            [self reloadWebView];
//            return ;
//        }else{
//            self.leftBtn.userInteractionEnabled = YES;
//            self.messageLable.text = @"提交笔记失败";
//            for (id temp in self.messageView.subviews) {
//                [temp removeFromSuperview];
//            }
//            [self.messageView removeFromSuperview];
//            self.messageView = nil;
//            self.leftBtn.userInteractionEnabled = YES;
//            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"提交笔记失败，请重试" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
//            [alertView show];
//            return ;
//        }
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"%@",[error description]);
//        self.leftBtn.userInteractionEnabled = YES;
//        self.messageLable.text = @"提交任务失败";
//        for (id temp in self.messageView.subviews) {
//            [temp removeFromSuperview];
//        }
//        [self.messageView removeFromSuperview];
//        self.messageView = nil;
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"警告" message:@"网络不流畅，请换个网络试试" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
//        [alertView show];
//        return ;
//    }];
}
//查看源码
-(void)gainSource{
    //    NSString *jsToGetHTMLSource = @"document.getElementsByTagName('html')[0].innerHTML";
    //    NSString *content = [self.webView stringByEvaluatingJavaScriptFromString:jsToGetHTMLSource];
    
}
//重新加载
-(void)reloadWebView{
    //    <meta http-equiv="Content-Type" content="textml; charset=utf-8">
    //    <meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0;" name="viewport" />
    //
    //    <meta content="yes" name="apple-mobile-web-app-capable" />
    //
    //    <meta content="black" name="apple-mobile-web-app-status-bar-style" />
    //
    //    <meta content="telephone=no" name="format-detection" />
    self.htmlStr = @"<html><head><meta content=\"width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0;\" name=\"viewport\" /><meta content=\"yes\" name=\"apple-mobile-web-app-capable\" /><meta content=\"black\" name=\"apple-mobile-web-app-status-bar-style\" /><meta content=\"telephone=no\" name=\"format-detection\" /><script type=\"text/javascript\">function inserthtml(str) { var idEdit = document.getElementByName('editor');idEdit.innerHTML += str;}</script></head><body><div class=\"editor\" name=\"editor\" contenteditable=\"true\"  width=\"100%\" height=\"100%\"></div><body></html>";
    [self.webView loadHTMLString:self.htmlStr baseURL:nil];
}
#pragma mark 以上为解析图片、文字、音频、视频
//makeDatePicker
-(void)makeDatePicker{
    UIDatePicker *datePick = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, HEIGHT_CONTROLLER - 250 * self.numSingleVesion, WIDTH_CONTROLLER, 200 * self.numSingleVesion)];
    [datePick addTarget:self action:@selector(datePickDown) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:datePick];
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:NSTimeIntervalSince1970];
    [datePick setMinimumDate:date];
    self.datePicker = datePick;
    datePick.hidden = YES;
    
    

    //datePick.datePickerMode = UIDatePickerModeCountDownTimer;

    // Do any additional setup after loading the view, typically from a nib.
}
-(void)datePickDown{
    NSDate *select = [self.datePicker date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateAndTime = [dateFormatter stringFromDate:select];
//    self.textField.text = dateAndTime;
    NSDate* date11 = [dateFormatter dateFromString:dateAndTime];
    NSTimeInterval a=[date11 timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%ld", (long)a];
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timeString.integerValue];
    NSString *confromTimespStr = [dateFormatter stringFromDate:confromTimesp];
    NSLog(@"confromTimespStr =  %@",confromTimespStr);
    
//    NSString *nowtimeStr = [dateFormatter stringFromDate:date11];//----------将nsdate按formatter格式转成nsstring
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[date11 timeIntervalSince1970]];
    NSLog(@"%@--%@---%@",timeString,dateAndTime,timeSp);
    self.time111 = timeString;
    self.labTime.text = dateAndTime;
//    NSLog(@"%@",dateAndTime);
}
//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
//    self.datePicker.hidden = YES;
//}



-(void)makeTextViewAndPhoto{
    
    NSInteger height1 = 64 + 141 * self.numSingleVesion;
    if ([self.titleId isEqualToString:@"2"]) {
        height1 = 64 + 100 *self.numSingleVesion;
    }
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(8 * self.numSingleVesion, 8 * self.numSingleVesion + height1, WIDTH_CONTENTVIEW - 16 * self.numSingleVesion, 20 * self.numSingleVesion)];
    lab.text = @"下方可输入文字内容:";
    lab.font = [UIFont systemFontOfSize:14];
    lab.textColor = [UIColor lightGrayColor];
    [self.view addSubview:lab];
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(8 * self.numSingleVesion, 8 * self.numSingleVesion + height1 + 20, WIDTH_CONTENTVIEW - 16 * self.numSingleVesion, 100 * self.numSingleVesion)];
    textView.delegate = self;
    [self.view addSubview:textView];
    
    UILabel *lab1 = [[UILabel alloc] initWithFrame:CGRectMake(8 * self.numSingleVesion, (8 + 20 + 100) * self.numSingleVesion + height1, WIDTH_CONTENTVIEW - 16 * self.numSingleVesion, 20 * self.numSingleVesion)];
    lab1.text = @"添加照片:";
    lab1.font = [UIFont systemFontOfSize:14];
    lab1.textColor = [UIColor lightGrayColor];
    [self.view addSubview:lab1];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0 * self.numSingleVesion, (8 + 40 + 100) * self.numSingleVesion + height1, WIDTH_CONTENTVIEW - 16 * self.numSingleVesion, 100 * self.numSingleVesion)];
//    view.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:view];
    self.photoView = view;
    [self initHeaderView];
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(NSMutableArray *)imagePickerArray
{
    if (!_imagePickerArray) {
        _imagePickerArray = [[NSMutableArray alloc]init];
    }
    return _imagePickerArray;
}

#define pictureHW (screenWidth - 5*padding)/4
#define MaxImageCount 4
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
        dele.frame = CGRectMake(pictureHW - deleImageWH + 5, -10, deleImageWH, deleImageWH);
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
    
//    self.photoHeight.constant = 10+ (10 + pictureHW)*([self.imagePickerArray count]/4 + 1);
    
}


-(void)addPicture{
    [self initImagePickerChooseView];
}

#pragma mark - gesture method
-(void)tapImageView:(UITapGestureRecognizer *)tap
{
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


//-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
//    
//    
//}

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


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.datePicker.hidden = YES;
    [_textView endEditing:YES];
    [_textView resignFirstResponder];
//    [self.textField resignFirstResponder];
    [self.webView endEditing:YES];
    
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
