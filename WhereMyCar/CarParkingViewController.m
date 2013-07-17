//
//  CarParkingViewController.m
//  WhereMyCar
//
//  Created by Allan Davis on 7/16/13.
//  Copyright (c) 2013 Allan Davis. All rights reserved.
//

#import "CarParkingViewController.h"
#import "CarLocation.h"


@interface CarParkingViewController ()

@property CLLocationManager *manager;
@property BOOL isUpdatingLocations;

@end

@implementation CarParkingViewController

NSString * const LOCATION_SUBMIT_SUCCESS = @"WMC_LOCATION_SUBMIT_SUCCESSFUL";
NSString * const LOCATION_NOT_AVAILABLE = @"WMC_LOCATION_NOT_AVAILABLE";
NSString * const LOCATION_ACCESS_DENIDED = @"WMC_LOCATION_OFF";
NSString * const LOCATION_NETWORK_UNAVAILABLE = @"WMC_LOCATION_NETWORK_DOWN";
const extern NSString *SAVED= @"WMC_LOCATION_SAVED";

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
    self.manager = [[CLLocationManager alloc] init];
    self.manager.desiredAccuracy = kCLLocationAccuracyBest;
    self.manager.distanceFilter = kCLDistanceFilterNone;
    self.manager.delegate = self;
    self.isUpdatingLocations = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)getLocation:(UIButton *)sender {
    if (self.isUpdatingLocations) {
        [self.manager stopUpdatingLocation];
        self.isUpdatingLocations = NO;
    }else{
        [self.manager startUpdatingLocation];
        self.isUpdatingLocations = YES;
    }
    
}

- (IBAction)saveLocation:(UIButton *)sender {
    CarLocation * car = [CarLocation sharedInstance];
    car.longitude = self.longitude.text;
    car.latitude = self.latitude.text;
    car.note = self.note.text;
    
    [self postMessage:@"New Car Point Saved" forKey:SAVED];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Location Stored" message:@"Your Location has been stored" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}

-(void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation *location = [locations lastObject];
    
    self.latitude.text = [NSString stringWithFormat:@"%f", location.coordinate.latitude];
    self.longitude.text = [NSString stringWithFormat:@"%f", location.coordinate.longitude];
    
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    
    switch([error code]){
        case kCLErrorLocationUnknown:{
            NSString *message = @"It is not possible to obtain current location";
            [self postMessage:message forKey:LOCATION_NOT_AVAILABLE];
            break;
            
        }
        case kCLErrorDenied:{
            NSString *message = @"User has denied permission to use location services. Go to Settings > Privacy >Location and enable Location Services for the app.";
            [self postMessage:message forKey:LOCATION_ACCESS_DENIDED];
            break;
        }
        case kCLErrorNetwork:{
            NSString *message = @"Make sure your network connection is activated or that you are not in Airplane Mode";
            [self postMessage:message forKey:LOCATION_NETWORK_UNAVAILABLE];
            break;
        }
            
    }
}


-(void)postMessage:(NSString*)message forKey:(NSString *)key{
    NSLog(@"%@",message);
    NSDictionary* params = [NSDictionary dictionaryWithObject:message
                                                       forKey:@"message"];
    
    NSNotification *note = [NSNotification notificationWithName:key
                                                         object:self
                                                       userInfo:params];
    [[NSNotificationCenter defaultCenter] postNotification:note];
}
@end
