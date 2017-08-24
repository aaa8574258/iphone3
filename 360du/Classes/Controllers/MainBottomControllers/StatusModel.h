

/********************* 有任何问题欢迎反馈给我 liuweiself@126.com ****************************************/
/***************  https://github.com/waynezxcv/Gallop 持续更新 ***************************/
/******************** 正在不断完善中，谢谢~  Enjoy ******************************************************/


#import <Foundation/Foundation.h>
#import "CommentModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface StatusModel : NSObject <NSCopying>

@property (nonatomic,copy) NSString* type;
@property (nonatomic,strong) NSURL* avatar;
@property (nonatomic,copy) NSString* content;
@property (nonatomic,copy) NSString* detail;
@property (nonatomic,strong) NSDate* date;
@property (nonatomic,copy) NSArray* imgs;
@property (nonatomic,copy) NSString* name;
@property (nonatomic,copy) NSString* statusID;
@property (nonatomic,copy) NSArray* commentList;
@property (nonatomic,copy) NSArray *commentListIds;
@property (nonatomic,copy) NSArray* likeList;
@property (nonatomic,copy) NSString *ccid;
@property (nonatomic,assign) BOOL isLike;
//@property (nonatomic,copy) NSString *toThis;
- (StatusModel *)initWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
