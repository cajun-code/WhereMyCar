//
//  FindCarViewController.h
//  WhereMyCar
//
//  Created by Allan Davis on 7/16/13.
//  Copyright (c) 2013 Allan Davis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface FindCarViewController : UIViewController<CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) MKPointAnnotation * car;
@property (strong, nonatomic) MKPointAnnotation * me;
@property (strong, nonatomic) CLLocationManager *manager;
@property (strong, nonatomic) CLLocation *currentLoc;

@end
