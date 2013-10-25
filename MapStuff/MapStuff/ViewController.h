//
//  ViewController.h
//  MapStuff
//
//  Created by Administrador on 10/18/13.
//  Copyright (c) 2013 orsurove. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface ViewController : UIViewController <MKMapViewDelegate>{
    CLLocationCoordinate2D lastCoordinate;
    BOOL isFirst;
}

@property (weak, nonatomic) IBOutlet MKMapView *myMap;

@end
