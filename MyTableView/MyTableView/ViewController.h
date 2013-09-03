//
//  ViewController.h
//  MyTableView
//
//  Created by Administrador on 8/27/13.
//  Copyright (c) 2013 Administrador. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
    <UITableViewDataSource, UITableViewDelegate>
{
    
    __weak IBOutlet UITableView *tableViewMain;
    
}

@property (nonatomic, strong) NSMutableDictionary *names;
@property (nonatomic, strong) NSMutableArray *initials;


@end
