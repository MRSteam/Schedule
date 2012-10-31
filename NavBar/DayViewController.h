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

+(NSString*)myVarAccessor;
@property (strong, nonatomic) IBOutlet UITableView *myTableView;

@end

