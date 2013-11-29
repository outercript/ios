//
//  TwittsTableViewController.m
//  TwitterAPI
//
//  Created by Administrador on 11/22/13.
//  Copyright (c) 2013 Oscar Suro. All rights reserved.
//

#import "TwittsTableViewController.h"
#import "TwitterRequest.h"
#import "TwitCell.h"

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
    self.requestManager.delegate = self;
    twittsList = [[NSMutableArray alloc] init];
}

- (void)viewWillAppear:(BOOL)animated{
    self.title = self.celebrityName;
    
    // Load data from Twitter
    for (id keyword in self.keywordList) {
        [self.requestManager tweetsForQuery:keyword];
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
    TwitCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Load text
    cell.userName.text = [NSString stringWithFormat:@"@%@",
                          twittsList[indexPath.row][@"username"]];
    cell.content.text = twittsList[indexPath.row][@"content"];
    
    CGRect newFrame = cell.content.frame;
    newFrame.size.height = [self calculateCellHeight:cell rowIndex:indexPath.row];
    cell.content.frame = newFrame;
    
    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_async(queue, ^{
        NSURL *imageURL = [NSURL URLWithString:twittsList[indexPath.row][@"thumbnail"]];
        NSData *rawImage = [NSData dataWithContentsOfURL:imageURL];
        UIImage *image = [UIImage imageWithData:rawImage];
        
        [cell.userImage setImage:image];
        [cell setNeedsLayout];
    });
    
    return cell;
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    TwitCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    CGFloat contentHeigh = [self calculateCellHeight:cell rowIndex:indexPath.row];
    contentHeigh += 35.0f;
    
    CGFloat height = MAX(contentHeigh, 52.0f);
    return height;
}

- (CGFloat)calculateCellHeight:(TwitCell *)cell rowIndex:(int)row {
    NSString *myText = twittsList[row][@"content"];
    CGSize maxContentSize = CGSizeMake(240, 9999);
    CGSize newContentSize = [myText sizeWithFont:cell.content.font
                               constrainedToSize:maxContentSize
                                   lineBreakMode:cell.content.lineBreakMode];
    return newContentSize.height;
}


#pragma mark - TwitterRequest delegate
- (void) didCompleteRequest:(NSArray *)requestData{
    NSLog(@"Data received...");
    [twittsList addObjectsFromArray:requestData];
    [self.tableView reloadData];
}

@end
