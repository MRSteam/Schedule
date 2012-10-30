//
//  FourViewController.m
//  NavBar
//
//  Created by Stas-PC on 29.10.12.
//  Copyright (c) 2012 Stas-PC. All rights reserved.
//

#include <sqlite3.h>
#import "FourViewController.h"
#import "RaspViewController.h"
#import "DayMy.h"
#import "PrepodViewController.h"

@interface FourViewController ()
{
    NSMutableArray *totalStrings;
    NSMutableArray *filteredStrings;
    BOOL isFiltered;
}

@end

@implementation FourViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Преподаватели";
        self.tabBarItem.image = [UIImage imageNamed:@"first"];
    }
    return self;
}

- (void)viewDidLoad
{
    
    // Do any additional setup after loading the view from its nib.
    self.mySearchBar.delegate = self;
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    
    NSString *docsDir;
    NSString *dirPaths;
    
    // Get the documents directory
    dirPaths = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    
    docsDir = [dirPaths stringByAppendingPathComponent:@"groupDB.sqlite"];//[dirPaths objectAtIndex:0];
    
    // Build the path to the database file
    databasePath = [[NSBundle mainBundle] pathForResource:@"groupDB" ofType:@"sqlite"];
    
    const char *dbpath = [databasePath UTF8String];
    
    //если группа уже задана, то отображаем расписание
    
    NSString *pairName, *pairPrepod;
    
    sqlite3_stmt    *statement;
    
    totalStrings = [[NSMutableArray alloc] init];
    
    if (sqlite3_open(dbpath, &groupDB) == SQLITE_OK)
    {
                NSString *querySQL = [NSString stringWithFormat: @"SELECT * FROM PMAIN"];
                const char *query_stmt = [querySQL UTF8String];
                if (sqlite3_prepare_v2(groupDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
                {
                    while (sqlite3_step(statement) == SQLITE_ROW)
                    {
                        pairName = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
                        pairPrepod=[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                        [totalStrings addObject:[DayMy dayWithType:nil kaf:nil para:pairName aud:nil day:nil ptime:nil prepod:pairPrepod pid:nil descr:nil kyrs:nil]];
                    }
                    //сортировка массива пар для дня, по времени
                    NSArray *sortedArray;
                    sortedArray = [totalStrings sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
                        NSString *first = [(DayMy*)a prepod];
                        NSString *second = [(DayMy*)b prepod];
                        return [first compare:second];
                    }];
                    totalStrings = sortedArray;
                }
    }

    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (searchText.length == 0) {
        isFiltered = NO;
    }
    else {
        isFiltered = YES;
        filteredStrings = [[NSMutableArray alloc]init];
        
        for (NSString *str in totalStrings) {
            NSRange stringRange1 = [str rangeOfString:searchText options:NSCaseInsensitiveSearch];
            
            if (stringRange1.location != NSNotFound) {
                [filteredStrings addObject:str];
            }
        }
    }
    [self.myTableView reloadData];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.mySearchBar resignFirstResponder];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    searchBar.text=@"";
    isFiltered = NO;
    [self.myTableView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (isFiltered) {
        return [filteredStrings count];
    }
    return [totalStrings count];
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    
	if(isFiltered)
		return -1;
	
	return index % 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifer = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifer];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifer];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    if (!isFiltered)
    {
        DayMy *cellValue1 = [totalStrings objectAtIndex:indexPath.row];
        cell.textLabel.text = cellValue1.prepod;
        
    }
    else
    {
        DayMy *cellValue1 = [totalStrings objectAtIndex:indexPath.row];
        cell.textLabel.text = cellValue1.prepod;
    }
    
    return cell;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DayMy *cell = nil;
    cell = [totalStrings objectAtIndex:indexPath.row];
    myPrepodName=cell.prepod;
    
    PrepodViewController *DVC = [[PrepodViewController alloc] initWithNibName:@"PrepodViewController" bundle:nil];
    
    //push the DetailViewController object onto the stack
    [self.navigationController pushViewController:DVC animated:YES];
    
}


-(void)viewWillDisappear:(BOOL)animated {
    NSIndexPath *selectedIndexPath = [self.myTableView indexPathForSelectedRow];
    [self.myTableView deselectRowAtIndexPath:selectedIndexPath animated:NO];
    
    [self.myTableView reloadData];
}


@end
