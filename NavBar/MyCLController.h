//
//  MyCLController.h
//  NavBar
//
//  Created by Stas-PC on 31.10.12.
//  Copyright (c) 2012 Stas-PC. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MyCLControllerDelegate
@required
- (void)locationUpdate:(CLLocation *)location;
- (void)locationError:(NSError *)error;
@end

@interface MyCLController : NSObject  {
    CLLocationManager *locationManager;
    id delegate;
}

@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, assign) id  delegate;

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation;

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error;

@end