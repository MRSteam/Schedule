//вьюшка для отображения расписания по дню недели

//
//  DetailViewController.m
//  NavBar
//
//  Created by Stas-PC on 08.10.12.
//  Copyright (c) 2012 Stas-PC. All rights reserved.
//

#import "DetailViewController.h"
#import "ThirdViewController.h" // чтобы забрать переменную НомерКурса

@interface DetailViewController ()

@end

@implementation DetailViewController
@synthesize DayPic;
@synthesize DayName;
@synthesize DayNumber;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //В дальнейшем здесь будет реализована работа с базой данных
    
    //create a couple UIimages
    UIImage * MondayImage = [UIImage imageNamed:@"Monday.jpg"];
    UIImage * ThuesdayImage = [UIImage imageNamed:@"Thuesday.jpg"];
    UIImage * WednesdayImage = [UIImage imageNamed:@"Wednesday.jpg"];
    UIImage * ThusdayImage = [UIImage imageNamed:@"Thusday.jpg"];
    UIImage * FridayImage = [UIImage imageNamed:@"Friday.jpg"];
    
    //switch UIImages and UILabel based on DayNumber
    switch (DayNumber) {
        case 0:
            DayName.text = @"Понедельник";
            //DayName.font = [UIFont fontWithName:@"Areal" size:50];
            DayPic.image = MondayImage;
            self.title=@"Понедельник";
            break;
        case 1:
            DayName.text = @"Вторник";
            DayPic.image = ThuesdayImage;
            self.title=@"Вторник";
            break;
        case 2:
            DayName.text = @"Среда";
            DayPic.image = WednesdayImage;
            self.title=@"Среда";
            break;
        case 3:
            DayName.text = @"Четверг";
            DayPic.image = ThusdayImage;
            self.title=@"Четверг";
            break;
        case 4:
            DayName.text = @"Пятница";
            DayPic.image = FridayImage;
            self.title=@"Пятница";
            break;
            
        default:
            DayName.text = @"Выход по default";
            DayPic.image = FridayImage;
            self.title=@"Выход по default";
            break;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
