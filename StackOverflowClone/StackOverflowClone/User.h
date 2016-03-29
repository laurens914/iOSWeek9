//
//  User.h
//  StackOverflowClone
//
//  Created by Lauren Spatz on 3/29/16.
//  Copyright © 2016 Lauren Spatz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface User : NSObject

@property (strong, nonatomic) NSString *displayName;
@property (strong,nonatomic) NSURL *profileImageURL;
@property (strong,nonatomic) UIImage *profileImage;
@property (strong, nonatomic) NSURL *link;
@property (nonatomic) int userID;

-(instancetype)initWithDisplayName:(NSString *)displayName profileImageURL:(NSURL *)profileImageURL link:(NSURL *)link userID:(int)userID;

@end
