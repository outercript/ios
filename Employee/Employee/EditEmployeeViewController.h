//
//  EditEmployeeViewController.h
//  Employee
//
//  Created by Administrador on 10/1/13.
//  Copyright (c) 2013 orsurove. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditEmployeeViewController : UIViewController{

    __weak IBOutlet UITextField *employeeName;
    __weak IBOutlet UITextField *employeeSalary;
    __weak IBOutlet UIImageView *photo;
    __weak IBOutlet UIDatePicker *birthDate;
}

- (IBAction)save:(id)sender;
- (IBAction)selectDepartment:(id)sender;
- (IBAction)dissmissKeyboard:(id)sender;

@end
