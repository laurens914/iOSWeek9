//
//  JSONParser.h
//  StackOverflowClone
//
//  Created by Lauren Spatz on 3/29/16.
//  Copyright © 2016 Lauren Spatz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSONParser : NSObject

+(NSMutableArray * _Nullable)questionsArrayFromDictionary:(NSDictionary * _Nullable)dictionary;
+(NSMutableArray * _Nullable)usersArrayFromDictionary:(NSDictionary * _Nullable)dictionary;

@end
