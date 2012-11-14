//
//  MyOperation.m
//  NavBar
//
//  Created by Stas-PC on 13.11.12.
//  Copyright (c) 2012 Stas-PC. All rights reserved.
//

#import "MyOperation.h"

@implementation MyOperation

-(void) main
{
    // задача которая требует некоторое кол-во времени
    // поток заснет на некоторое время
    sleep(3);
    
    NSOperationQueue* myQueue = [NSOperationQueue new];
    MyOperation* op = [MyOperation new];
    
    //[queue addOperation:op];
    
    
    [myQueue addOperationWithBlock:^{
        NSURL *url = [NSURL URLWithString:myFoo.image];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImageView *subview = [[UIImageView alloc] initWithFrame:CGRectMake(5.0f, 5.0f, 32.0f, 32.0f)];
        [subview setImage:[UIImage imageWithData:data]];
        lblTemp3.image = [UIImage imageWithData:data];
        }]; }];
    
    
}

@end
