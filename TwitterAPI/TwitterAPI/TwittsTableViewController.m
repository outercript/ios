//
//  TwittsTableViewController.m
//  TwitterAPI
//
//  Created by Administrador on 11/22/13.
//  Copyright (c) 2013 Oscar Suro. All rights reserved.
//

#import "TwittsTableViewController.h"
#import "TwitterRequest.h"

@interface TwittsTableViewController ()

@end

@implementation TwittsTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    requestManager = [[TwitterRequest alloc] init];
    [requestManager requestAuth];
}

- (void)viewWillAppear:(BOOL)animated{
    for (id keyword in self.keywordList) {
        [requestManager tweetsForQuery:keyword];
        NSLog(@"Requesting data for: %@", keyword);
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [twittsList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = twittsList[indexPath.row][@"username"];
    cell.detailTextLabel.text = twittsList[indexPath.row][@"content"];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

- (void) didCompleteRequest:(NSArray *)requestData{
    [twittsList addObjectsFromArray:requestData];
    [self.tableView reloadData];
}

@end
