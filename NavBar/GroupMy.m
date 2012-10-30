//
//  GroupMy.m
//  NavBar
//
//  Created by Stas-PC on 27.10.12.
//  Copyright (c) 2012 Stas-PC. All rights reserved.
//

#import "GroupMy.h"

@implementation GroupMy

@synthesize number, kafedra, kyrs;

+ (id)groupWithType:(NSString *)number kafedra:(NSString *)kafedra kyrs:(NSString *)kyrs
{
    GroupMy *newGroup = [[self alloc] init];
    newGroup.number = number;
    newGroup.kafedra = kafedra;
    newGroup.kyrs = kyrs;
    return newGroup;
}

@end
