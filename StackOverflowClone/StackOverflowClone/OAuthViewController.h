//
//  OAuthViewController.h
//  StackOverflowClone
//
//  Created by Lauren Spatz on 3/28/16.
//  Copyright © 2016 Lauren Spatz. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^OAuthViewControllerCompletion)();

@interface OAuthViewController : UIViewController

@property (copy, nonatomic) OAuthViewControllerCompletion completion;


+(NSString *)identifier;

@end
