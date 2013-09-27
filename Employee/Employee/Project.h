//
//  Project.h
//  Employee
//
//  Created by Administrador on 9/27/13.
//  Copyright (c) 2013 orsurove. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Employee;

@interface Project : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic) NSTimeInterval dueDate;
@property (nonatomic) int16_t priority;
@property (nonatomic, retain) NSSet *employees;
@end

@interface Project (CoreDataGeneratedAccessors)

- (void)addEmployeesObject:(Employee *)value;
- (void)removeEmployeesObject:(Employee *)value;
- (void)addEmployees:(NSSet *)values;
- (void)removeEmployees:(NSSet *)values;

@end
