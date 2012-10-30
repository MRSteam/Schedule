//
//  SettingsViewController.h
//  NavBar
//
//  Created by Stas-PC on 29.10.12.
//  Copyright (c) 2012 Stas-PC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"


@interface SettingsViewController : UIViewController
{
    sqlite3 *groupDB;
    NSString *databasePath;
}

@property (strong, nonatomic) IBOutlet UITextField *yourGroupNumber;
- (IBAction)yourGroupNumberText:(id)sender;
- (IBAction)doGeoLocation:(id)sender;
- (IBAction)doRemember:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *myLabelTimer;
@property (strong, nonatomic) IBOutlet UISwitch *myRemember;
@property (strong, nonatomic) IBOutlet UISwitch *myGeoLocation;
@property (strong, nonatomic) IBOutlet UILabel *myLabelRemember;

@end
