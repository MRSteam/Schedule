//вьюшка для отображения недельного вида, отображения всех дней в таблице

//
//  RaspViewController.m
//  NavBar
//
//  Created by Stas-PC on 10.10.12.
//  Copyright (c) 2012 Stas-PC. All rights reserved.
//

#import "RaspViewController.h"
#import "DetailViewController.h"
#import "ThirdViewController.h"
#import "DayViewController.h"

@interface RaspViewController ()

@end

@implementation RaspViewController


@synthesize list = _list;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        NSString *stringWithInteger = [NSString stringWithFormat: @"%@ группа", courseName];
        self.title = stringWithInteger;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //Set up our NSArray objects
    _list = [[NSArray alloc] initWithObjects:@"Понедельник",@"Вторник",@"Среда",@"Четверг",@"Пятница",@"Суббота",@"Воскресение", nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
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

    myDayName = [_list objectAtIndex:indexPath.row];
    switch (indexPath.row) {
        case 6:
            myDayNumber = 1;
            break;
        default:
            myDayNumber = indexPath.row+2;
            break;
    }
    
        
    //create a DetailViewController object
    DayViewController *DVC = [[DayViewController alloc] initWithNibName:@"DayViewController" bundle:nil];
    
    //Pass the row to the DetailViewController (row - number of a day)
    //DVC.DayNumber = indexPath.row;
    
    //push the DetailViewController object onto the stack
    [self.navigationController pushViewController:DVC animated:YES];
}

-(void)viewWillDisappear:(BOOL)animated {
    NSIndexPath *selectedIndexPath = [self.myTableView indexPathForSelectedRow];
    [self.myTableView deselectRowAtIndexPath:selectedIndexPath animated:NO];
    
    [self.myTableView reloadData];
}

@end
