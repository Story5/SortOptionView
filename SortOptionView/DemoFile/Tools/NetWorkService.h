//
//  NetWorkService.h
//  YDTXFunDemo
//
//  Created by Story5 on 13/12/2016.
//  Copyright © 2016 Story5. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetWorkService : NSObject
+ (nullable instancetype)shareInstance;

- (void)requestWithParam:(NSDictionary *_Nullable)param
                 success:(void (^_Nullable)(NSURLSessionDataTask *_Nullable task,NSArray *_Nullable modelArray))success
                 failure:(void (^_Nullable)(NSString *_Nullable error))failure;
@end
