//
//  DayViewController.m
//  NavBar
//
//  Created by Stas-PC on 26.10.12.
//  Copyright (c) 2012 Stas-PC. All rights reserved.
//


#include <sqlite3.h>
#import "DayViewController.h"
#import "GroupMy.h"
#import "DayMy.h"
#import "PairViewController.h"
#import "RaspViewController.h"
#import "ThirdViewController.h"
#import "myAccessorValues.h"

@interface DayViewController ()
{
    NSMutableArray *totalStrings;
}

@end



@implementation DayViewController

static NSString* myVar;

+(NSString*)myVarAccessor {
    return myVar;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = myDayName;
        self.tabBarItem.image = [UIImage imageNamed:@"first"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSString *docsDir;
    NSString *dirPaths;
    
    // Get the documents directory
    dirPaths = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    
    docsDir = [dirPaths stringByAppendingPathComponent:@"groupDB.sqlite"];//[dirPaths objectAtIndex:0];
    
    // Build the path to the database file
    databasePath = [[NSBundle mainBundle] pathForResource:@"groupDB" ofType:@"sqlite"];
    
    const char *dbpath = [databasePath UTF8String];
    
    NSString *pairName, *pairTime, *pairAud, *pairPrepod, *currentDay;
    
    
    sqlite3_stmt    *statement;
    
    totalStrings = [[NSMutableArray alloc] init];
    
    if (sqlite3_open(dbpath, &groupDB) == SQLITE_OK)
    {
                NSString *querySQL = [NSString stringWithFormat: @"SELECT * FROM MAIN WHERE num=\"%@\" and day=\"%d\"",courseName,myDayNumber];
                
                const char *query_stmt = [querySQL UTF8String];
                if (sqlite3_prepare_v2(groupDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
                {
                    while (sqlite3_step(statement) == SQLITE_ROW)
                    {                        
                        pairName = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 3)];
                        pairTime = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 6)];
                        pairAud =  [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 4)];
                        pairPrepod=[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 7)];
                        [totalStrings addObject:[DayMy dayWithType:nil kaf:nil para:pairName aud:pairAud day:myDayName ptime:pairTime prepod:pairPrepod pid:nil descr:nil kyrs:nil]];
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
            sqlite3_finalize(statement);
        sqlite3_close(groupDB);
    }
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

    [myAccessorValues myPairNameSetter:cell.para];
    [myAccessorValues myPairTimeSetter:cell.ptime];
    [myAccessorValues myAuditNameSetter:cell.aud];
    [myAccessorValues myPairPrepodSetter:cell.prepod];
    [myAccessorValues myDayNameSetter:cell.day];
    [myAccessorValues myPairImgSetter:[UIImage imageNamed:@"stas.jpg"]];
    
   /*
    myPairName = cell.para;
    myPairTime = cell.ptime;
    myAuditName = cell.aud;
    myPairPrepod = cell.prepod;
    myDayName = cell.day;
    myPairImg = [UIImage imageNamed:@"stas.jpg"];
    */
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
