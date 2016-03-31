//
//  QuestionTableViewCell.h
//  StackOverflowClone
//
//  Created by Lauren Spatz on 3/30/16.
//  Copyright © 2016 Lauren Spatz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuestionTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *questionTitle;
@property (weak, nonatomic) IBOutlet UILabel *isAnswered;

@end
