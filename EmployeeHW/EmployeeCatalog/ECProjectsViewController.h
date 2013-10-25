//
//  ECProjectsViewController.h
//  EmployeeCatalog
//
//  Created by Oscar Suro on 10/19/13.
//  Copyright (c) 2013 Administrador. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Project;
@protocol ECProjectsDelegate <NSObject>

- (void)projectSelected:(Project *)project;

@end

@interface ECProjectsViewController : UITableViewController{
    NSArray *projects;
}

@property (nonatomic, assign) id<ECProjectsDelegate> delegate;

@end
