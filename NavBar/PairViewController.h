//
//  PairViewController.h
//  NavBar
//
//  Created by Stas-PC on 26.10.12.
//  Copyright (c) 2012 Stas-PC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PairViewController : UIViewController
<UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UILabel *myLabelTime;
@property (strong, nonatomic) IBOutlet UILabel *myLabelPair;
@property (strong, nonatomic) IBOutlet UILabel *myLabelDay;
@property (strong, nonatomic) IBOutlet UILabel *myLabelAudit;
@property (strong, nonatomic) IBOutlet UIImageView *myImage;
@property (strong, nonatomic) IBOutlet UILabel *myLabelPrepod;
@end
