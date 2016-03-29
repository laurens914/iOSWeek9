//
//  JSONParser.m
//  StackOverflowClone
//
//  Created by Lauren Spatz on 3/29/16.
//  Copyright © 2016 Lauren Spatz. All rights reserved.
//

#import "JSONParser.h"
#import "User.h"
#import "Question.h"


@implementation JSONParser


+(NSMutableArray * _Nullable)questionsArrayFromDictionary:(NSDictionary * _Nullable)dictionary
{
    NSMutableArray *results = [NSMutableArray new];
    
    if (dictionary)
    {
        NSMutableArray * items = dictionary[@"items"];
        
        if (items)
        {
            for (NSDictionary *questionDictionary in items) {
                Question *newQuestion = [self questionFromDictionary:questionDictionary];
                if (newQuestion !=nil) {
                    [results addObject:newQuestion];
                }
            }
        }
    }
    
    
    return results;
}

+(NSMutableArray * _Nullable)usersArrayFromDictionary:(NSDictionary * _Nullable)dictionary
{
    NSMutableArray *results = [NSMutableArray new];
    if (dictionary)
    {
        NSMutableArray *items = dictionary[@"items"];
    
        if (items) {
            for (NSDictionary *userDictionary in items) {
                User *newUser = [self userFromDictionary:userDictionary];
                if (newUser != nil) {
                    [results addObject:newUser];
                }
            }
        }
    }
    return results;
}


+(Question * _Nullable)questionFromDictionary:(NSDictionary *)questionDictionary
{
    NSString *title = questionDictionary[@"title"];
    NSNumber *questionID = questionDictionary[@"question_id"];
    NSNumber *score = questionDictionary[@"score"];
    BOOL isAnswered = [questionDictionary[@"is_answered"]isEqualToNumber:@1];
    NSDictionary *ownerDictionary = questionDictionary[@"owner"];
    User *owner = [self userFromDictionary:ownerDictionary];
    
    return [[Question alloc]initWithTitle:title owner:owner questionID:questionID.intValue score:score.intValue isAnswered:isAnswered];
}


+(User * _Nullable)userFromDictionary:(NSDictionary *)questionDictionary
{
    NSString *displayName = questionDictionary[@"display_name"];
    NSString *profileImageURLString = questionDictionary[@"profile_image"];
    NSString *linkURLString = questionDictionary[@"link"];
    NSNumber *userID = questionDictionary[@"user_id"];
    NSURL *profileImageURL = [NSURL URLWithString:profileImageURLString];
    NSURL *link = [NSURL URLWithString:linkURLString];
    
    return [[User alloc]initWithDisplayName:displayName profileImageURL:profileImageURL link:link userID:userID.intValue];
    
}
@end
