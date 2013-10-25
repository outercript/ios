//
//  EditEmployeeViewController.m
//  Employee
//
//  Created by Administrador on 10/1/13.
//  Copyright (c) 2013 orsurove. All rights reserved.
//
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import "Employee.h"

#import "EditEmployeeViewController.h"

@interface EditEmployeeViewController ()

@end

@implementation EditEmployeeViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)save:(id)sender {
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    Employee *emp = [NSEntityDescription insertNewObjectForEntityForName:@"Employee" inManagedObjectContext:appDelegate.managedObjectContext];

    emp.name = employeeName.text;
    emp.salary = [employeeSalary.text doubleValue ];
    emp.dateOfBirth = birthDate.date;

    [appDelegate saveContext];
}

- (IBAction)selectDepartment:(id)sender {
}

- (IBAction)dissmissKeyboard:(id)sender{
    [self.view endEditing:YES];
}
@end
