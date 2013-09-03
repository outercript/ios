//
//  ViewController.m
//  MyTableView
//
//  Created by Administrador on 8/27/13.
//  Copyright (c) 2013 Administrador. All rights reserved.
//

#import "ViewController.h"
#import "MyCell.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.names = [@{@"o": @[@"Oscar"]}
                  mutableCopy] ;
    self.initials = [[ self.names allKeys ]
                     mutableCopy];
}


#pragma mark - Methods for UITableView
// Methods that we obtained from UITableView in the [required] section

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the total number of cells for the TableView, in this case the size
    // of the array
    NSString *key = self.initials[section];
    return [self.names[key] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // We link the Cell w/ the identifier we choose in Storyboard
    static NSString *CellIdentifier = @"Cell";

    // Creates an instance of the custom TableViewCell that we created before
    UITableViewCell *cell = [ tableView dequeueReusableCellWithIdentifier: CellIdentifier
                                                    forIndexPath: indexPath ];

    NSString *section = self.initials[indexPath.section];
    NSArray *temp = self.names[section];
    cell.textLabel.text = temp[indexPath.row];

    // Set the label text for current Cell index from the Array we crated before
    //cell.MyLabel.text = [[ self arrayMainFeeder ] objectForKey:  ];

    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return self.initials[section];
}

@end
