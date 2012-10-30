//
//  DateTime.m
//  NavBar
//
//  Created by Stas-PC on 30.10.12.
//  Copyright (c) 2012 Stas-PC. All rights reserved.
//

#import "DateTime.h"

@implementation DateTime


-(NSString *)currDay:(int)_currDay;
{
    switch (_currDay) {
        case 1:
            day = @"Воскресение";
            break;
        case 2:
            day = @"Понедельник";
            break;
        case 3:
            day = @"Вторник";
            break;
        case 4:
            day = @"Среда";
            break;
        case 5:
            day = @"Четверг";
            break;
        case 6:
            day = @"Пятница";
            break;
        case 7:
            day = @"Суббота";
            break;
    }
    return day;
}

@end
