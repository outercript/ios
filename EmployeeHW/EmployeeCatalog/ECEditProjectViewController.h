//
//  ECEditProjectViewController.h
//  EmployeeCatalog
//
//  Created by Oscar Suro on 10/19/13.
//  Copyright (c) 2013 Administrador. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Project;

@interface ECEditProjectViewController : UIViewController{
    
    IBOutlet UITextField *txtName;
    IBOutlet UISegmentedControl *segPriority;
    IBOutlet UIDatePicker *dueDate;
}

@property (nonatomic, strong) Project *project;

- (IBAction)save:(id)sender;
- (IBAction)dismissKeyboard:(id)sender;

@end
