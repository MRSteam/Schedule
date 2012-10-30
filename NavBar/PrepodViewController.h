//
//  PrepodViewController.h
//  NavBar
//
//  Created by Stas-PC on 30.10.12.
//  Copyright (c) 2012 Stas-PC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"

@interface PrepodViewController : UIViewController
<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate>
{
    sqlite3 *groupDB;
    NSString *databasePath;
}

@property (strong, nonatomic) IBOutlet UITableView *myTableView;

@property (strong, nonatomic) IBOutlet UIImageView *myImageView;
@property (strong, nonatomic) IBOutlet UILabel *myLastName;
@property (strong, nonatomic) IBOutlet UILabel *myFirstName;
@property (strong, nonatomic) IBOutlet UILabel *myThirdName;
@property (strong, nonatomic) IBOutlet UITextView *myTextView;

@end
