//
//  FourViewController.h
//  NavBar
//
//  Created by Stas-PC on 29.10.12.
//  Copyright (c) 2012 Stas-PC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"

@interface FourViewController : UIViewController
<UISearchBarDelegate,UITableViewDataSource, UITableViewDelegate>
{
    sqlite3 *groupDB;
    NSString *databasePath;
}

@property (strong, nonatomic) IBOutlet UITableView *myTableView;
@property (strong, nonatomic) IBOutlet UISearchBar *mySearchBar;

@end

NSString *myPrepodName;