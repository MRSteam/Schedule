//вьюшка третьей вкладки

#include <sqlite3.h>
#import "DetailViewController.h"
#import "ThirdViewController.h"
#import "RaspViewController.h"
#import "GroupMy.h"


@interface ThirdViewController ()
{
    NSMutableArray *totalStrings;
    NSMutableArray *filteredStrings;
    BOOL isFiltered;
}

@end

@implementation ThirdViewController

//@synthesize list = _list;
@synthesize number = _number, kom = _kom;
@synthesize kaf = _kaf;


#pragma mark - View Life Cycle Methods

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Расписание";
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
    
    const char *dbpath = [databasePath UTF8String];
    
    NSString *myGroup, *myKafedra, *myKyrs;
    
    sqlite3_stmt    *statement;
    
    totalStrings = [[NSMutableArray alloc] init];
    NSMutableArray *courseFirstInArray = [[NSMutableArray alloc] init];
    NSMutableArray *courseSecondInArray = [[NSMutableArray alloc] init];
    NSMutableArray *courseThirdInArray = [[NSMutableArray alloc] init];
    NSMutableArray *courseFourInArray = [[NSMutableArray alloc] init];
    
    if (sqlite3_open(dbpath, &groupDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat: @"SELECT * FROM PGROUP"];
        
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(groupDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {

                
                
                    while (sqlite3_step(statement) == SQLITE_ROW)
                    {
                        myGroup = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                        myKafedra = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
                        myKyrs =  [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 3)];
                        //[totalStrings addObject:[GroupMy groupWithType:myGroup kafedra:myKafedra kyrs:myKyrs]];
                        int stringInt = [myGroup intValue];
                        if (stringInt<200) [courseFirstInArray addObject:[GroupMy groupWithType:myGroup kafedra:myKafedra kyrs:myKyrs]];
                        if (stringInt<300 && stringInt>=200) [courseSecondInArray addObject:[GroupMy groupWithType:myGroup kafedra:myKafedra kyrs:myKyrs]];
                        if (stringInt<400 && stringInt>=300) [courseThirdInArray addObject:[GroupMy groupWithType:myGroup kafedra:myKafedra kyrs:myKyrs]];
                        if (stringInt<500 && stringInt>=400) [courseFourInArray addObject:[GroupMy groupWithType:myGroup kafedra:myKafedra kyrs:myKyrs]];
                    }
                

                

                

                  /*
                    //сортировка массива пар для дня, по времени
                    NSArray *sortedArray;
                    sortedArray = [totalStrings sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
                        NSString *first = [(GroupMy*)a number];
                        NSString *second = [(GroupMy*)b number];
                        return [first compare:second];
                    }];
                    totalStrings = sortedArray;
                   */
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(groupDB);
    }
    
    NSDictionary *courseFirstDict = [NSDictionary dictionaryWithObject:courseFirstInArray forKey:@"Data"];
    [totalStrings addObject:courseFirstDict];
    
    NSDictionary *courseSecondDict = [NSDictionary dictionaryWithObject:courseSecondInArray forKey:@"Data"];
    [totalStrings addObject:courseSecondDict];
    
    NSDictionary *courseThirdDict = [NSDictionary dictionaryWithObject:courseThirdInArray forKey:@"Data"];
    [totalStrings addObject:courseThirdDict];
    
    NSDictionary *courseFourDict = [NSDictionary dictionaryWithObject:courseFourInArray forKey:@"Data"];
    [totalStrings addObject:courseFourDict];

}


-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (searchText.length == 0) {
        isFiltered = NO;
    }
    else {
        isFiltered = YES;
        filteredStrings = [[NSMutableArray alloc]init];
        
        for (GroupMy *str in totalStrings) {
            NSRange stringRange1 = [str.number rangeOfString:searchText options:NSCaseInsensitiveSearch];
            
            if (stringRange1.location != NSNotFound) {
                [filteredStrings addObject:str];
            }
            NSRange stringRange2 = [str.kafedra rangeOfString:searchText options:NSCaseInsensitiveSearch];
            
            if (stringRange2.location != NSNotFound) {
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
    NSDictionary *dictionary = [totalStrings objectAtIndex:section];
    NSArray *array = [dictionary objectForKey:@"Data"];
    return [array count];
    
    if (isFiltered) {
        NSDictionary *dictionary = [filteredStrings objectAtIndex:section];
        NSArray *array = [dictionary objectForKey:@"Data"];
        return [array count];
    }
    else
    {
        NSDictionary *dictionary = [totalStrings objectAtIndex:section];
        NSArray *array = [dictionary objectForKey:@"Data"];
        return [array count];
    }
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    
	if(isFiltered)
		return -1;
	
	return index % 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
    }

    NSDictionary *dictionary1 = [totalStrings objectAtIndex:indexPath.section];
    NSArray *array1 = [dictionary1 objectForKey:@"Data"];
    NSDictionary *dictionary2 = [filteredStrings objectAtIndex:indexPath.section];
    NSArray *array2 = [dictionary2 objectForKey:@"Data"];
    //NSString *cellValue = [array objectAtIndex:indexPath.row];
    //cell.text = cellValue;
    
    cell = [self getCellContentView:CellIdentifier];
    
    UILabel *lblTemp1 = (UILabel *)[cell viewWithTag:1];
    UILabel *lblTemp2 = (UILabel *)[cell viewWithTag:2];
    
    if (!isFiltered)
    {
        //cell.textLabel.text = [totalStrings objectAtIndex:indexPath.row];
        GroupMy *cellValue1 = [array1 objectAtIndex:indexPath.row];
        GroupMy *cellValue2 = [array1 objectAtIndex:indexPath.row];
        
        
        lblTemp1.text= cellValue1.number;
        lblTemp2.text = cellValue2.kafedra;
    }
    else
    {
        //cell.textLabel.text = [filteredStrings objectAtIndex:indexPath.row];
        GroupMy *cellValue1 = [array2 objectAtIndex:indexPath.row];
        GroupMy *cellValue2 = [array2 objectAtIndex:indexPath.row];
        
        lblTemp1.text = cellValue1.number;
        lblTemp2.text = cellValue2.kafedra;
    }

    return cell;
}

- (UITableViewCell *) getCellContentView:(NSString *)cellIdentifier {
	
	CGRect CellFrame = CGRectMake(0, 0, 300, 45);
	CGRect Label1Frame = CGRectMake(10, 10, 290, 25);
	CGRect Label2Frame = CGRectMake(250, 10, 290, 25);
	UILabel *lblTemp;
	
	UITableViewCell *cell = [[UITableViewCell alloc] initWithFrame:CellFrame reuseIdentifier:cellIdentifier];
	
	//Initialize Label with tag 1.
	lblTemp = [[UILabel alloc] initWithFrame:Label1Frame];
	lblTemp.tag = 1;
	[cell.contentView addSubview:lblTemp];
	
	
	//Initialize Label with tag 2.
	lblTemp = [[UILabel alloc] initWithFrame:Label2Frame];
	lblTemp.tag = 2;
	lblTemp.font = [UIFont boldSystemFontOfSize:12];
	lblTemp.textColor = [UIColor lightGrayColor];
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
    return 4;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dictionary1 = [totalStrings objectAtIndex:indexPath.section];
    NSArray *array1 = [dictionary1 objectForKey:@"Data"];
    NSDictionary *dictionary2 = [filteredStrings objectAtIndex:indexPath.section];
    NSArray *array2 = [dictionary2 objectForKey:@"Data"];

    courseNumber = indexPath.row+1;
    GroupMy *cell = nil;
    if (!isFiltered)
    {
        cell = [array1 objectAtIndex:indexPath.row];
    }
    else
    {
        cell = [array2 objectAtIndex:indexPath.row];
    }
    courseName = cell.number;
    
    
    //create a DetailViewController object
    RaspViewController *DVC = [[RaspViewController alloc] initWithNibName:@"RaspViewController" bundle:nil];
    
    //push the DetailViewController object onto the stack
    [self.navigationController pushViewController:DVC animated:YES];
    
}


-(void)viewWillDisappear:(BOOL)animated {
    NSIndexPath *selectedIndexPath = [self.myTableView indexPathForSelectedRow];
    [self.myTableView deselectRowAtIndexPath:selectedIndexPath animated:NO];

    [self.myTableView reloadData];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	
	if(isFiltered)
		return @"Результаты поиска";
	
	if(section == 0)
		return @"Первый курс";
	if(section == 1)
		return @"Второй курс";
    if(section == 2)
		return @"Третий курс";
	if(section == 3)
		return @"Четвертый курс";
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end





