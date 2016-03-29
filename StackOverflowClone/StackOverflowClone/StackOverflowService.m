//
//  StackOverflowService.m
//  StackOverflowClone
//
//  Created by Lauren Spatz on 3/29/16.
//  Copyright © 2016 Lauren Spatz. All rights reserved.
//

#import "StackOverflowService.h"
#import "APIService.h"

NSString const *kSOAPIBaseURL = @"https://api.stackexchange.com/2.2/";

@implementation StackOverflowService

+(void)searchWithTerm:(NSString * _Nonnull)term withCompletion:(kNSDictionaryCompletionHandler _Nonnull)completionHandler
{
    NSString *searchTerm = [term stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    NSString *sortParameter = @"activity";
    NSString *orderParameter = @"desc";
    
    NSString *searchURL = [NSString stringWithFormat:@"%@search?order=%@&sort%@&intitle=%@&site=stackoverflow", kSOAPIBaseURL, orderParameter, sortParameter, searchTerm];
    
    [APIService getRequestWithURLString:searchURL withCompletion:^(NSDictionary * _Nullable data, NSError * _Nullable error) {
        if (error == nil)
        {
            completionHandler(data,nil);
        }
    }];
    
    
}

+(void)searchWithUser:(NSString * _Nonnull)searchWord withCompletion:(kNSDictionaryCompletionHandler _Nonnull)completionHandler
{
    NSString *searchTerm = [searchWord stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    NSString *sortParameter = @"reputation";
    NSString *orderParameter = @"desc";
    
    NSString *searchURL = [NSString stringWithFormat:@"%@users?order=%@&sort%@&inname=%@&site=stackoverflow", kSOAPIBaseURL, orderParameter, sortParameter, searchTerm];
    
    [APIService getRequestWithURLString:searchURL withCompletion:^(NSDictionary * _Nullable data, NSError * _Nullable error) {
        if (error == nil)
        {
            completionHandler(data,nil);
        }
    }];
    
    
}


@end
