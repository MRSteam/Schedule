//
//  NavigationViewController2.h
//  NavBar
//
//  Created by Stas-PC on 26.10.12.
//  Copyright (c) 2012 Stas-PC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"

@interface NavigationViewController2 : UIViewController
<UISearchBarDelegate,UITableViewDataSource, UITableViewDelegate>
{
    sqlite3 *groupDB;
    NSString *databasePath;
}

@property (weak, nonatomic) IBOutlet UISearchBar *mySearchBar;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@end


NSString *myPairName;