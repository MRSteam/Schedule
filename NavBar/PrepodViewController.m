//
//  PrepodViewController.m
//  NavBar
//
//  Created by Stas-PC on 30.10.12.
//  Copyright (c) 2012 Stas-PC. All rights reserved.
//

#include <sqlite3.h>
#import "PrepodViewController.h"
#import "DayMy.h"
#import "FourViewController.h"
#import "DayViewController.h"
#import "PairViewController.h"
#import "myAccessorValues.h"

@interface PrepodViewController ()
{
    NSMutableArray *totalStrings;
}
@end

@implementation PrepodViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
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

        NSString *querySQL = [NSString stringWithFormat: @"SELECT * FROM MAIN WHERE PREPOD=\"%@\"",myPrepodName];
        
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
                      
                    }
                
                if (totalStrings != nil)
                {
                    //сортировка массива пар для дня, по времени
                    NSArray *sortedArray;
                    sortedArray = [totalStrings sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
                        NSString *first = [(DayMy*)a ptime];
                        NSString *second = [(DayMy*)b ptime];
                        return [first compare:second];
                    }];
                    totalStrings = sortedArray;
                }
            sqlite3_finalize(statement);
        }
        sqlite3_close(groupDB);
    }

    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.myTextView.text = @"Информация о преподавателе";

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [totalStrings count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifer = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifer];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifer];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    if ([totalStrings count]>=1)
    {
        DayMy *cellValue = [totalStrings objectAtIndex:indexPath.row];
        cell.textLabel.text = cellValue.para;
    }
    
    return cell;
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

@end
