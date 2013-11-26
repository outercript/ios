//
//  CelebrityViewController.m
//  TwitterAPI
//
//  Created by Administrador on 11/26/13.
//  Copyright (c) 2013 Oscar Suro. All rights reserved.
//

#import "CelebrityViewController.h"
#import "AppDelegate.h"
#import "Celebrity.h"

#import "TwitterRequest.h"
#import <CoreData/CoreData.h>

@interface CelebrityViewController ()

@end

@implementation CelebrityViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self loadData];
    [self.tableView reloadData];
}

- (void)loadData {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Celebrity"];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"userName" ascending:YES]];

    AppDelegate *appDelegate = (AppDelegate *) [UIApplication sharedApplication].delegate;
    Celebritys = [appDelegate.managedObjectContext executeFetchRequest:request error:nil];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [Celebritys count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    Celebrity *dep = Celebritys[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat: @"@%@", dep.userName];
    return cell;
}

#pragma mark - Table view delegate

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    Celebrity *celebrity = Celebritys[indexPath.row];

    AppDelegate *appDelegate = (AppDelegate *) [UIApplication sharedApplication].delegate;
    [appDelegate.managedObjectContext deleteObject:celebrity];
    [appDelegate saveContext];

    [self loadData];

    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Table view delegate

- (IBAction)addCelebrity:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Add Celebrity username"
                                                    message:nil
                                                   delegate:self
                                          cancelButtonTitle:@"Cancel"
                                          otherButtonTitles:@"Add", nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert textFieldAtIndex:0].placeholder = @"@username";
    [alert show];
}

#pragma mark - UIAlertView

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex != alertView.cancelButtonIndex) {
        NSString *username = [alertView textFieldAtIndex:0].text;
        if ([username length] > 0) {
            AppDelegate *appDelegate = (AppDelegate *) [UIApplication sharedApplication].delegate;
            Celebrity *dep = [NSEntityDescription insertNewObjectForEntityForName:@"Celebrity" inManagedObjectContext:appDelegate.managedObjectContext];
            dep.userName = username;

            [appDelegate saveContext];

            [self.requestManager userWithScreenName:username];
            [self loadData];
            [self.tableView reloadData];
        }
    }
}


- (void)didCompleteRequest:(NSArray *)requestData{
    AppDelegate *appDelegate = (AppDelegate *) [UIApplication sharedApplication].delegate;
    NSArray *results;
    NSDictionary *response;
    NSLog(@"Obtained user data");
    
    if (requestData.count > 0) {
        response = requestData[0];
        
        NSManagedObjectContext *context = appDelegate.managedObjectContext;

        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        NSPredicate *searchFilter = [NSPredicate predicateWithFormat:@"userName = %@", response[@"username"]];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Celebrity" inManagedObjectContext:context];
        
        [request setEntity:entity];
        [request setPredicate:searchFilter];
        results = [context executeFetchRequest:request error:nil];
    }

    if (results.count > 0) {
        Celebrity *celebrity = results[0];
        celebrity.realName = response[@"real_name"];
        celebrity.userPhoto = response[@"photo"];
        [appDelegate saveContext];
    }

    else{
        NSLog(@"You failed");
    }
}
@end
