//
//  FindCarViewController.m
//  WhereMyCar
//
//  Created by Allan Davis on 7/16/13.
//  Copyright (c) 2013 Allan Davis. All rights reserved.
//

#import "FindCarViewController.h"
#import "CarParkingViewController.h"
#import "CarLocation.h"

@interface FindCarViewController ()

@end

@implementation FindCarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updatePin) name:SAVED object:nil];
    [self updatePin];
    self.manager = [[CLLocationManager alloc] init];
    self.manager.delegate = self;
    [self.manager startUpdatingLocation];
    
    //Set the properties of the annotation and add this to the map
    self.me = [[MKPointAnnotation alloc]init];
    self.me.title = @"Your current position";
    self.me.subtitle =@"This annotation shows your current position";
    self.me.coordinate =  self.currentLoc.coordinate;
    [self.mapView addAnnotation:self.me];
    //Define the region of the map
    CLLocationCoordinate2D regionCenter = self.currentLoc.coordinate;
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(regionCenter, 400, 400);
    [self.mapView setRegion:region animated:TRUE];
    self.mapView.delegate = self;
}


- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>) annotation
{
    MKPinAnnotationView *newAnnotation = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"redpin"];
    if([annotation isEqual:self.me]){
        newAnnotation.pinColor = MKPinAnnotationColorGreen;
    }else{
        newAnnotation.pinColor = MKPinAnnotationColorRed;
    }
    newAnnotation.animatesDrop = YES;
    newAnnotation.canShowCallout = YES;
    return newAnnotation;
        
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) updatePin{
    CarLocation * carPoint = [CarLocation sharedInstance];
    
    if( self.car)
       [self.mapView removeAnnotation:self.car];
    self.car = [[MKPointAnnotation alloc]init];
    
    self.car.title = @"My Car is Here";
    
    CLLocationCoordinate2D coords;
    
    coords.latitude = carPoint.latitude.doubleValue;
    coords.longitude = carPoint.longitude.doubleValue;
    
    self.car.coordinate = coords;
    
    [self.mapView addAnnotation:self.car];
    
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations {
    self.currentLoc = [locations lastObject];
    self.me.coordinate = self.currentLoc.coordinate;
    [self.mapView setCenterCoordinate:self.currentLoc.coordinate animated:TRUE];
}

@end
