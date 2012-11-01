//
//  MyCLController.m
//  NavBar
//
//  Created by Stas-PC on 31.10.12.
//  Copyright (c) 2012 Stas-PC. All rights reserved.
//

#import "MyCLController.h"

@implementation MyCLController

@synthesize locationManager;
//@synthesize delegate;

- (id) init {
    self = [super init];
    if (self != nil) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self; // send loc updates to myself
    }
    return self;
}

- (void)locationManager:(CLLocationManager *)manager
	didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    [self.delegate locationUpdate:newLocation];
}

- (void)locationManager:(CLLocationManager *)manager
	   didFailWithError:(NSError *)error
{
    [self.delegate locationError:error];
}


@end
