//
//  ViewController.m
//  LeStalkeo
//
//  Created by Oscar Suro on 11/1/13.
//  Copyright (c) 2013 Oscar Suro. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dismissKeyboard:(id)sender{
    NSLog(@"Adios teclado");
    [self.view endEditing:YES];
}

- (void)login:(id)sender{
    NSLog(@"Login");
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    UINavigationController *obj=[storyboard instantiateViewControllerWithIdentifier:@"main"];
    self.navigationController.navigationBarHidden=YES;
    [self.navigationController pushViewController:obj animated:YES];
}
@end
