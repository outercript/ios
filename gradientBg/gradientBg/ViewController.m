//
//  ViewController.m
//  gradientBg
//
//  Created by Oscar Suro on 8/21/13.
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
    red = 1.0f;
    blue = 1.0f;
    green = 1.0f;
    [ self changeBackground ];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)redSlideChange:(id)sender {
    red = sliderRed.value;
    [ self changeBackground ];
}

- (IBAction)blueSlideChange:(id)sender {
    blue = sliderBlue.value;
    [ self changeBackground ];
}

- (IBAction)greenSlideChange:(id)sender {
    green = sliderGreen.value;
    [ self changeBackground ];
}

- (void)changeBackground{
    self.view.backgroundColor = [ UIColor colorWithRed:red green:green blue:blue alpha:1.0f ];
}
@end
