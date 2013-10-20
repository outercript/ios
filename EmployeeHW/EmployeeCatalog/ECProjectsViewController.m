//
//  ECProjectsViewController.m
//  EmployeeCatalog
//
//  Created by Oscar Suro on 10/19/13.
//  Copyright (c) 2013 Administrador. All rights reserved.
//

#import "ECProjectsViewController.h"

#import "ECAppDelegate.h"
#import "Project.h"

#import "ECEditProjectViewController.h"

#import <CoreData/CoreData.h>

@interface ECProjectsViewController ()

@end

@implementation ECProjectsViewController

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

    self.navigationItem.leftBarButtonItem = self.editButtonItem;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self loadData];
    [self.tableView reloadData];
}

- (void)loadData {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Project"];
    //request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
    
    ECAppDelegate *appDelegate = (ECAppDelegate *) [UIApplication sharedApplication].delegate;
    projects = [appDelegate.managedObjectContext executeFetchRequest:request error:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"editProject"]) {        
        ECEditProjectViewController *editProject = segue.destinationViewController;
        editProject.project = sender;
    }
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [projects count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSArray *PriorityStr = [NSArray arrayWithObjects:@"High", @"Medium", @"Low", nil];
    Project *project = projects[indexPath.row];
    NSString *dueDate = [NSDateFormatter localizedStringFromDate:project.dueDate dateStyle:NSDateFormatterLongStyle timeStyle:NSDateFormatterNoStyle];
    cell.textLabel.text = project.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Priority: %@ - Due: %@", PriorityStr[project.priority], dueDate];
    
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
    Project *project = projects[indexPath.row];
    
    ECAppDelegate *appDelegate = (ECAppDelegate *) [UIApplication sharedApplication].delegate;
    [appDelegate.managedObjectContext deleteObject:project];
    [appDelegate saveContext];
    
    [self loadData];
    
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Project *project = projects[indexPath.row];
    
    // Check if called form delegate
    if (self.delegate != nil) {
        [self.delegate projectSelected:project];
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    // Show edit view if has no delegates
    else{
        [self performSegueWithIdentifier:@"editProject" sender:project];
    }
}

@end
