//
//  FirstViewController.h
//  NavBar
//
//  Created by Stas-PC on 08.10.12.
//  Copyright (c) 2012 Stas-PC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewController : UIViewController
<UITableViewDataSource, UITableViewDelegate>


@property (strong,nonatomic) NSArray * list;

@property (strong, nonatomic) IBOutlet UITableView *myTableView;

@end

int specNum;