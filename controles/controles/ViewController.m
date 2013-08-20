//
//  ViewController.m
//  controles
//
//  Created by Administrador on 8/20/13.
//  Copyright (c) 2013 Administrador. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    guiText.text = [ NSString stringWithFormat:@"%0.0f", guiSlider.value ];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sliderChanged:(id)sender {
    guiText.text = [ NSString stringWithFormat:@"%0.0f", guiSlider.value ];
}

- (IBAction)switchChanged:(id)sender {
    if (guiSwitch.on) {
        guiText.text = [ NSString stringWithFormat:@"Activo" ];
    }
    else{
        guiText.text = [ NSString stringWithFormat:@"Inactivo" ];
    }
}

- (IBAction)segmentChanged:(id)sender {
    guiText.text = [ guiSegControl titleForSegmentAtIndex:guiSegControl.selectedSegmentIndex];
}
@end
