//
//  NavigationViewController.h
//  NavBar
//
//  Created by Stas-PC on 08.10.12.
//  Copyright (c) 2012 Stas-PC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"

@interface ThirdViewController : UIViewController
<UISearchBarDelegate,UITableViewDataSource, UITableViewDelegate>
{
    sqlite3 *groupDB;
    NSString *databasePath;
}

@property (weak, nonatomic) IBOutlet UISearchBar *mySearchBar;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

///sql
@property (strong, nonatomic) IBOutlet UITextField *number;
@property (strong, nonatomic) IBOutlet UITextField *kaf;
@property (strong, nonatomic) IBOutlet UITextField *kom;


@end

int courseNumber;
NSString *courseName;


