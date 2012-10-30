//
//  DateTime.h
//  NavBar
//
//  Created by Stas-PC on 30.10.12.
//  Copyright (c) 2012 Stas-PC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateTime : NSObject
{
    NSString *day;
}

- (NSString *)currDay: (int)_currDay;

@end
