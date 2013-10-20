//
//  ECEditProjectViewController.m
//  EmployeeCatalog
//
//  Created by Oscar Suro on 10/19/13.
//  Copyright (c) 2013 Administrador. All rights reserved.
//

#import "ECEditProjectViewController.h"
#import <CoreData/CoreData.h>
#import "ECAppDelegate.h"

#import "Project.h"

@interface ECEditProjectViewController ()

@end

@implementation ECEditProjectViewController

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
	// Do any additional setup after loading the view.
    if (self.project != nil) {
        txtName.text = self.project.name;
        segPriority.selectedSegmentIndex = self.project.priority;
        dueDate.date = self.project.dueDate;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)save:(id)sender {
    ECAppDelegate *appDelegate = (ECAppDelegate *) [UIApplication sharedApplication].delegate;
    
    Project *project = self.project;
    
    if (project == nil) {
        project = [NSEntityDescription insertNewObjectForEntityForName:@"Project" inManagedObjectContext:appDelegate.managedObjectContext];
    }
    
    project.name = txtName.text;
    project.priority = segPriority.selectedSegmentIndex;
    project.dueDate = dueDate.date;
    
    [appDelegate saveContext];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)dismissKeyboard:(id)sender {
    [self.view endEditing:NO];
}

@end
