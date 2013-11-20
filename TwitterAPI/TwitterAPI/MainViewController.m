//
//  MainViewController.m
//  TwitterAPI
//
//  Created by Oscar Suro on 11/19/13.
//  Copyright (c) 2013 Oscar Suro. All rights reserved.
//

#import "MainViewController.h"
#import "TwitterRequest.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"Starting GUI");
    twitter = [[TwitterRequest alloc] init];
    twitter.delegate = self;
    [twitter requestAuth];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)doQuery:(id)sender {
    [twitter tweetsForQuery:searchBar.text];
}

- (void)didCompleteRequest:(NSArray *)requestData{
    NSLog(@"%@", requestData);
}

@end
