//
//  ECDepartmetsViewController.m
//  EmployeeCatalog
//
//  Created by Administrador on 10/4/13.
//  Copyright (c) 2013 Administrador. All rights reserved.
//

#import "ECDepartmetsViewController.h"
#import "ECAppDelegate.h"
#import "Department.h"
#import <CoreData/CoreData.h>

@interface ECDepartmetsViewController ()

@end

@implementation ECDepartmetsViewController

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
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Department"];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
    
    ECAppDelegate *appDelegate = (ECAppDelegate *) [UIApplication sharedApplication].delegate;
    departments = [appDelegate.managedObjectContext executeFetchRequest:request error:nil];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [departments count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    Department *dep = departments[indexPath.row];
    cell.textLabel.text = dep.name;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.delegate != nil) {
        Department *dep = departments[indexPath.row];
        [self.delegate departmentSelected:dep];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (IBAction)addDepartment:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Add department"
                                                    message:nil
                                                   delegate:self
                                          cancelButtonTitle:@"Cancel"
                                          otherButtonTitles:@"Add", nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert textFieldAtIndex:0].placeholder = @"Department name";
    [alert show];
}

#pragma mark - UIAlertView

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex != alertView.cancelButtonIndex) {
        NSString *depName = [alertView textFieldAtIndex:0].text;
        if ([depName length] > 0) {
            ECAppDelegate *appDelegate = (ECAppDelegate *) [UIApplication sharedApplication].delegate;
            Department *dep = [NSEntityDescription insertNewObjectForEntityForName:@"Department" inManagedObjectContext:appDelegate.managedObjectContext];
            dep.name = depName;
            [appDelegate saveContext];
            
            [self loadData];
            [self.tableView reloadData];
        }
    }
}

@end
