//
//  Venues.h
//  NavBar
//
//  Created by Stas-PC on 04.11.12.
//  Copyright (c) 2012 Stas-PC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Venues : NSObject
{
    NSString *name;
    NSString *suffix;
    NSString *prefix;
    NSString *image;
    NSString *distance;
    NSString *checkins;
    NSString *lat;
    NSString *lng;
}

@property (nonatomic, retain) NSString *name, *suffix, *prefix, *image, *distance, *checkins, *lat, *lng;

@end
