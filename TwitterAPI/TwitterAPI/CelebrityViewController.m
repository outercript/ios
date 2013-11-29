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
    cell.detailTextLabel.text = dep.realName;
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
    if (self.requestManager.userAccount == nil){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Working offline =("
                                                        message:@"Sorry you can't do that when there is no internet connection or a Twitter account in this device"
                                                       delegate:nil
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Add Twitter Username"
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
            NSArray *results;

            // Trim leading @ from username
            NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^@+" options:NSRegularExpressionCaseInsensitive error:nil ];
            username = [regex stringByReplacingMatchesInString:username options:0 range:NSMakeRange(0, [username length]) withTemplate:@""];

            // Search for duplicates

            AppDelegate *appDelegate = (AppDelegate *) [UIApplication sharedApplication].delegate;
            NSManagedObjectContext *context = appDelegate.managedObjectContext;
            
            NSFetchRequest *request = [[NSFetchRequest alloc] init];
            NSPredicate *searchFilter = [NSPredicate predicateWithFormat:@"ANY userName LIKE[c] %@", username];
            NSEntityDescription *entity = [NSEntityDescription entityForName:@"Celebrity" inManagedObjectContext:context];

            [request setEntity:entity];
            [request setPredicate:searchFilter];
            results = [context executeFetchRequest:request error:nil];

            if (results.count > 0){
                NSString *message = [NSString stringWithFormat:@"I like %@ too!", username];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Yeah!"
                                                                message:message
                                                               delegate:nil
                                                      cancelButtonTitle:@"Ok"
                                                      otherButtonTitles:nil];
                [alert show];
                return;
            }
            
            [self.requestManager userWithScreenName:username];
        }
    }
}


- (void)didCompleteRequest:(NSArray *)requestData{
    NSDictionary *response;
    NSLog(@"Obtained data");
    
    if (requestData.count > 0) {
        response = requestData[0];

        if ([response objectForKey:@"errors"]){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Upsss"
                                                            message:@"Can't find that user... Probably I got confused, please try again"
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
            [alert show];
            return;
        }

        // Actually save the entry in Core Data
        AppDelegate *appDelegate = (AppDelegate *) [UIApplication sharedApplication].delegate;
        NSManagedObjectContext *context = appDelegate.managedObjectContext;

        Celebrity *celebrity = [NSEntityDescription insertNewObjectForEntityForName:@"Celebrity" inManagedObjectContext:context];
        celebrity.realName = response[@"real_name"];
        celebrity.userName = response[@"username"];
        celebrity.userPhoto = response[@"photo"];
        [appDelegate saveContext];

        [self loadData];
        [self.tableView reloadData];
    }

    else{
        NSLog(@"You failed");
    }
}
@end
