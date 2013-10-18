//
//  ViewController.m
//  MapStuff
//
//  Created by Administrador on 10/18/13.
//  Copyright (c) 2013 orsurove. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>

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



#pragma mark - MapView Delegates
-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    //[mapView setCenterCoordinate:userLocation.coordinate animated:YES];
    MKCoordinateRegion region = MKCoordinateRegionMake(userLocation.coordinate,
                                                       MKCoordinateSpanMake(0.025, 0.025));
    [mapView setRegion:region animated:YES];
}

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    // Prevent modifiying user location pin
    if([annotation isKindOfClass:[MKUserLocation class]])
        return nil;

    MKPinAnnotationView *pin = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"pin"];
    if(pin == nil){
        pin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"pin"];
    }

    // Set pin properties
    pin.annotation = annotation;
    pin.pinColor = MKPinAnnotationColorGreen;
    pin.animatesDrop = YES;
    pin.canShowCallout = YES;

    // Add button to the right
    pin.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    
    return pin;
}

- (IBAction)annotationHandler:(UILongPressGestureRecognizer *)sender {
    // Prevents the ction being shown multiple times
    if(sender.state != UIGestureRecognizerStateBegan){
        return;
    }

    // Convert the location of the touch event into map cordinates
    CGPoint point = [sender locationInView:self.myMap];
    CLLocationCoordinate2D location = [self.myMap convertPoint:point
                                          toCoordinateFromView:self.myMap];

    // Create a new annotation
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    annotation.coordinate = location;
    annotation.title = @"Titulo";
    annotation.subtitle = @"Aqui";

    // Add it to the map
    [self.myMap addAnnotation:annotation];
}
@end
