//
//  DayMy.m
//  NavBar
//
//  Created by Stas-PC on 27.10.12.
//  Copyright (c) 2012 Stas-PC. All rights reserved.
//

#import "DayMy.h"

@implementation DayMy

@synthesize num, kaf, para, aud, day, ptime, prepod, pid, descr, kyrs;

+ (id)dayWithType:(NSString *)num kaf:(NSString *)kaf para:(NSString *)para aud:(NSString *)aud day:(NSString *)day ptime:(NSString *)ptime prepod:(NSString *)prepod pid:(NSString *)pid descr:(NSString *)descr kyrs:(NSString *)kyrs
{
    DayMy *newPair = [[self alloc] init];
    newPair.num = num;
    newPair.kaf = kaf;
    newPair.para = para;
    newPair.aud = aud;
    newPair.day = day;
    newPair.ptime = ptime;
    newPair.prepod = prepod;
    newPair.pid = pid;
    newPair.descr = descr;
    newPair.kyrs = kyrs;
    return newPair;
}


@end
