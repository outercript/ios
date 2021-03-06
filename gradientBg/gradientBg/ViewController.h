//
//  ViewController.h
//  gradientBg
//
//  Created by Oscar Suro on 8/21/13.
//  Copyright (c) 2013 Oscar Suro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController{
    
    __weak IBOutlet UISlider *sliderRed;
    __weak IBOutlet UISlider *sliderBlue;
    __weak IBOutlet UISlider *sliderGreen;
    
    float red;
    float blue;
    float green;
    
}

- (IBAction)redSlideChange:(id)sender;
- (IBAction)blueSlideChange:(id)sender;
- (IBAction)greenSlideChange:(id)sender;
- (void) changeBackground;

@end
