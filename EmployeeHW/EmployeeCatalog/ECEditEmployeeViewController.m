//
//  ECEditEmployeeViewController.m
//  EmployeeCatalog
//
//  Created by Administrador on 10/1/13.
//  Copyright (c) 2013 Administrador. All rights reserved.
//

#import "ECEditEmployeeViewController.h"
#import "ECAppDelegate.h"
#import "Employee.h"
#import "Department.h"
#import "Project.h"

#import <CoreData/CoreData.h>

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
    [userPhoto addGestureRecognizer:photoGesture];
    // Set table view delegates
    [self.myProjects setDelegate: self];
    [self.myProjects setDataSource: self];
    
    if (self.employee != nil) {
        txtName.text = self.employee.name;
        txtSalary.text = [NSString stringWithFormat:@"%0.0lf", self.employee.salary];
        //dateOfBirth.date = self.employee.dateOfBirth;
        lblDepartment.text = self.employee.department.name;
        userPhoto.image = [ UIImage imageWithData:self.employee.picture ];
        
        selectedDepartment = self.employee.department;
        employeeProjects = [self.employee.projects mutableCopy];
        
        for(id item in employeeProjects){
            NSLog(@"Items: %@", [item valueForKey:@"name"]);
        }
    }
    else{
        employeeProjects = [[NSMutableSet alloc] init];
    }
    
    [self loadProjects];
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
    
    else if ([segue.identifier isEqualToString:@"selectProject"]) {
        ECProjectsViewController *dvc = segue.destinationViewController;
        dvc.delegate = self;
    }
}

- (IBAction)dismissKeyboard:(id)sender {
    [self.view endEditing:NO];
}

- (IBAction)selectDepartment:(id)sender {
}

- (IBAction)save:(id)sender {
    [self saveEmployee];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) saveEmployee{
    ECAppDelegate *appDelegate = (ECAppDelegate *) [UIApplication sharedApplication].delegate;
    
    Employee *emp = self.employee;
    
    if (emp == nil) {
        emp = [NSEntityDescription insertNewObjectForEntityForName:@"Employee" inManagedObjectContext:appDelegate.managedObjectContext];
    }
    
    emp.name = txtName.text;
    emp.salary = [txtSalary.text doubleValue];
    //emp.dateOfBirth = dateOfBirth.date;
    emp.department = selectedDepartment;
    emp.projects = employeeProjects;
    
    if (userPhoto.image != nil) {
        NSData *photoData = UIImagePNGRepresentation(userPhoto.image);
        emp.picture = photoData;
    }
    
    [appDelegate saveContext];
    NSLog(@"Saving...");
}

- (void)loadProjects {
    projects = [employeeProjects allObjects];
    [self.myProjects reloadData];
}

#pragma mark - ECDepartmentsDelegate
- (void)departmentSelected:(Department *)department {
    lblDepartment.text = department.name;
    selectedDepartment = department;
}

#pragma mark - ECProjectsDelegate
- (void)projectSelected:(Project *)project {
    if([employeeProjects containsObject:project]){
        NSLog(@"Item already exist...");
        return;
    }
    
    [employeeProjects addObject:project];
    [self loadProjects];
}
                         
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [projects count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    NSArray *PriorityStr = [NSArray arrayWithObjects:@"High", @"Medium", @"Low", nil];
    Project *project = projects[indexPath.row];
    NSString *dueDate = [NSDateFormatter localizedStringFromDate:project.dueDate dateStyle:NSDateFormatterLongStyle timeStyle:NSDateFormatterNoStyle];
    cell.textLabel.text = project.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Priority: %@ - Due: %@", PriorityStr[project.priority], dueDate ];

    return cell;
}
                         
#pragma mark - Table view delegate
                         
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
     return YES;
 }
 
 - (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
     return UITableViewCellEditingStyleDelete;
 }
 
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
     Project *project = projects[indexPath.row];
     [employeeProjects removeObject:project];
     [self loadProjects];
}

#pragma mark - Photo
- (IBAction)photoSelect:(id)sender {
    NSLog(@"Photo!!");
    UIImagePickerController *picker = [[ UIImagePickerController alloc] init ];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:nil ];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    userPhoto.image = info[UIImagePickerControllerOriginalImage];
    [self dismissViewControllerAnimated:YES completion:nil ];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil ];
}

@end
