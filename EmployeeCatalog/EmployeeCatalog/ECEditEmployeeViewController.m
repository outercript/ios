//
//  ECEditEmployeeViewController.m
//  EmployeeCatalog
//
//  Created by Administrador on 10/1/13.
//  Copyright (c) 2013 Administrador. All rights reserved.
//

#import "ECEditEmployeeViewController.h"

@interface ECEditEmployeeViewController ()

@end

@implementation ECEditEmployeeViewController

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

    if (self.employee != nil) {
        txtName.text = [self.employee objectForKey:@"name"];
        txtSalary.text = [NSString stringWithFormat:@"%@",
                          [self.employee objectForKey:@"salary"]];
        dateOfBirth.date = [self.employee objectForKey:@"dayOfBirth"];
        [self.employee fetchInBackgroundWithBlock:^(PFObject *object, NSError *error) {
            PFObject *dep = [object objectForKey:@"department"];
            lblDepartment.text = [dep objectForKey:@"name"];
            selectedDepartment = dep;

        }];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"selectDepartment"]) {
        ECDepartmetsViewController *dvc = segue.destinationViewController;
        dvc.delegate = self;
    }
}

- (IBAction)dismissKeyboard:(id)sender {
    [self.view endEditing:NO];
}

- (IBAction)selectDepartment:(id)sender {
}

- (IBAction)save:(id)sender {
    PFObject *emp = self.employee;
    
    if (emp == nil) {
        emp = [PFObject objectWithClassName:@"Employee"];
    }

    [emp setObject:txtName.text forKey:@"name"];
    [emp setObject:@([[txtSalary text] doubleValue]) forKey:@"salary"];
    [emp setObject:dateOfBirth.date forKey:@"dateOfBirth"];
    [emp setObject:selectedDepartment forKey:@"department"];
    [emp saveEventually];
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - ECDepartmentsDelegate

- (void)departmentSelected:(PFObject *)department {
    lblDepartment.text = [department objectForKey: @"name"];
    selectedDepartment = department;
}

@end
