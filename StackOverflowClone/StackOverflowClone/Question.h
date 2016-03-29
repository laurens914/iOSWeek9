//
//  Question.h
//  StackOverflowClone
//
//  Created by Lauren Spatz on 3/29/16.
//  Copyright © 2016 Lauren Spatz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Question : NSObject

@property (strong, nonatomic)NSString *title;
@property (strong, nonatomic)User *owner;
@property (nonatomic) int questionID;
@property (nonatomic) int score;
@property (nonatomic) BOOL isAnswered;

-(instancetype)initWithTitle:(NSString *)title owner:(User *)owner questionID:(int)questionID score:(int)score isAnswered:(BOOL)isAnswered;

@end
