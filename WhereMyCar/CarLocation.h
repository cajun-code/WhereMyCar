//
//  CarLocation.h
//  WhereMyCar
//
//  Created by Allan Davis on 7/16/13.
//  Copyright (c) 2013 Allan Davis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CarLocation : NSObject

@property (strong, nonatomic) NSString *latitude;
@property (strong, nonatomic) NSString *longitude;
@property (strong, nonatomic) NSString *note;


+ (id)sharedInstance;

@end
