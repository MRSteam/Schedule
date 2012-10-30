//
//  SecondViewController.m
//  NavBar
//
//  Created by Stas-PC on 08.10.12.
//  Copyright (c) 2012 Stas-PC. All rights reserved.
//

#include <sqlite3.h>
#import "SecondViewController.h"
#import "RaspViewController.h"
#import "SettingsViewController.h"
#import "DayMy.h"
#import "DayViewController.h"
#import "PairViewController.h"
#import "ThirdViewController.h"

@interface SecondViewController ()
{
    NSMutableArray *totalStrings;
    NSString *numberField;
}

@end

@implementation SecondViewController

@synthesize yourGroupNumber, myLabel, myButton;

int groupMy = 0;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Личное";
        self.tabBarItem.image = [UIImage imageNamed:@"second"];
    }
    return self;
}

							
- (void)viewDidLoad
{
	// Do any additional setup after loading the view, typically from a nib.
    
    UIBarButtonItem *settingsButton = [[UIBarButtonItem alloc] initWithTitle:@"Настройки" style:UIBarButtonItemStyleDone target:self action:@selector(settingsButton:)];
    self.navigationItem.rightBarButtonItem = settingsButton;
 
    UIBarButtonItem *dayButton = [[UIBarButtonItem alloc] initWithTitle:@"Неделя" style:UIBarButtonItemStyleDone target:self action:@selector(dayButton:)];
    self.navigationItem.leftBarButtonItem = dayButton;
    
    NSString *docsDir;
    NSString *dirPaths;
    
    // Get the documents directory
    dirPaths = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    
    docsDir = [dirPaths stringByAppendingPathComponent:@"groupDB.sqlite"];//[dirPaths objectAtIndex:0];
    
    // Build the path to the database file
    databasePath = [[NSBundle mainBundle] pathForResource:@"groupDB" ofType:@"sqlite"];
    
    
    
    
        const char *dbpath = [databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &groupDB) == SQLITE_OK)
        {
            char *errMsg;
            const char *sql_stmt = "CREATE TABLE IF NOT EXISTS MYGROUP (ID INTEGER PRIMARY KEY AUTOINCREMENT, NUMBER TEXT)";
            
            sqlite3_exec(groupDB, sql_stmt, NULL, NULL, &errMsg);
            
            if (sqlite3_exec(groupDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
            {
                NSLog(@"Failed to create table MYGROUP");
            }
            else
            {NSLog(@"OK for table MYGROUP");}
            
            ///
            const char *sql_stmt2 = "CREATE TABLE IF NOT EXISTS MAIN (ID INTEGER PRIMARY KEY AUTOINCREMENT, NUM TEXT, KAF TEXT, PARA TEXT, AUD TEXT, DAY INTEGER, PTIME TEXT, PREPOD TEXT, PID INTEGER, DESCR TEXT, KYRS INTEGER)";
            
            sqlite3_exec(groupDB, sql_stmt2, NULL, NULL, &errMsg);
            
            if (sqlite3_exec(groupDB, sql_stmt2, NULL, NULL, &errMsg) != SQLITE_OK)
            {
                NSLog(@"Failed to create table MAIN");
            }
            else
            {NSLog(@"OK for table MAIN");}
            
            const char *sql_stmt3 = "CREATE TABLE IF NOT EXISTS PMAIN (ID INTEGER PRIMARY KEY AUTOINCREMENT, PREPOD TEXT, PARA TEXT, PID INTEGER, PABOUT TEXT)";
            
            sqlite3_exec(groupDB, sql_stmt3, NULL, NULL, &errMsg);
            
            if (sqlite3_exec(groupDB, sql_stmt3, NULL, NULL, &errMsg) != SQLITE_OK)
            {
                NSLog(@"Failed to create table PMAIN");
            }
            else
            {NSLog(@"OK for table PMAIN");}
            
            const char *sql_stmt4 = "CREATE TABLE IF NOT EXISTS PGROUP (ID INTEGER PRIMARY KEY AUTOINCREMENT, NUM TEXT, KAF TEXT, KYRS TEXT)";
            
            sqlite3_exec(groupDB, sql_stmt4, NULL, NULL, &errMsg);
            
            if (sqlite3_exec(groupDB, sql_stmt4, NULL, NULL, &errMsg) != SQLITE_OK)
            {
                NSLog(@"Failed to create table PGROUP");
            }
            else
            {NSLog(@"OK for table PGROUP");}
            
            sqlite3_close(groupDB);
            
        }

//если группа уже задана, то отображаем расписание
    
    NSDate *dateToday =[NSDate date];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"c"];
    NSString *string = [format stringFromDate:dateToday];
    int stringInt = [string intValue];
    
    NSString *pairName, *pairTime, *pairAud, *pairPrepod, *currentDay;
    
    
    sqlite3_stmt    *statement;
    
    totalStrings = [[NSMutableArray alloc] init];
    
    if (sqlite3_open(dbpath, &groupDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat: @"SELECT NUM FROM MAIN WHERE ID=\"1\""];
        
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(groupDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                numberField = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                
                myLabel.hidden=YES;
                yourGroupNumber.hidden=YES;
                myButton.hidden=YES;
                
                NSString *querySQL = [NSString stringWithFormat: @"SELECT * FROM MAIN WHERE num=\"%@\" and day=\"%d\"",numberField,stringInt];
                const char *query_stmt = [querySQL UTF8String];
                if (sqlite3_prepare_v2(groupDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
                {
                    while (sqlite3_step(statement) == SQLITE_ROW)
                    {
                        
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
                        self.title = currentDay;
                        
                        pairName = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 3)];
                        pairTime = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 6)];
                        pairAud =  [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 4)];
                        pairPrepod=[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 7)];
                        [totalStrings addObject:[DayMy dayWithType:nil kaf:nil para:pairName aud:pairAud day:currentDay ptime:pairTime prepod:pairPrepod pid:nil descr:nil kyrs:nil]];
                    }
                    
                    //сортировка массива пар для дня, по времени
                    NSArray *sortedArray;
                    sortedArray = [totalStrings sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
                        NSString *first = [(DayMy*)a ptime];
                        NSString *second = [(DayMy*)b ptime];
                        return [first compare:second];
                    }];
                    totalStrings = sortedArray;
                }
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(groupDB);
    }
    
    [super viewDidLoad];

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [totalStrings count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellID = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
    }
    
    cell = [self getCellContentView:CellID];
    
    UILabel *lblTemp1 = (UILabel *)[cell viewWithTag:1];
    UILabel *lblTemp2 = (UILabel *)[cell viewWithTag:2];
    UILabel *lblTemp3 = (UILabel *)[cell viewWithTag:3];
    
    
    //cell.textLabel.text = [totalStrings objectAtIndex:indexPath.row];
    DayMy *cellValue1 = [totalStrings objectAtIndex:indexPath.row];
    DayMy *cellValue2 = [totalStrings objectAtIndex:indexPath.row];
    DayMy *cellValue3 = [totalStrings objectAtIndex:indexPath.row];
    
    
    lblTemp1.text = cellValue1.para;
    lblTemp2.text = cellValue2.aud;
    lblTemp3.text = cellValue3.ptime;
    
    return cell;
}

- (UITableViewCell *) getCellContentView:(NSString *)cellIdentifier {
	
	CGRect CellFrame = CGRectMake(0, 0, 300, 45);
	CGRect Label1Frame = CGRectMake(10, 0, 250, 25);
	CGRect Label2Frame = CGRectMake(10, 22, 250, 20);
    CGRect Label3Frame = CGRectMake(250, 10, 70, 20);
	UILabel *lblTemp;
	
	UITableViewCell *cell = [[UITableViewCell alloc] initWithFrame:CellFrame reuseIdentifier:cellIdentifier];
	
	//Initialize Label with tag 1.
	lblTemp = [[UILabel alloc] initWithFrame:Label1Frame];
	lblTemp.tag = 1;
	[cell.contentView addSubview:lblTemp];
	
	
	//Initialize Label with tag 2.
	lblTemp = [[UILabel alloc] initWithFrame:Label2Frame];
	lblTemp.tag = 2;
	lblTemp.font = [UIFont boldSystemFontOfSize:14];
	lblTemp.textColor = [UIColor lightGrayColor];
	[cell.contentView addSubview:lblTemp];
    
    //Initialize Label with tag 3.
	lblTemp = [[UILabel alloc] initWithFrame:Label3Frame];
	lblTemp.tag = 3;
	lblTemp.font = [UIFont boldSystemFontOfSize:20];
	lblTemp.textColor = [UIColor blackColor];
	[cell.contentView addSubview:lblTemp];
	
	return cell;
}

- (UITableViewCellAccessoryType)tableView:(UITableView *)tableView accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath {
	
	//return UITableViewCellAccessoryDetailDisclosureButton;
	//return UITableViewCellAccessoryDisclosureIndicator;
	return UITableViewCellAccessoryNone;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	return 45;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    DayMy *cell = nil;
    cell = [totalStrings objectAtIndex:indexPath.row];
    myPairName = cell.para;
    myPairTime = cell.ptime;
    myAuditName = cell.aud;
    myPairPrepod = cell.prepod;
    myDayName = cell.day;
    
    myPairImg = [UIImage imageNamed:@"stas.jpg"];
    
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

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (void)settingsButton:(id)sender {
    SettingsViewController *DVC = [[SettingsViewController alloc] initWithNibName:@"SettingsViewController" bundle:nil];
    [self.navigationController pushViewController:DVC animated:YES];
}

- (void)dayButton:(id)sender {
    courseName = numberField;
    RaspViewController *DVC = [[RaspViewController alloc] initWithNibName:@"RaspViewController" bundle:nil];
    [self.navigationController pushViewController:DVC animated:YES];
}


- (IBAction)yourGroupNumberApply:(id)sender {
    sqlite3_stmt    *statement;
    
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &groupDB) == SQLITE_OK)
    {
        NSString *insertSQL = [NSString stringWithFormat: @"INSERT INTO MYGROUP VALUES (\"1\", \"%@\")",yourGroupNumber.text];
        NSString *updateSQL = [NSString stringWithFormat:@"UPDATE MYGROUP SET number = '%@' WHERE id = '1'",yourGroupNumber.text];
        
        
        const char *insert_stmt = [insertSQL UTF8String];
        const char *update_stmt = [updateSQL UTF8String];
        
        sqlite3_prepare_v2(groupDB, insert_stmt, -1, &statement, NULL);
        
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            NSLog(@"sqlite3_insert OK");
        } else {
            NSLog(@"sqlite3_insert error: %s", sqlite3_errmsg(groupDB));
            sqlite3_prepare_v2(groupDB, update_stmt, -1, &statement, NULL);
            if (sqlite3_step(statement) == SQLITE_DONE)
            {
                NSLog(@"sqlite3_update OK");
            } else {
                NSLog(@"update error: '%s'", sqlite3_errmsg(groupDB));
            }
        }
        sqlite3_finalize(statement);
        sqlite3_close(groupDB);
    }
}
@end
















