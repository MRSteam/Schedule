//
//  DayMy.h
//  NavBar
//
//  Created by Stas-PC on 27.10.12.
//  Copyright (c) 2012 Stas-PC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DayMy : NSObject
{
    NSString *num;
    NSString *kaf;
    NSString *para;
    NSString *aud;
    NSString *day;
    NSString *ptime;
    NSString *prepod;
    NSString *pid;
    NSString *descr;
    NSString *kyrs;
}

@property (nonatomic, copy) NSString *num, *kaf, *para, *aud, *day, *ptime, *prepod, *pid, *descr, *kyrs;

+ (id)dayWithType:(NSString *)num kaf:(NSString *)kaf para:(NSString *)para aud:(NSString *)aud day:(NSString *)day ptime:(NSString *)ptime prepod:(NSString *)prepod pid:(NSString *)pid descr:(NSString *)descr kyrs:(NSString *)kyrs;

@end