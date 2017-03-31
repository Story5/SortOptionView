//
//  NetWorkService.m
//  YDTXFunDemo
//
//  Created by Story5 on 13/12/2016.
//  Copyright © 2016 Story5. All rights reserved.
//

#import "NetWorkService.h"

#import <AFNetworking/AFNetworking.h>
#import <SVProgressHUD/SVProgressHUD.h>

@interface NetWorkService ()

@property (nonatomic,retain) AFHTTPSessionManager *httpSessionManager;

@end

static NetWorkService *instance = nil;

@implementation NetWorkService

+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

#pragma mark - Project ShopMarket GET/POST methods
- (void)requestWithParam:(NSDictionary *)param
                 success:(void (^ _Nullable)(NSURLSessionDataTask * _Nullable, NSArray * _Nullable))success
                 failure:(void (^ _Nullable)(NSString * _Nullable))failure
{
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD show];
    
    [self.httpSessionManager GET:@"https://test.m.yundiaoke.cn/api/RightBind/PondBindList" parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        NSDictionary *responseDic = (NSDictionary *)responseObject;
        NSNumber *status = [responseDic objectForKey:@"status"];
        if (status.integerValue == 200) {
            NSLog(@"绑定塘口list Data:%@",responseObject);
            NSArray *responseArray = [responseDic objectForKey:@"data"];
            success(task,responseArray);
        } else {
            NSString *message = [responseDic objectForKey:@"message"];
            failure(message);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        failure(error.description);
        
    }];
}

#pragma mark - AFHTTPSessionManager
- (AFHTTPSessionManager *)httpSessionManager
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 超时时间
        manager.requestSerializer.timeoutInterval = 10;
    
    // 声明上传的是json格式的参数，需要你和后台约定好，不然会出现后台无法获取到你上传的参数问题
    manager.requestSerializer = [AFHTTPRequestSerializer serializer]; // 上传普通格式
    //        manager.requestSerializer = [AFJSONRequestSerializer serializer]; // 上传JSON格式
    
    // 声明获取到的数据格式
    //    manager.responseSerializer = [AFHTTPResponseSerializer serializer]; // AFN不会解析,数据是data，需要自己解析
    manager.responseSerializer = [AFJSONResponseSerializer serializer]; // AFN会JSON解析返回的数据
    // 个人建议还是自己解析的比较好，有时接口返回的数据不合格会报3840错误，大致是AFN无法解析返回来的数据
    
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                            -------------------- HTTPS----------------------
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////
//    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];// 证书模式
//    NSString *nameString = YDTXDEBUG ? @"server-test" : @"server";
//    
//    NSString *cerPath = [[NSBundle mainBundle] pathForResource:nameString ofType:@"cer"];
//    NSData *cerData = [NSData dataWithContentsOfFile:cerPath];
//    
//    securityPolicy.pinnedCertificates = [[NSSet alloc] initWithObjects:cerData, nil];// 配置证书
//    securityPolicy.allowInvalidCertificates = YES;// 客户端是否信任非法证书
//    [securityPolicy setValidatesDomainName:NO];// 是否在证书域字段中验证域名
//    manager.securityPolicy = securityPolicy;
    
    return manager;
}

@end
