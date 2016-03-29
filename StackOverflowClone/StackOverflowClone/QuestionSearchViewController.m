//
//  QuestionSearchViewController.m
//  StackOverflowClone
//
//  Created by Lauren Spatz on 3/28/16.
//  Copyright © 2016 Lauren Spatz. All rights reserved.
//

#import "QuestionSearchViewController.h"
#import "StackOverflowService.h"
#import "JSONParser.h"
#import "Question.h"

@interface QuestionSearchViewController ()<UITableViewDataSource, UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(strong,nonatomic) NSArray<Question *> *questions;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@end

@implementation QuestionSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+(NSString *)identifier
{
    return @"QuestionSearchViewController";
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.questions.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *questionCell = [tableView dequeueReusableCellWithIdentifier:@"questionCell" forIndexPath:indexPath];
    
    questionCell.textLabel.text = self.questions[indexPath.row].title;
    
    return questionCell;
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [StackOverflowService searchWithTerm:searchBar.text withCompletion:^(NSDictionary * _Nullable data, NSError * _Nullable error) {
        if (error == nil){
            self.questions = [JSONParser questionsArrayFromDictionary:data];
            [self.tableView reloadData];
        }
    }];
    [self resignFirstResponder];
}

@end
