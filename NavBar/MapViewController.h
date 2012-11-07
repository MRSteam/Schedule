//
//  MapViewController.h
//  NavBar
//
//  Created by Stas-PC on 05.11.12.
//  Copyright (c) 2012 Stas-PC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "MapPoint.h"

#define kGOOGLE_API_KEY @"AIzaSyCxZWRg2FKT-H_H0ewRkfBcz4ONcwaadSI"
#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

@interface MapViewController : UIViewController
<MKMapViewDelegate, CLLocationManagerDelegate>

- (void)toolBarButtonPress:(id)sender;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *loadIndicator;

- (void)ActivityIndigator;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;



@end
