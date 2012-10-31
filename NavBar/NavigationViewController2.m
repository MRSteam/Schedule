//
//  NavigationViewController2.m
//  NavBar
//
//  Created by Stas-PC on 26.10.12.
//  Copyright (c) 2012 Stas-PC. All rights reserved.
//

#include <sqlite3.h>
#import "FirstViewController.h"
#import "NavigationViewController2.h"
#import "PairViewController.h"
#import "DayMy.h"
#import "DayViewController.h"
#import "myAccessorValues.h"

@interface NavigationViewController2 ()
{
    NSMutableArray *totalStrings;
    NSMutableArray *filteredStrings;
    BOOL isFiltered;
}

@end

@implementation NavigationViewController2

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //self.title = @"Матем-Гум-Тест";
        self.tabBarItem.image = [UIImage imageNamed:@"first"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
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
        
        NSString *pairName, *pairTime, *pairAud, *pairPrepod, *currentDay;
        int stringInt;
        sqlite3_stmt    *statement;
        totalStrings = [[NSMutableArray alloc] init];
        
        const char *dbpath = [databasePath UTF8String];
        if (sqlite3_open(dbpath, &groupDB) == SQLITE_OK)
        {
            NSString *querySQL = [NSString stringWithFormat: @"SELECT * FROM MAIN WHERE NUM=\"%d\"",specNum];
            //NSLog(@"specNum: %d",specNum);
            
            const char *query_stmt = [querySQL UTF8String];
            
            if (sqlite3_prepare_v2(groupDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
            {
                    while (sqlite3_step(statement) == SQLITE_ROW)
                    {
                        stringInt = [[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 5)] intValue];
                        switch (stringInt) {
                            case 1:
                                currentDay = @"Воскресение";
                                break;
                            case 2:
                                currentDay = @"Понедельник";
                                break;
                            case 3:
                                currentDay = @"Вторник";
                                break;
                            case 4:
                                currentDay = @"Среда";
                                break;
                            case 5:
                                currentDay = @"Четверг";
                                break;
                            case 6:
                                currentDay = @"Пятница";
                                break;
                            case 7:
                                currentDay = @"Суббота";
                                break;
                        }
                        pairName = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 3)];
                        pairTime = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 6)];
                        pairAud =  [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 4)];
                        pairPrepod=[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 7)];
                        
                        [totalStrings addObject:[DayMy dayWithType:nil kaf:nil para:pairName aud:pairAud day:currentDay ptime:pairTime prepod:pairPrepod pid:nil descr:nil kyrs:nil]];
                        NSLog(@"! %@ !", pairName);
                    }
                    
                    if (totalStrings != nil)
                    {
                        //сортировка массива пар для дня, по времени
                        NSArray *sortedArray;
                        sortedArray = [totalStrings sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
                            NSString *first = [(DayMy*)a para];
                            NSString *second = [(DayMy*)b para];
                            return [first compare:second];
                        }];
                        totalStrings = sortedArray;
                    }
                sqlite3_finalize(statement);
            }
            sqlite3_close(groupDB);
        }
    //totalStrings = [[NSMutableArray alloc] initWithObjects:@"Численные методы",@"Компьютерное зрение",nil];
    
    
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (searchText.length == 0) {
        isFiltered = NO;
    }
    else {
        isFiltered = YES;
        filteredStrings = [[NSMutableArray alloc]init];
        
        NSString *str;
        
        for (int i=0; i<[totalStrings count]; i++) {
            DayMy *value = [totalStrings objectAtIndex:i];
            str = value.para;
            
            NSRange stringRange1 = [str rangeOfString:searchText options:NSCaseInsensitiveSearch];
            
            if (stringRange1.location != NSNotFound) {
                [filteredStrings addObject:value];
            }
        }
    }
    [self.myTableView reloadData];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.mySearchBar resignFirstResponder];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (isFiltered) {
        return [filteredStrings count];
    }
    return [totalStrings count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellID = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
    }
    if (!isFiltered)
    {
        //cell.textLabel.text = [totalStrings objectAtIndex:indexPath.row];

            DayMy *cellValue = [totalStrings objectAtIndex:indexPath.row];
            cell.textLabel.text = cellValue.para;
        
    }
    else
    {
        //cell.textLabel.text = [filteredStrings objectAtIndex:indexPath.row];

            DayMy *cellValue = [filteredStrings objectAtIndex:indexPath.row];
            cell.textLabel.text = cellValue.para;
        
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

    [myAccessorValues myPairNameSetter:cell.para];
    [myAccessorValues myPairTimeSetter:cell.ptime];
    [myAccessorValues myAuditNameSetter:cell.aud];
    [myAccessorValues myPairPrepodSetter:cell.prepod];
    [myAccessorValues myDayNameSetter:cell.day];
    [myAccessorValues myPairImgSetter:[UIImage imageNamed:@"stas.jpg"]];
    
    //create a DetailViewController object
    PairViewController *DVC = [[PairViewController alloc] initWithNibName:@"PairViewController" bundle:nil];
    
    //push the DetailViewController object onto the stack
    [self.navigationController pushViewController:DVC animated:YES];
}

-(void)viewWillDisappear:(BOOL)animated {
    NSIndexPath *selectedIndexPath = [self.myTableView indexPathForSelectedRow];
    [self.myTableView deselectRowAtIndexPath:selectedIndexPath animated:NO];
    
    [self.myTableView reloadData];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
