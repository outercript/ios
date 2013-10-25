//
//  ECEditEmployeeViewController.h
//  EmployeeCatalog
//
//  Created by Administrador on 10/1/13.
//  Copyright (c) 2013 Administrador. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ECDepartmetsViewController.h"
#import "ECProjectsViewController.h"

@class Employee;
@class Department;

@interface ECEditEmployeeViewController : UIViewController <ECDepartmentsDelegate, ECProjectsDelegate, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate,
UINavigationControllerDelegate> {
    
    __weak IBOutlet UITextField *txtName;
    __weak IBOutlet UITextField *txtSalary;
    __weak IBOutlet UILabel *lblDepartment;
    __weak IBOutlet UIImageView *userPhoto;
    IBOutlet UITapGestureRecognizer *photoGesture;
    
    NSMutableSet *employeeProjects;
    NSArray *projects;
    Department *selectedDepartment;
}

@property (nonatomic, strong) Employee *employee;
@property (strong, nonatomic) IBOutlet UITableView *myProjects;

- (IBAction)dismissKeyboard:(id)sender;
- (IBAction)photoSelect:(id)sender;
- (IBAction)selectDepartment:(id)sender;
- (IBAction)save:(id)sender;

@end
