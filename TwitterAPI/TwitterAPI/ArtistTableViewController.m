//
//  ArtistTableViewController.m
//  TwitterAPI
//
//  Created by Administrador on 11/22/13.
//  Copyright (c) 2013 Oscar Suro. All rights reserved.
//

#import "ArtistTableViewController.h"
#import "TwittsTableViewController.h"
#import "TwitterRequest.h"

@interface ArtistTableViewController ()

@end

@implementation ArtistTableViewController

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
    artistList = @[@"Lady Gaga", @"Pink", @"Rihanna", @"Obama", @"U2"];
    requestManager = [[TwitterRequest alloc] init];
    [requestManager requestAuth];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"twittView"]) {
        UITableViewCell *cell = sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        NSString *celebrityName = artistList[indexPath.row];

        TwittsTableViewController *twittView = segue.destinationViewController;
        twittView.celebrityName = celebrityName;
        twittView.keywordList = @[celebrityName];
        twittView.requestManager = requestManager;
        
        NSLog(@"Loaging celebrity: %@", celebrityName);
    }
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [artistList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = artistList[indexPath.row];
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Nothing to do here
}

@end
