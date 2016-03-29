//
//  UserSearchViewController.m
//  StackOverflowClone
//
//  Created by Lauren Spatz on 3/28/16.
//  Copyright © 2016 Lauren Spatz. All rights reserved.
//

#import "UserSearchViewController.h"
#import "User.h"
#import "StackOverflowService.h"
#import "JSONParser.h"


@interface UserSearchViewController ()<UITableViewDataSource, UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong,nonatomic) NSArray<User *> *users;

@end

@implementation UserSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

+(NSString *)identifier{
    return @"UserSearchViewController";
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.users.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *userCell = [tableView dequeueReusableCellWithIdentifier:@"userCell" forIndexPath:indexPath];
    userCell.textLabel.text = self.users[indexPath.row].displayName;
    
    return userCell;
    
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [StackOverflowService searchWithUser:searchBar.text withCompletion:^(NSDictionary * _Nullable data, NSError * _Nullable error) {
        self.users = [JSONParser usersArrayFromDictionary:data];
        [self.tableView reloadData];
    }];
    [self resignFirstResponder];
}

@end
