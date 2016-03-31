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
#import "QuestionTableViewCell.h"

@interface QuestionSearchViewController ()<UITableViewDataSource, UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(strong,nonatomic) NSArray<Question *> *questions;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
//@property (strong,nonatomic) NSString *team;
@end

@implementation QuestionSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(void)setValue:(id)value forKey:(NSString *)key
//{
//    [self setValue:@"Seahawks" forKey:@"Team"];
//}

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
    QuestionTableViewCell *questionCell = [tableView dequeueReusableCellWithIdentifier:@"questionCell" forIndexPath:indexPath];
    
    questionCell.questionTitle.text = self.questions[indexPath.row].title;
    
    if (self.questions[indexPath.row].isAnswered){
        questionCell.isAnswered.text = @"Answered: Yes";
    } else {
        questionCell.isAnswered.text = @"Answered: No";
    }
    
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

-(void)setupTableView
{
    self.tableView.estimatedRowHeight = 100;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    UINib *nib = [UINib nibWithNibName:@"QuestionTableViewCell" bundle:nil];
    
    [self.tableView registerNib:nib forCellReuseIdentifier:@"questionCell"];
}



























@end
