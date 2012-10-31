//
//  myAccessorValues.m
//  NavBar
//
//  Created by Stas-PC on 31.10.12.
//  Copyright (c) 2012 Stas-PC. All rights reserved.
//

#import "myAccessorValues.h"

@implementation myAccessorValues
//@synthesize myPairName, myPairTime, myAuditName, myDayName, myPairPrepod;

static NSString *myPairName;
static NSString *myPairTime;
static NSString *myAuditName;
static NSString *myPairPrepod;
static NSString *myDayName;
static UIImage *myPairImg;

 
/*- (void)myPairNameSet:(NSString *)myPairName
{
    myAccessorValues *newVal = [[self alloc] init];
    newVal.myPairName = myPairName;
}
*/

+(void)myPairNameSetter:(NSString *)_myPairName
{
    myPairName=_myPairName;
}

+(void)myPairTimeSetter:(NSString *)_myPairTime
{
    myPairTime=_myPairTime;
}
+(void)myAuditNameSetter:(NSString *)_myAuditName
{
    myAuditName=_myAuditName;
}
+(void)myPairPrepodSetter:(NSString *)_myPairPrepod
{
    myPairPrepod=_myPairPrepod;
}
+(void)myDayNameSetter:(NSString *)_myDayName{
    myDayName=_myDayName;
}

+(void)myPairImgSetter:(UIImage *)_myPairImg{
    myPairImg=_myPairImg;
}



+(NSString *)myPairNameAccessor
{
    return myPairName;
}

+(NSString*)myPairTimeAccessor {
    return myPairTime;
}

+(NSString*)myAuditNameAccessor {
    return myAuditName;
}

+(NSString*)myPairPrepodAccessor {
    return myPairPrepod;
}

+(NSString*)myDayNameAccessor {
    return myDayName;
}

+(UIImage*)myPairImgAccessor {
    return myPairImg;
}
@end
