//
//  ViewController.h
//  controles
//
//  Created by Administrador on 8/20/13.
//  Copyright (c) 2013 Administrador. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController{
    
    __weak IBOutlet UISegmentedControl *guiSegControl;
    __weak IBOutlet UISlider *guiSlider;
    __weak IBOutlet UISwitch *guiSwitch;
    __weak IBOutlet UITextField *guiText;
    
}

- (IBAction)sliderChanged:(id)sender;
- (IBAction)switchChanged:(id)sender;
- (IBAction)segmentChanged:(id)sender;

@end
