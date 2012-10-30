//
//  DetailViewController.h
//  NavBar
//
//  Created by Stas-PC on 08.10.12.
//  Copyright (c) 2012 Stas-PC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController
<UIPickerViewDelegate, UIPickerViewDataSource>
{
    UIImageView        *DayPic;
    UILabel            *DayName;
    int                 DayNumber;
}

@property (strong, nonatomic) IBOutlet UIImageView *DayPic; //картинка для отображения фотографии расписания для определенного дня
@property (strong, nonatomic) IBOutlet UILabel *DayName; //день, его имя (пн,вт,ср,чет,пят)
@property int DayNumber; //номер дня (0..4)


@end
