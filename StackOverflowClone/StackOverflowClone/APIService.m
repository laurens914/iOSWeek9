//
//  APIService.m
//  StackOverflowClone
//
//  Created by Lauren Spatz on 3/29/16.
//  Copyright © 2016 Lauren Spatz. All rights reserved.
//

#import "APIService.h"
#import "AFNetworking.h"

@implementation APIService

+(void)getRequestWithURLString:(NSString * _Nonnull)urlString withCompletion:(kNSDictionaryCompletionHandler)completionHandler
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
        dispatch_async(dispatch_get_main_queue(), ^{
            completionHandler(responseObject,nil);
        });
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
        dispatch_async(dispatch_get_main_queue(), ^{
            completionHandler(nil,error);
        });
    }];
}

@end
