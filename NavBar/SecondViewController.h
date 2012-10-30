//
//  SecondViewController.h
//  NavBar
//
//  Created by Stas-PC on 08.10.12.
//  Copyright (c) 2012 Stas-PC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"

@interface SecondViewController : UIViewController
<UIPickerViewDelegate, UIPickerViewDataSource>
{
    sqlite3 *groupDB;
    NSString *databasePath;
}


- (void)settingsButton:(id)sender;
- (void)dayButton:(id)sender;

@property (strong, nonatomic) IBOutlet UITextField *yourGroupNumber;
- (IBAction)yourGroupNumberApply:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *myLabel;
@property (strong, nonatomic) IBOutlet UIButton *myButton;
@property (strong, nonatomic) IBOutlet UITableView *myTableView;

@end
