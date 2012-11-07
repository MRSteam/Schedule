//
//  RaspViewController.h
//  NavBar
//
//  Created by Stas-PC on 10.10.12.
//  Copyright (c) 2012 Stas-PC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RaspViewController : UIViewController
<UITableViewDataSource, UITableViewDelegate>

@property (strong,nonatomic) NSArray * list; //список дней недели

@property (strong, nonatomic) IBOutlet UITableView *myTableView;
@end

NSString *myDayName;
int myDayNumber;