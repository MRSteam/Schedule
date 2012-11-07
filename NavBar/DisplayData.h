//
//  DisplayData.h
//  NavBar
//
//  Created by Stas-PC on 01.11.12.
//  Copyright (c) 2012 Stas-PC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DisplayData : UIViewController
<UITableViewDataSource, UITableViewDelegate>
{
    
    NSMutableData *webData;
    UIScrollView *titleScrollView;
    UITextView *textView;
    UIActivityIndicatorView* loadIndicator;
}

@property(nonatomic, retain) NSMutableData *webData;
@property(nonatomic,retain) IBOutlet    UIScrollView *titleScrollView;
@property (nonatomic, retain) UIActivityIndicatorView *loadIndicator;
//@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *loadIndicator;
- (void)ActivityIndigator;
@property (strong, nonatomic) IBOutlet UITableView *myTableView;

@end