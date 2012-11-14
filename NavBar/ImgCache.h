//
//  ImgCache.h
//  NavBar
//
//  Created by Stas-PC on 14.11.12.
//  Copyright (c) 2012 Stas-PC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImgCache : NSObject

- (void) cacheImage: (NSString *) ImageURLString;
- (UIImage *) getImage: (NSString *) ImageURLString;

@end
