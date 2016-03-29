//
//  StackOverflowService.h
//  StackOverflowClone
//
//  Created by Lauren Spatz on 3/29/16.
//  Copyright © 2016 Lauren Spatz. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^kNSDictionaryCompletionHandler) (NSDictionary * _Nullable data, NSError *_Nullable error);

@interface StackOverflowService : NSObject

+(void)searchWithTerm:(NSString * _Nonnull)term withCompletion:(kNSDictionaryCompletionHandler _Nonnull)completionHandler;
+(void)searchWithUser:(NSString * _Nonnull)searchWord withCompletion:(kNSDictionaryCompletionHandler _Nonnull)completionHandler;
@end
