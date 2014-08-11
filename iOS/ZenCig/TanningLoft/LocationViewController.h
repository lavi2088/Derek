//
//  LocationViewController.h
//  TanningLoft
//
//  Created by Lavi on 30/06/13.
//  Copyright (c) 2013 restdemo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "myAnnotation.h"

#define METERS_PER_MILE 1609.344

@interface LocationViewController : UIViewController<MKMapViewDelegate,CLLocationManagerDelegate>
@property(nonatomic,retain)IBOutlet MKMapView *mapView;
@end
