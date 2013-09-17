//
//  ViewController.h
//  ScrollTest
//
//  Created by Administrador on 9/17/13.
//  Copyright (c) 2013 orsurove. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIScrollViewDelegate>
{
    
    __weak IBOutlet UIScrollView *myScrollView;
    __weak IBOutlet UIView *contentView;
    __weak IBOutlet UIPageControl *pageControl;
}

@end
