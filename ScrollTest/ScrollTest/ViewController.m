//
//  ViewController.m
//  ScrollTest
//
//  Created by Administrador on 9/17/13.
//  Copyright (c) 2013 orsurove. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    myScrollView.contentSize = contentView.frame.size;
    pageControl.numberOfPages = (int) (contentView.frame.size.width / myScrollView.frame.size.width);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Scroll View methods
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return contentView;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale{
    //[view setContentScaleFactor: scale];
    for (UIView *subView in view.subviews){
        subView.contentScaleFactor = scale * [UIScreen mainScreen].scale;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    int page = (int)(myScrollView.contentOffset.x / myScrollView.frame.size.width);
    pageControl.currentPage = page;
}
@end
