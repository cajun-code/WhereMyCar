//
//  CarParkingViewController.h
//  WhereMyCar
//
//  Created by Allan Davis on 7/16/13.
//  Copyright (c) 2013 Allan Davis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface CarParkingViewController : UIViewController<CLLocationManagerDelegate>

const extern NSString *SAVED;
@property (weak, nonatomic) IBOutlet UITextField *latitude;

@property (weak, nonatomic) IBOutlet UITextField *longitude;

@property (weak, nonatomic) IBOutlet UITextField *note;
- (IBAction)getLocation:(UIButton *)sender;

- (IBAction)saveLocation:(UIButton *)sender;
@end
