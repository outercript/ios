//
//  Employee.h
//  EmployeeCatalog
//
//  Created by Administrador on 9/27/13.
//  Copyright (c) 2013 Administrador. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Department, Project;

@interface Employee : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDate * dateOfBirth;
@property (nonatomic) double salary;
@property (nonatomic, retain) NSData * picture;
@property (nonatomic, retain) Department *department;
@property (nonatomic, retain) NSSet *projects;
@end

@interface Employee (CoreDataGeneratedAccessors)

- (void)addProjectsObject:(Project *)value;
- (void)removeProjectsObject:(Project *)value;
- (void)addProjects:(NSSet *)values;
- (void)removeProjects:(NSSet *)values;

@end
