//
//  PairViewController.m
//  NavBar
//
//  Created by Stas-PC on 26.10.12.
//  Copyright (c) 2012 Stas-PC. All rights reserved.
//

#import "PairViewController.h"
#import "NavigationViewController2.h"
#import "DayViewController.h"
#import "RaspViewController.h"

@interface PairViewController ()

@end

@implementation PairViewController

//@synthesize myLabelPair = myLabelPair;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        NSString *stringWithInteger = [NSString stringWithFormat: myPairName];
        self.title = stringWithInteger;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.myLabelPair.text = myPairName;
    self.myLabelTime.text = myPairTime;
    self.myLabelDay.text = myDayName;
    self.myLabelAudit.text = myAuditName;
    self.myLabelPrepod.text=myPairPrepod;
    self.myImage.image = myPairImg;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
