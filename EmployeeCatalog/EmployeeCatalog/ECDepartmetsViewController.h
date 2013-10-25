//
//  ECDepartmetsViewController.h
//  EmployeeCatalog
//
//  Created by Administrador on 10/4/13.
//  Copyright (c) 2013 Administrador. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@class Department;

@protocol ECDepartmentsDelegate <NSObject>

- (void)departmentSelected:(PFObject *)department;

@end

@interface ECDepartmetsViewController : UITableViewController <UIAlertViewDelegate> {
    NSArray *departments;
}

@property (nonatomic, assign) id<ECDepartmentsDelegate> delegate;

- (IBAction)addDepartment:(id)sender;

@end
