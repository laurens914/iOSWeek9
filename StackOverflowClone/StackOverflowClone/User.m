//
//  User.m
//  StackOverflowClone
//
//  Created by Lauren Spatz on 3/29/16.
//  Copyright © 2016 Lauren Spatz. All rights reserved.
//

#import "User.h"

@implementation User

-(instancetype)initWithDisplayName:(NSString *)displayName profileImageURL:(NSURL *)profileImageURL link:(NSURL *)link userID:(int)userID
{
    if (self = [super init])
    {
        self.displayName = displayName;
        self.profileImageURL =profileImageURL;
        self.link = link;
        self.userID = userID;
    }
    return self;
}

@end
