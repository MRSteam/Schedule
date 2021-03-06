//
//  DisplayData.m
//  NavBar
//
//  Created by Stas-PC on 01.11.12.
//  Copyright (c) 2012 Stas-PC. All rights reserved.
//

#import "DisplayData.h"
#import "Venues.h"
#import "SettingsViewController.h"
#import "MapViewController.h"

#import "myAccessorValues.h"
#import "ImgCache.h"

@implementation DisplayData
{
    NSMutableArray *array1;
    NSMutableArray *finishArray;
    Venues *myFoo;
    NSOperationQueue *myQueue;

}

@synthesize webData,titleScrollView,loadIndicator;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"API foursquare";
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn’t have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren’t in use.
}

#pragma mark – View lifecycle

- (void)ActivityIndigator
{
    loadIndicator =
    [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(130, 150, 40, 40)];
    loadIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    
    [loadIndicator startAnimating];
    
    [self.view addSubview:loadIndicator];
    
  
    
}

- (void)viewDidLoad
{
    

    
    
    
    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self ActivityIndigator];
    NSURL *url = [NSURL URLWithString:@"https://api.foursquare.com/v2/venues/search?ll=40.7,-74&oauth_token=YJFKKGKTFLSEIVVJJ0JVODLPZG2ESUQJWJDPOQGAS1TZVZC5&v=20121104"];

    
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];

    if( theConnection )
    {
        webData = [NSMutableData data];
    }
    
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [webData setLength: 0];
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    
    [webData appendData:data];
    
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                   message : @"An error has occured.Please verify your internet connection."
                                                   delegate:nil
                                         cancelButtonTitle :@"OK"
                                         otherButtonTitles :nil];
    [alert show];
  
    
    [loadIndicator removeFromSuperview ];

}


-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
    //NSLog(@"DONE. Received Bytes: %d", [webData length]);
    
    NSString *loginStatus = [[NSString alloc] initWithData:webData encoding:NSUTF8StringEncoding];
    
    textView = [[UITextView alloc] initWithFrame:CGRectMake(5, 30, 320,400)]; //size.height-30 )];
    textView.text = loginStatus;
    [textView setFont:[UIFont systemFontOfSize:14]];
    [textView setBackgroundColor:[UIColor clearColor]];
    [textView setTextColor:[UIColor blackColor]];
    textView.editable = NO;
    textView.dataDetectorTypes = UIDataDetectorTypeNone;
    
    [loadIndicator removeFromSuperview ];
    
    [titleScrollView addSubview:textView];
    
    NSError *error;
    NSDictionary *dict1 = [NSJSONSerialization
                          JSONObjectWithData: webData options: kNilOptions
                          error:&error];

    
    array1 = [[NSMutableArray alloc] init];
    array1 = [[dict1 objectForKey:@"response"] objectForKey:@"venues"];
    
    
    //Venues *myNewObject = [[Venues alloc] init];
    finishArray = [[NSMutableArray alloc] init];
    
    for (int i=0; i< [array1 count]; i++) {
        if ([[[[[dict1 objectForKey:@"response"] objectForKey:@"venues"] objectAtIndex:i] objectForKey:@"categories"] count] != 0)
        {
            Venues *myNewObject = [[Venues alloc] init];
            
            myNewObject.name = [[[[[[dict1 objectForKey:@"response"] objectForKey:@"venues"] objectAtIndex:i] objectForKey:@"categories"] objectAtIndex:0] objectForKey:@"name"];
            
            myNewObject.suffix = [[[[[[[dict1 objectForKey:@"response"] objectForKey:@"venues"] objectAtIndex:i] objectForKey:@"categories"] objectAtIndex:0] objectForKey:@"icon"] objectForKey:@"suffix"];
            
            myNewObject.prefix = [[[[[[[dict1 objectForKey:@"response"] objectForKey:@"venues"] objectAtIndex:i] objectForKey:@"categories"] objectAtIndex:0] objectForKey:@"icon"] objectForKey:@"prefix"];
            
            myNewObject.image = [[myNewObject.prefix stringByAppendingString:@"bg_32"]  stringByAppendingString:myNewObject.suffix];
            
            myNewObject.distance = [[[[[dict1 objectForKey:@"response"] objectForKey:@"venues"] objectAtIndex:i] objectForKey:@"location"] objectForKey:@"distance"];
            
            myNewObject.checkins = [[[[[dict1 objectForKey:@"response"] objectForKey:@"venues"] objectAtIndex:i] objectForKey:@"stats"] objectForKey:@"checkinsCount"];
            
            myNewObject.lat = [[[[[dict1 objectForKey:@"response"] objectForKey:@"venues"] objectAtIndex:i] objectForKey:@"location"] objectForKey:@"lat"];
            
            myNewObject.lng = [[[[[dict1 objectForKey:@"response"] objectForKey:@"venues"] objectAtIndex:i] objectForKey:@"location"] objectForKey:@"lng"];
            
            //NSLog(@"! %@",myNewObject.image);
            
            [finishArray addObject:myNewObject];
            
/*
            NSArray *keys = [NSArray arrayWithObjects:@"name", @"suffix",@"prefix",@"image",@"distance",@"checkins", nil];
            NSArray *values = [NSArray arrayWithObjects:myNewObject.name, myNewObject.suffix,myNewObject.prefix,myNewObject.image,myNewObject.distance,myNewObject.checkins, nil];
            NSDictionary *dict = [NSDictionary dictionaryWithObjects:values forKeys:keys];
            
            NSString *error3=nil;
            NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"MyVenues" ofType:@"plist"];
            NSDictionary *plistDict = [NSDictionary dictionaryWithDictionary:
                                       dict];
            
            NSData *plistData = [NSPropertyListSerialization dataFromPropertyList:plistDict
                                                                           format:NSPropertyListXMLFormat_v1_0
                                                                 errorDescription:&error3];
            if(plistData) {
                [plistData writeToFile:plistPath atomically:YES];
            }
 
            
            //NSLog(@"error = %@", [error3 description]);
            
            //NSLog(@"!!! %@",dict);
            
            dict =[[NSDictionary alloc] initWithContentsOfFile:plistPath];
            
            */
            
             //NSLog(@"! %@",dict);
            
        }
    }
    //распарсили в веньюс
    
    [myAccessorValues myFinishArraySetter:finishArray];
    
    [self.myTableView reloadData];
    

    myQueue = [NSOperationQueue new];
    myQueue.maxConcurrentOperationCount = 5;
    
    
    if (finishArrayOld ==0) finishArrayOld = [finishArray count];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (UIImage*)imageNamed:(NSString*)imageNamed cache:(BOOL)cache
{
    UIImage* retImage = nil;

        retImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageNamed]]];
        if (cache)
        {
            if (staticImageDictionary == nil)
                staticImageDictionary = [NSMutableDictionary new];
            
            if (retImage != nil)
                [staticImageDictionary setObject:retImage forKey:imageNamed];
        }   
    return retImage;
}




-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //NSLog(@"count : %d",[array1 count]);
    return [finishArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifer = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifer];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifer];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    //myFoo = [[Venues alloc] init];
    myFoo = [finishArray objectAtIndex:indexPath.row];
    //NSLog(@"%@",myFoo.distance);
    
    
    cell = [self getCellContentView:CellIdentifer];
    UILabel *lblTemp1 = (UILabel *)[cell viewWithTag:1];
    UILabel *lblTemp2 = (UILabel *)[cell viewWithTag:2];
    UIImageView *lblTemp3 = (UIImageView *)[cell viewWithTag:3];
    
    lblTemp1.text = myFoo.name;
    NSString *temp;
    temp = [NSString stringWithFormat:@"%@", [[NSString stringWithFormat:@"Расстояние: %@", myFoo.distance] stringByAppendingString:@"м Чекинов: "]];
    lblTemp2.text = [temp stringByAppendingString:[NSString stringWithFormat:@"%@", myFoo.checkins]];
    
    //cell.textLabel.text = myFoo.name;
    //cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", myFoo.distance];
    
    /*
    [myQueue addOperationWithBlock:^{
        myFoo = [finishArray objectAtIndex:indexPath.row];
        NSURL *url = [NSURL URLWithString:myFoo.image];
        NSData *data = [NSData dataWithContentsOfURL:url];
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            lblTemp3.image = [UIImage imageWithData:data];
        }];
    }];
     */
    
    //dispatch_queue_t qLow = dispatch_get_main_queue();
    //qLow = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0);
    
    if (staticImageDictionaryKol == 0) staticImageDictionaryKol = [finishArray count];
    
    if ([staticImageDictionary count] <= staticImageDictionaryKol) //|| (finishArrayOld < [finishArray count]))
    {

       // if (finishArrayOld <= [finishArray count]) staticImageDictionaryKol = staticImageDictionaryKol + [finishArray count] - finishArrayOld;
        
            NSLog(@"%d - %d", [staticImageDictionary count], staticImageDictionaryKol);
        
    dispatch_queue_t qLow = dispatch_queue_create("myQ", DISPATCH_QUEUE_CONCURRENT);

    dispatch_async(qLow, ^{
        myFoo = [finishArray objectAtIndex:indexPath.row];
        //NSURL *url = [NSURL URLWithString:myFoo.image];
        //NSData *data = [NSData dataWithContentsOfURL:url];
        
        //UIImage *img = [UIImage imageWithData:data];
        NSString *tmp = [NSString stringWithFormat:@"%@", myFoo.image];
        
        
        if ([staticImageDictionary objectForKey:myFoo.image]!=nil)
        {
            staticImageDictionaryKol--;
        }
        
        UIImage *ret =[self imageNamed:tmp cache:YES];
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            lblTemp3.image = ret;
        });
    });
    }
    else {
        //загрузка картинок завершена, можно добавлять словарь картинок в плист для дальнейшего хранения
        
        //NSArray *keys = [NSArray arrayWithObjects:@"name", @"suffix",@"prefix",@"image",@"distance",@"checkins", nil];
        //NSArray *values = [NSArray arrayWithObjects:, nil];
        NSDictionary *dict = [NSDictionary dictionaryWithDictionary:staticImageDictionary];
        
        NSString *error3=nil;
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"MyVenues" ofType:@"plist"];
        NSDictionary *plistDict = [NSDictionary dictionaryWithDictionary:
                                   staticImageDictionary];
        NSLog(@"%@", plistDict);
        NSData *plistData = [NSPropertyListSerialization dataFromPropertyList:plistDict
                                                                       format:NSPropertyListXMLFormat_v1_0
                                                             errorDescription:&error3];
        if(plistData) {
            [plistData writeToFile:plistPath atomically:YES];
            NSLog(@"YES BABY!");
        }
        else {NSLog(@"%@", error3);}
        
        
        dict =[[NSDictionary alloc] initWithContentsOfFile:plistPath];
        
        NSLog(@"! %@",dict);
        
        myFoo = [finishArray objectAtIndex:indexPath.row];
        if ([staticImageDictionary objectForKey:myFoo.image] == nil)
        {
            NSLog(@"Загрзили новую картинку для места: %@",myFoo.name);
            //загрузим картинку для ново-появившегося места, и также надо обновить плист
            NSString *tmp = [NSString stringWithFormat:@"%@", myFoo.image];
            [self imageNamed:tmp cache:YES];
            
            
            NSDictionary *dict = [NSDictionary dictionaryWithDictionary:staticImageDictionary];
            
            NSString *error3=nil;
            NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"MyVenues" ofType:@"plist"];
            NSDictionary *plistDict = [NSDictionary dictionaryWithDictionary:
                                       dict];
            //NSLog(@"%@", plistDict);
            NSData *plistData = [NSPropertyListSerialization dataFromPropertyList:plistDict
                                                                           format:NSPropertyListXMLFormat_v1_0
                                                                 errorDescription:&error3];
            if(plistData) {
                [plistData writeToFile:plistPath atomically:YES];
            }
        }
        lblTemp3.image = [staticImageDictionary objectForKey:myFoo.image];
    }
    
    
    return cell;
}

- (UITableViewCell *) getCellContentView:(NSString *)cellIdentifier {
	
	CGRect CellFrame = CGRectMake(0, 0, 300, 45);
	CGRect Label1Frame = CGRectMake(40, 0, 260, 25);
	CGRect Label2Frame = CGRectMake(40, 22, 260, 20);
    CGRect Label3Frame = CGRectMake(5, 5, 32, 32);
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
	UIImageView *lblImage = [[UIImageView alloc] initWithFrame:Label3Frame];
	lblImage.tag = 3;
	[cell.contentView addSubview:lblImage];
	
	return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MapViewController *DVC = [[MapViewController alloc] initWithNibName:@"MapViewController" bundle:nil];
    
    [self.navigationController pushViewController:DVC animated:YES];
}

-(void)viewWillDisappear:(BOOL)animated {
    NSIndexPath *selectedIndexPath = [self.myTableView indexPathForSelectedRow];
    [self.myTableView deselectRowAtIndexPath:selectedIndexPath animated:NO];
    
    [self.myTableView reloadData];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	return 45;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}



@end