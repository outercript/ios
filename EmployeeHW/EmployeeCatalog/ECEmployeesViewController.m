//
//  ECEmployeesViewController.m
//  EmployeeCatalog
//
//  Created by Administrador on 10/1/13.
//  Copyright (c) 2013 Administrador. All rights reserved.
//

#import "ECEmployeesViewController.h"

#import "ECAppDelegate.h"
#import "Employee.h"

#import "ECEditEmployeeViewController.h"

#import <CoreData/CoreData.h>

@interface ECEmployeesViewController ()

@end

@implementation ECEmployeesViewController

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
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Employee"];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
    
    ECAppDelegate *appDelegate = (ECAppDelegate *) [UIApplication sharedApplication].delegate;
    employees = [appDelegate.managedObjectContext executeFetchRequest:request error:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"editEmployee"]) {
        UITableViewCell *cell = sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        Employee *employee = employees[indexPath.row];
        
        ECEditEmployeeViewController *editEmployee = segue.destinationViewController;
        editEmployee.employee = employee;
    }
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [employees count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    Employee *emp = employees[indexPath.row];
    cell.textLabel.text = emp.name;
    
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
    Employee *employee = employees[indexPath.row];
    
    ECAppDelegate *appDelegate = (ECAppDelegate *) [UIApplication sharedApplication].delegate;
    [appDelegate.managedObjectContext deleteObject:employee];
    [appDelegate saveContext];
    
    [self loadData];
    
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

@end
