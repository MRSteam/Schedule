//
//  myAccessorValues.h
//  NavBar
//
//  Created by Stas-PC on 31.10.12.
//  Copyright (c) 2012 Stas-PC. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface myAccessorValues : NSObject
/*{
    NSString *myPairName;
    NSString *myPairTime;
    NSString *myAuditName;
    NSString *myPairPrepod;
    NSString *myDayName;
    UIImage *myPairImg;
}*/

+(NSString*)myPairNameAccessor;
+(NSString*)myPairTimeAccessor;
+(NSString*)myAuditNameAccessor;
+(NSString*)myPairPrepodAccessor;
+(NSString*)myDayNameAccessor;
+(UIImage*)myPairImgAccessor;
+(void)myPairNameSetter:(NSString *)_myPairName;
+(void)myPairTimeSetter:(NSString *)_myPairTime;
+(void)myAuditNameSetter:(NSString *)_myAuditName;
+(void)myPairPrepodSetter:(NSString *)_myPairPrepod;
+(void)myDayNameSetter:(NSString *)_myDayName;
+(void)myPairImgSetter:(UIImage *)_myPairImg;

//@property (nonatomic, strong) NSString *myPairName, *myPairTime, *myAuditName, *myPairPrepod, *myDayName, *myPairImg;

//- (void)myPairNameSet:(NSString *)myPairName;

typedef enum {first = 10, second = 20, third = 30} EnumName;

@end


//если не писать свои сеттеры и геттеры то придется передавать объект нашего класса, а так передавать ничего не надо

