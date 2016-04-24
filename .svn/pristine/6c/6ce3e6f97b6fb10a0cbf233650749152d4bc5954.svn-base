//
//  Interface.h
//  XiaomiIOs
//
//  Created by linghang on 15-3-3.
//  Copyright (c) 2015年 wangjian. All rights reserved.
//

#ifndef XiaomiIOs_Interface_h
#define XiaomiIOs_Interface_h
//#define MAININTERFACE @"http://211.152.8.99/360duang/"
#define MAININTERFACE @"http://www.360duang.net/"
//获取城市接口


//主界面
#define MAINUIDATA MAININTERFACE@"360du/menu.html"
//主界面
#define MAINVIEWCOMMINUTITADDRESS MAININTERFACE@"360duang/serviceServlet?serviceName=HomeService&medthodName=getHomePage&xqid=%@"
//滚动图
#define MAINSCRFIRSR MAININTERFACE@"serviceServlet?serviceName=AdvertisingService&medthodName=adBroadcast&xqid=%@"
//底部按钮
//个人中心
#define MEMBERCENTER MAININTERFACE@"?serviceName=dlshopmag&medthodName=personalInfo&memberID=%@"
//订单
#define ORDER MAININTERFACE@"serviceServlet?serviceName=UGoshoppingcar&medthodName=order&memberID=%@&gotoPage=%ld&pageSize=%ld"
//订单详情
#define ORDERDETAILDETAIL MAININTERFACE@"serviceServlet?serviceName=UGoshoppingcar&medthodName=orderlist&orderid=%@"
//订单状态列表
#define ORDERSTATUSSTATUS MAININTERFACE@"serviceServlet?serviceName=UGoshoppingcar&medthodName=orderInfoStatus&orderID=%@"
//取消订单
#define ORDERCANCEL MAININTERFACE@"serviceServlet?serviceName=CourierService&medthodName=cancleOrder&orderId=%@"
//添加评价
//http://211.152.8.99/360duang/serviceServlet?serviceName=findmap&medthodName=adduserpl&did=38&uid=26223&starcount=3&pingjia=手机卡了卡了&
#define ORDERADDEVALUATE MAININTERFACE@"serviceServlet?serviceName=findmap&medthodName=adduserpl&did=%@&uid=%@&starcount=%@&pingjia=%@&orderid=%@"
#pragma mark 个人中心中得UIScrollview
//全部快单
//http://211.152.8.99/360duang/serviceServlet?serviceName=CourierService&medthodName=allList
#define ORDERCENTERALL MAININTERFACE@"serviceServlet?serviceName=CourierService&medthodName=allList"
//我的快单，isSended是否送达状态  1：已完成  2：未完成
//http://211.152.8.99/360duang/serviceServlet?serviceName=CourierService&medthodName=myCourierList&memberId=26227&isSended=2
#define MINEORDERCENTER MAININTERFACE@"serviceServlet?serviceName=CourierService&medthodName=myCourierList&memberId=%@&isSended=%@"
//赶快抢
//http://211.152.8.99/360duang/serviceServlet?serviceName=CourierService&medthodName=timingGrabList&memberId=26227&expressId=4
#define ATONCEROBORDER MAININTERFACE@"serviceServlet?serviceName=CourierService&medthodName=timingGrabList&memberId=%@&expressId=%@"
//自动抢
//http://211.152.8.99/360duang/serviceServlet?serviceName=CourierService&medthodName=automaticGrabBusinessList&memberId=26227
#define AUTOROBORDER MAININTERFACE@"serviceServlet?serviceName=CourierService&medthodName=automaticGrabBusinessList&memberId=%@"
//快来抢
//serviceServlet?serviceName=CourierService&medthodName=comeOnGrabList&memberId=26227
#define QUICKROBORDER MAININTERFACE@"serviceServlet?serviceName=CourierService&medthodName=comeOnGrabList&memberId=%@"

//快来抢按钮
//http://211.152.8.99/360duang/serviceServlet?serviceName=CourierService&medthodName=comeOnGrabButton&memberId=26227&expressId=20
#define QUICJROBORDERBTN MAININTERFACE@"serviceServlet?serviceName=CourierService&medthodName=comeOnGrabButton&memberId=%@&expressId=%@"
//顺路快单
//http://211.152.8.99/360duang/serviceServlet?serviceName=CourierService&medthodName=incidentallyList&memberId=26227&location=39.8766600000,116.4634490000
#define ONTHEWAYROBORDER MAININTERFACE@"serviceServlet?serviceName=CourierService&medthodName=incidentallyList&memberId=%@&location=%@"
//快递掌柜申请接口
//http://211.152.8.99/360duang/serviceServlet?serviceName=WebServiceMag&medthodName=KuaiDiZhangGuiApplication
#define ORDERMANGERAPPLYINTERFACE MAININTERFACE@"serviceServlet?serviceName=WebServiceMag&medthodName=KuaiDiZhangGuiApplication"
//申请小区抢单
//http://211.152.8.99/360duang/serviceServlet?serviceName=CourierService&medthodName=xqlist&location=116.420461,40.016373&memberId=26227
#define APPLYCOMMOTROBORDER MAININTERFACE@"serviceServlet?serviceName=CourierService&medthodName=xqlist&location=%@&memberId=%@"
//小区数据,本市小区
//&cityName=北京市&location=116.459776,39.869331&gotoPage=1&pageSize=4
#define COMMUNITYDATA MAININTERFACE@"serviceServlet?serviceName=findmap&medthodName=xqlist&cityName=%@&location=%@&gotoPage=%ld&pageSize=%ld"
//城市数据
//http://211.152.8.99/360duang
#define GAINCITY MAININTERFACE@"serviceServlet?serviceName=findmap&medthodName=findcity"
#define CITYDATA MAININTERFACE@"serviceServlet?serviceName=findmap&medthodName=findcity&BranchCode=%@"
//商家列表
#define MERCHANTLIST MAININTERFACE@"serviceServlet?serviceName=dlshopmag&medthodName=dlshoplist&codename=%@&xqid=%ld&sort=%ld&gotoPage=%ld&pageSize=%ld&twoType=%@&fuliType=%@"
//商家列表4个btn按钮
//分类
#define MERCHANTLISTCATEGORY MAININTERFACE@"/serviceServlet?serviceName=dlshopmag&medthodName=prosc&scname=2"
//排序
#define MERCHANTLISTSORT MAININTERFACE@"serviceServlet?serviceName=Sort&medthodName=sort"
//福利
#define MERCHANTLISTWELFARE MAININTERFACE@"/serviceServlet?serviceName=dlshopmag&medthodName=profili"
//商家详情
#define MERCHANTLISTDEATIL MAININTERFACE@"/serviceServlet?serviceName=dlshopmag&medthodName=zddlmagTail&DID=%@"
//商家产品列表
//http://211.152.8.99/360duang/serviceServlet?serviceName=dlshopmag&medthodName=dlsprolist&did=68

#define MERCHANTGOODSLIST MAININTERFACE@"serviceServlet?serviceName=dlshopmag&medthodName=dlsprolist&did=%@"
//商家产品详情
//http://211.152.8.99/360duang/serviceServlet?serviceName=dlshopmag&medthodName=productlist&productID=1449

#define MERCHANTPRODUCTDETAIL MAININTERFACE@"serviceServlet?serviceName=dlshopmag&medthodName=productlist&productID=%@"
//商家评价
//http://211.152.8.99/360duang/serviceServlet?serviceName=dlshopmag&medthodName=plList&type=2&DID=68&gotoPage=1&pageSize=2
#define MERCHANTEVALUATE MAININTERFACE@"/serviceServlet?serviceName=dlshopmag&medthodName=plList&type=%@&DID=%@&gotoPage=%ld&pageSize=%ld"
//收藏按钮
#define COLLECTMERCHANT MAININTERFACE@"/serviceServlet?serviceName=webService&medthodName=usershoucang&did=%@&uid=%@"
//查看商家是否收藏
#define ISORNOTFAVORITEMERCHANT MAININTERFACE@"serviceServlet?serviceName=dlshopmag&medthodName=userIsCollectShop&memberId=%@&did=%@"
//#define MERCHANTLISTCOMMUNITYDATA MAININTERFACE@"/serviceServlet?serviceName=dlshopmag&medthodName=prosc&scname=1"
//收藏列表
#define COLLECTPERSONALLIST MAININTERFACE@"serviceServlet?serviceName=dlshopmag&medthodName=userCollectList&memberId=%@&gotoPage=%ld&pageSize=%ld"
//确认下单
#define CONFIRMORDER MAININTERFACE@"serviceServlet?serviceName=UGoshoppingcar&medthodName=userorder&memberID=%@&did=%@&SendEndDate=%@&addressID=%@&PaymentType=%@&faPiao=%@&remark=%@"
//添加地址接口,小区ID和经纬度可以不写
#define ADDADDRESS MAININTERFACE@"serviceServlet?serviceName=MyAccountXmlGenerator&medthodName=addressAddJson&MemberID=%@&name=%@&sex=%@&xqName=%@&xqLocation=%@&address=%@&phone=%@"
//地址列表
#define ADDRESSLIST MAININTERFACE@"serviceServlet?serviceName=MyAccountXmlGenerator&medthodName=addressJson&MemberID=%@&gotoPage=%ld&pageSize=%ld"
//删除地址列表
#define DELEGATEADDRESS MAININTERFACE@"serviceServlet?serviceName=MyAccountXmlGenerator&medthodName=addressDelJson&MemberID=%@&addressID=%@"
//http://211.152.8.99/360duang/serviceServlet?serviceName=MyAccountXmlGenerator&medthodName=addressSetIsDefault&memberID=1481&addressId=215&isDefault=Y
//设置默认
#define DEFAULTADDRESS MAININTERFACE@"serviceServlet?serviceName=MyAccountXmlGenerator&medthodName=addressSetIsDefault&memberID=%@&addressId=%@&isDefault=Y"
//http://211.152.8.99/360duang/serviceServlet?serviceName=MyAccountXmlGenerator&medthodName=addressDelJson&MemberID=2239&addressID=4772

//http://211.152.8.99/360duang/serviceServlet?serviceName=MyAccountXmlGenerator&medthodName=addressAddJson&memberID=26227&name=小孙&sex=先生&xqName=京瑞大厦&xqLocation=39.8753380000,116.4663650000&address=北京市朝阳区十里河京瑞大厦&phone=0105221111
//支付方式优惠
#define PAYMENTPRELIVIAGE MAININTERFACE@"serviceServlet?serviceName=UGoshoppingcar&medthodName=paymentAndCoupons&memberId=%@&did=%@"
//购物车
//用户编号MemberID，商家编号dID，清空购物车
#define CLEARALLFOODCAR MAININTERFACE@"serviceServlet?serviceName=xmlGenerator&medthodName=deleteShoppingCar&MemberID=%@&dID=%@"
//加入购物车
//http://211.152.8.99/360duang/serviceServlet?serviceName=xmlGenerator&medthodName=addShoppingCar&MemberID=26227&productID=1472&dID=1&count=1&rlid=30

#define JOINFOODCAR MAININTERFACE@"serviceServlet?serviceName=xmlGenerator&medthodName=addShoppingCar&MemberID=%@&productID=%@&dID=%@&count=%ld&rlid=%ld"
//送餐时间表
//http://211.152.8.99/360duang/serviceServlet?serviceName=dlshopmag&medthodName=wmtimelist&did=1
#define GIVEFOODTIMELIST MAININTERFACE@"serviceServlet?serviceName=dlshopmag&medthodName=wmtimelist&did=%@"
//添加所有购物车
//http://211.152.8.99/360duang/serviceServlet?serviceName=xmlGenerator&medthodName=addOrdersToShoppingCar&goodsCars=[{"productID":"1445","memberID":"1234","dID":"1","count":"10"},{"productID":"1473","memberID":"1234","dID":"6","count":"10","rlid":"%25E5%25A4%25A7%25E8%25B1%25A1%25E7%259A%2584"}]
#define AddAllGoodsCar MAININTERFACE@"serviceServlet?serviceName=xmlGenerator&medthodName=addOrdersToShoppingCar&memberID=%@&dID=%@&goodsCars=%@"
//请求购物车数据
//http://211.152.8.99/360duang/serviceServlet?serviceName=xmlGenerator&medthodName=goshoppingjiegou&MemberID=123&dID=1

#define LAODGOODSCAR MAININTERFACE@"serviceServlet?serviceName=xmlGenerator&medthodName=goshoppingjiegou&MemberID=%@&dID=%@"
//物业
//物业列表
#define PROERTYLIST MAININTERFACE@"360du/wuye_data.json"
//维修服务、问题反馈
#define PEOERTYLISTMENDANDSERVEANDQUESTONCOMMIT MAININTERFACE@"serviceServlet?serviceName=PropertyService&medthodName=propertyRepair&classification=%ld"
#define PEOERTYMENDANDSERVEANDQUESTUIONLIST MAININTERFACE@"serviceServlet?serviceName=PropertyService&medthodName=releaseHistoryList&classification=%ld&baseType=%ld&memberId=%@"
//维修详情
//http://211.152.8.99/360duang/serviceServlet?serviceName=PropertyService&medthodName=viewReleaseDetail&pbID=20150630044700001
#define PEOERTYMENDDEATIL MAININTERFACE@"serviceServlet?serviceName=PropertyService&medthodName=viewReleaseDetail&pbID=%@"
//中水缴费地址列表
//http://211.152.8.99/360duang/serviceServlet?serviceName=
//PaymentWater&medthodName=addressList&memberID=26227
#define PROERTYMIDLLEPAYADDRESSLIST MAININTERFACE@"serviceServlet?serviceName=PaymentWater&medthodName=addressList&memberID=%@"
//去交费的钱数
#define PROERTYMONEY MAININTERFACE@"serviceServlet?serviceName=PaymentWater&medthodName=payFee&xhid=%@&AccountTime=%@"
//用户默认缴费信息
//http://211.152.8.99/360duang/serviceServlet?serviceName=PaymentWater
//&medthodName=addressSetIsDefault&memberID=26227&hmid=3&isDefault=y
#define PERSONALDEFAULTPAYPERSONAL MAININTERFACE@"serviceServlet?serviceName=PaymentWater&medthodName=addressSetIsDefault&memberID=%@&hmid=%@&isDefault=y"
//添加缴费用户信息
#define PROERTYADDPERSONALINFORAMTION MAININTERFACE@"serviceServlet?serviceName=PaymentWater&medthodName=addWaterAddress&nickName=%@&xqID=%@&wyBranchcode=%@&phone=%@&memberID=%@&xhID=%@"
//修改缴费用户信息
//http://211.152.8.99/360duang/serviceServlet?serviceName=PaymentWater&medthodName=updateAddress&hmid=201508180001&nickName=爸妈家&xqID=86420010000009&wyBranchcode=86440000017&phone=155151511&memberID=26227&xhID=3

#define PROERTYMENDPERSONALINFORMATION MAININTERFACE@"serviceServlet?serviceName=PaymentWater&medthodName=updateAddress&hmid=%@&nickName=%@&xqID=%@&wyBranchcode=%@&phone=%@&memberID=%@&xhID=%@"
//http://211.152.8.99/360duang/serviceServlet?serviceName=PaymentWater&medthodName=addWaterAddress&nickName=我家&xqID=86420010000009&wyBranchcode=86440000017&phone=14714151521&memberID=26227&xhID=3
//删除缴费用户
//http://211.152.8.99/360duang/serviceServlet?serviceName=PaymentWater&medthodName=delAddress&hmid=201508140007

#define PROERTYDELGATEPERSONALINFORMATION MAININTERFACE@"serviceServlet?serviceName=PaymentWater&medthodName=delAddress&hmid=%@"
//详细地址
#define PROERTYADDRESSDEATIL MAININTERFACE@"serviceServlet?serviceName=PaymentWater&medthodName=gethouseNo&xqBranchcode=%@&builde=%@&UnitNo=%@&houseNo=%@"
//历史缴费记录

#define PROERTYHISTORYPAYMONEY MAININTERFACE@"serviceServlet?serviceName=PaymentWater&medthodName=historyAccountTime&memberID=%@"
//http://211.152.8.99/360duang/serviceServlet?serviceName=PaymentWater&medthodName=gethouseNo&xqBranchcode=86420010000004&builde=1&UnitNo=2&houseNo=102
//物业费查询需要缴费
#define PROERTYPAYQUERY MAININTERFACE@"serviceServlet?serviceName=PropertyCosts&medthodName=queryNeedPayInfo&memberId=%@"
//物业费去缴费按钮
#define PROERTYGOTOPAYBUTTON MAININTERFACE@"serviceServlet?serviceName=PropertyCosts&medthodName=addToWYFeeCar&buildNo=%@&unitNo=%@&houseNo=%@&startDate=%@&endDate=%@&memberId=%@&xqid=%@&wyBranchCode=%@"
//物业费-缴费接口
#define PROERTYPAYMENT MAININTERFACE@"serviceServlet?serviceName=PropertyCosts&medthodName=paymentWyFee&memberId=%@&carid=%@"
//物业费-查询缴费历史记录
#define PROERTYPAYQUERYHISTORY MAININTERFACE@"serviceServlet?serviceName=PropertyCosts&medthodName=historyWYFRecord&hmid=%@&status=%@"
//物业公告
#define PROERTYNOTICE MAININTERFACE@"serviceServlet?serviceName=PropertyService&medthodName=announcement&xqid=%@"
//常用电话
#define PROERTYUSUALTEL MAININTERFACE@"serviceServlet?serviceName=PropertyService&medthodName=commonPhone&xqid=%@"
//上传图片、音频、视频等附件
#define UPLOADPHOTOANDVOICEANDVIDEO MAININTERFACE@"serviceServlet?serviceName=PropertyService&medthodName=uploadAccessory2"
//上传物业修理信息
//http://211.152.8.99/360duang/serviceServlet?serviceName=PropertyService&medthodName=propertyReleaseInfo&classification=1&baseType=2&memberId=26227&reservationTime=2015-6-3015:57:45&uuid=11111111111111111&xqid=86420010000004&repairContent=测试内容，这里暂时没有图片，没有视频，没有音频，只有这个测试数据
#define UPLOADPROERTYCONTENT MAININTERFACE@"serviceServlet?serviceName=PropertyService&medthodName=propertyReleaseInfo&classification=%@&baseType=%@&memberId=%@&reservationTime=%@&uuid=%@&xqid=%@&repairContent=%@&addressId=%@"
//物业小区列表
#define PROERTYCOMMITLIST MAININTERFACE@"serviceServlet?serviceName=PaymentWater&medthodName=WyXqList2&cityName=%@"

//领券中心
#define GETPRIVEILAGECENTER MAININTERFACE@"serviceServlet?serviceName=CouponService&medthodName=getAllCoupons"
//我的优惠中心
//http://211.152.8.99/360duang/serviceServlet?serviceName=CouponService&medthodName=mineCoupons
// 分为三种情况： 1、未使用;2、已使用;3、已过期

#define MINEPRIVEILAGECNETER MAININTERFACE@"serviceServlet?serviceName=CouponService&medthodName=mineCoupons&memberId=%@&useStatus=%@"
//领取券
#define GAINMINEPRIVEILAGE MAININTERFACE@"serviceServlet?serviceName=CouponService&medthodName=receiveCoupon&memberId=%@&yhclid=%@&location=%@"
//下单可用优惠接口查询
#define CONFIRMORDERPRIVEILAGEQUERY MAININTERFACE@"serviceServlet?serviceName=CouponService&medthodName=orderCanUserCoupons&memberId=%@&did=%@"

//登陆接口
#define LOGIN MAININTERFACE@"serviceServlet?serviceName=WebServiceMag&medthodName=loginjk&MemberCode=%@&Password=%@"
//http://211.152.8.99/360duang/serviceServlet?serviceName=WebServiceMag&medthodName=loginjk&MemberCode=123&Password=12345
//注册接口
#define REGISTER MAININTERFACE@"serviceServlet?serviceName=webService&medthodName=doRegist&mobile=%@&password=%@&registerCode=%@"
//http://211.152.8.99/360duang/serviceServlet?serviceName=webService&medthodName=doRegist&mobile=17746536125&password=123456&registerCode=1234

//短信接口
#define MESSAGE MAININTERFACE@"serviceServlet?serviceName=Register&medthodName=saveSecurityCode&phoneCode=%@&securityCode=%ld"
//http://211.152.8.99/360duang/serviceServlet?serviceName=Register&medthodName=saveSecurityCode&phoneCode=15201008905&securityCode=5219
//忘记密码
//http://211.152.8.99/360duang/serviceServlet?serviceName=Register&medthodName=lookingYourPasswrod&phone=123456789
#define FORGETPASSWORD MAININTERFACE@"serviceServlet?serviceName=Register&medthodName=lookingYourPasswrod&phone=%@"
//商家登陆
#define MERCHANTLOGIN MAININTERFACE@"serviceServlet?serviceName=BusinessService&medthodName=businessLogin&userName=%@&password=%@&memberId=%@"
//订单处理
#define MERCHANTORDERDEAL MAININTERFACE@"serviceServlet?serviceName=BusinessService&medthodName=orderList&did=%@&status=%@&pageNum=%ld&pageSize=5"
//取消订单
#define CANCELORDERMERCAHNT MAININTERFACE@"serviceServlet?serviceName=CourierService&medthodName=cancleOrder&orderId=%@"
//确认订单
#define CONFIRMORDERMERCHANT MAININTERFACE@"serviceServlet?serviceName=BusinessService&medthodName=confireOrder&orderId=%@"
//配送方式列表
#define DELIVERYLISTORDERMERCHANT MAININTERFACE@"serviceServlet?serviceName=BusinessService&medthodName=sendBusinessList&did=%@&orderId=%@"
//配送订单接口

#define DELIVEETORDERMERCHANT MAININTERFACE@"serviceServlet?serviceName=BusinessService&medthodName=sendOrder&orderId=%@&sendType=%@"
//意见反馈
#define OPINONFEEDBACK MAININTERFACE@"serviceServlet?serviceName=FeedBackService&medthodName=submitFeedBackContent&memberId=%@&feed_content=%@&feed_contact=%@"
//团购列表
#define GROUPPURCHASECENTER MAININTERFACE@"serviceServlet?serviceName=CentralPurchService&medthodName=findCentralPurchList"
//团购规格
#define GROUPPURCHASESPECIFICATION MAININTERFACE@"serviceServlet?serviceName=CentralPurchService&medthodName=getProductSpecification&cpid=%@"
//团购商品增加或者减少
#define GROUPPURCHASEADDGOODORPLUSGOODS MAININTERFACE@"serviceServlet?serviceName=CentralPurchService&medthodName=operateNumber&cpid=%@&memberId=%@&count=%@&pid=%@"
//获取用户下单信息

#define GROUPGAINORDERINFORMATION MAININTERFACE@"serviceServlet?serviceName=CentralPurchService&medthodName=getUserBuyProductData&memberId=%@&cpid=%@"
//submitOrder
#define GROUPSUNMITORDER MAININTERFACE@"serviceServlet?serviceName=CentralPurchService&medthodName=submitShoppingOrder&memberId=%@&cpid=%@&addressId=%@"
//我的团购
#define MINEGROUPBUY MAININTERFACE@"serviceServlet?serviceName=CentralPurchService&medthodName=queryOrdersbyDiffType&memberId=%@&orderStatus=%@"
//停车收费
//http://www.360duang.net/360duang/serviceServlet?serviceName=CarPark&medthodName=
//getPayFeeCard&c_Pai=京H88888&xqID=86420010000004
//查询车牌号
#define PARKINGQUERY MAININTERFACE@"serviceServlet?serviceName=CarPark&medthodName=getPayFeeCard&c_Pai=%@&xqID=%@"
//停车缴费
//http://www.360duang.net/360duang/serviceServlet?serviceName=CarPark&medthodName=
//carParkOrder&id=14&payTime=1&payTimeType=mont h&memberID=26298&xqid=86420010000004
#define PARKINGPAY MAININTERFACE@"serviceServlet?serviceName=CarPark&medthodName=carParkOrder&id=%@&payTime=%@&payTimeType=%@&memberID=%@&xqid=%@"
//停车缴费历史记录
//http://www.360duang.net/360duang/serviceServlet?serviceName=CarPark&medthodName=
//payCarPaymentList&memberID=26298&xqID=86420010000004&pageSize=10&pageNum=1
#define PARKINGPAYHOSTIORY MAININTERFACE@"serviceServlet?serviceName=CarPark&medthodName=payCarPaymentList&memberID=%@&xqID=%@&pageSize=10&pageNum=%ld"
//停车头部历史
//http://www.360duang.net/360duang/serviceServlet?serviceName=CarPark&medthodName=
//payCarHeaderList&memberID=26298&xqID=86420010000004
#define PARKINGPAYHEAD MAININTERFACE@"serviceServlet?serviceName=CarPark&medthodName=payCarHeaderList&memberID=%@&xqID=%@"
#endif
