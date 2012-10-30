//
//  DayViewController.h
//  NavBar
//
//  Created by Stas-PC on 26.10.12.
//  Copyright (c) 2012 Stas-PC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"

@interface DayViewController : UIViewController
{
    sqlite3 *groupDB;
    NSString *databasePath;
}


@property (strong, nonatomic) IBOutlet UITableView *myTableView;

@end

NSString *myPairName;
NSString *myPairTime;
NSString *myAuditName;
NSString *myPairPrepod;
NSString *myDayName;
UIImage *myPairImg;