//
//  CarLocation.m
//  WhereMyCar
//
//  Created by Allan Davis on 7/16/13.
//  Copyright (c) 2013 Allan Davis. All rights reserved.
//

#import "CarLocation.h"

@implementation CarLocation

const NSString *LAT_KEY = @"WHERE_MY_CAR_LATITUDE";
const NSString *LONG_KEY = @"WHERE_MY_CAR_LONGITUDE";
const NSString *NOTE_KEY = @"WHERE_MY_CAR_NOTE";

-(NSString *) latitude{
    return [[NSUserDefaults standardUserDefaults] objectForKey: LAT_KEY];
}

-(NSString *) longitude{
    return [[NSUserDefaults standardUserDefaults] objectForKey: LONG_KEY];
}

-(NSString *) note{
    return [[NSUserDefaults standardUserDefaults] objectForKey: NOTE_KEY];
}


-(void) setLatitude:(NSString *)latitude{
        [[NSUserDefaults standardUserDefaults] setObject: latitude forKey: LAT_KEY];
}

-(void) setLongitude:(NSString *)longitude{
    [[NSUserDefaults standardUserDefaults] setObject: longitude forKey: LONG_KEY];
}

-(void) setNote:(NSString *)note{
    [[NSUserDefaults standardUserDefaults] setObject: note forKey: NOTE_KEY];
}

+ (id)sharedInstance
{
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init]; // or some other init method
    });
    return _sharedObject;
    
}

@end
