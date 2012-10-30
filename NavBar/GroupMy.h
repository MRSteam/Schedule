//
//  GroupMy.h
//  NavBar
//
//  Created by Stas-PC on 27.10.12.
//  Copyright (c) 2012 Stas-PC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GroupMy : NSObject
{
    NSString *number;
    NSString *kafedra;
    NSString *kyrs;
}

@property (nonatomic, copy) NSString *number, *kafedra, *kyrs;

+ (id)groupWithType:(NSString *)number kafedra:(NSString *)kafedra kyrs:(NSString *)kyrs;

@end
