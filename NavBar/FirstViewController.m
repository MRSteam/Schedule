//
//  FirstViewController.m
//  NavBar
//
//  Created by Stas-PC on 08.10.12.
//  Copyright (c) 2012 Stas-PC. All rights reserved.
//

#import "FirstViewController.h"
#import "NavigationViewController2.h"


@implementation FirstViewController


@synthesize list = _list;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Спецкурсы";
        self.tabBarItem.image = [UIImage imageNamed:@"first"];
    }
    return self;
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    _list = [[NSArray alloc]initWithObjects:@"Математические",@"Гуманитарные", nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifer = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifer];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifer];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.textLabel.text = [ _list objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    specNum = indexPath.row+1;
    
    //create a DetailViewController object
    NavigationViewController2 *DVC = [[NavigationViewController2 alloc] initWithNibName:@"NavigationViewController2" bundle:nil];
    
    DVC.title = cell.text;
    
    //push the DetailViewController object onto the stack
    [self.navigationController pushViewController:DVC animated:YES];
}

-(void)viewWillDisappear:(BOOL)animated {
    NSIndexPath *selectedIndexPath = [self.myTableView indexPathForSelectedRow];
    [self.myTableView deselectRowAtIndexPath:selectedIndexPath animated:NO];
    
    [self.myTableView reloadData];
    ///попробовать сунуть выше
}





@end
