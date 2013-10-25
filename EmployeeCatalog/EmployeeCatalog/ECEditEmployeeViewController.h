//
//  ECEditEmployeeViewController.h
//  EmployeeCatalog
//
//  Created by Administrador on 10/1/13.
//  Copyright (c) 2013 Administrador. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ECDepartmetsViewController.h"

@interface ECEditEmployeeViewController : UIViewController <ECDepartmentsDelegate> {
    
    __weak IBOutlet UITextField *txtName;
    __weak IBOutlet UITextField *txtSalary;
    __weak IBOutlet UILabel *lblDepartment;
    __weak IBOutlet UIDatePicker *dateOfBirth;
    
    PFObject *selectedDepartment;
}

@property (nonatomic, strong) PFObject *employee;

- (IBAction)dismissKeyboard:(id)sender;

- (IBAction)selectDepartment:(id)sender;
- (IBAction)save:(id)sender;

@end
