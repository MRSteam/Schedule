//
//  SettingsViewController.m
//  NavBar
//
//  Created by Stas-PC on 29.10.12.
//  Copyright (c) 2012 Stas-PC. All rights reserved.
//

#include <sqlite3.h>
#import "SettingsViewController.h"
#import "MyCLController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController
@synthesize yourGroupNumber ,myGeoLocation, myLabelTimer, myRemember, myLabelRemember, locationLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Настройки";
    }
    return self;
}

- (void)viewDidLoad
{
    locationController = [[MyCLController alloc] init];
    locationController.delegate = self;
    [locationController.locationManager startUpdatingLocation];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   
    NSString *docsDir;
    NSString *dirPaths;
    
    // Get the documents directory
    dirPaths = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    
    docsDir = [dirPaths stringByAppendingPathComponent:@"groupDB.sqlite"];//[dirPaths objectAtIndex:0];
    
    // Build the path to the database file
    databasePath = [[NSBundle mainBundle] pathForResource:@"groupDB" ofType:@"sqlite"];
    
    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt    *statement;
    
    if (sqlite3_open(dbpath, &groupDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat: @"SELECT NUMBER FROM MYGROUP WHERE ID=\"1\""];
        
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(groupDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                NSString *numberField = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                self.yourGroupNumber.text = [NSString stringWithFormat:@"%@", numberField];
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(groupDB);
    }
    
    
}

- (void)locationUpdate:(CLLocation *)location {
    locationLabel.text = [location description];
}

- (void)locationError:(NSError *)error {
    locationLabel.text = [error description];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)yourGroupNumberText:(id)sender {
    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt    *statement;
    
    if (sqlite3_open(dbpath, &groupDB) == SQLITE_OK)
    {
        NSString *insertSQL = [NSString stringWithFormat: @"INSERT INTO MYGROUP VALUES (\"1\", \"%@\")",yourGroupNumber.text];
        NSString *updateSQL = [NSString stringWithFormat:@"UPDATE MYGROUP SET number = '%@' WHERE id = '1'",yourGroupNumber.text];
        
        
        const char *insert_stmt = [insertSQL UTF8String];
        const char *update_stmt = [updateSQL UTF8String];
        
        sqlite3_prepare_v2(groupDB, insert_stmt, -1, &statement, NULL);
        
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            NSLog(@"sqlite3_insert OK");
        } else {
            NSLog(@"sqlite3_insert error: %s", sqlite3_errmsg(groupDB));
            sqlite3_prepare_v2(groupDB, update_stmt, -1, &statement, NULL);
            if (sqlite3_step(statement) == SQLITE_DONE)
            {
                NSLog(@"sqlite3_update OK");
            } else {
                NSLog(@"update error: '%s'", sqlite3_errmsg(groupDB));
            }
        }
        sqlite3_finalize(statement);
        sqlite3_close(groupDB);
    }
}

- (IBAction)doGeoLocation:(id)sender {
    if (myGeoLocation.on) {
        NSLog(@"GEO ON");
        [locationController.locationManager startUpdatingLocation];
        }
    else {
        NSLog(@"GEO OFF");
        [locationController.locationManager stopUpdatingLocation];
    }
}

- (IBAction)doRemember:(id)sender {
    if (myRemember.on)
    {
        NSLog(@"REMEMBER ON");
        myLabelRemember.hidden=NO;
        myLabelTimer.hidden=NO;
    }
    else
    {
        NSLog(@"REMEMBER OFF");
        myLabelRemember.hidden=YES;
        myLabelTimer.hidden=YES;
    }
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField {
    [yourGroupNumber resignFirstResponder];
    [myLabelTimer resignFirstResponder];
    return YES;
}


@end
