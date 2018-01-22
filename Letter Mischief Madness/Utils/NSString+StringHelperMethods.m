//
//  NSString+StringHelperMethods.m
//  Letter Mischief Madness
//
//  Created by Aleksander Makedonski on 1/22/18.
//  Copyright © 2018 Aleksander Makedonski. All rights reserved.
//

#import "NSString+StringHelperMethods.h"

@implementation NSString (StringHelperMethods)

+ (NSString*) getCoordString:(CGPoint)point{
    
    return [NSString stringWithFormat:@"X-Coordinate: %f, Y-Coordinate: %f",point.x,point.y];
}

+(void)printCoordStrings:(NSArray<NSString*>*)coordStrings{
    
    NSLog(@"The coordinate strings are:");
    
    for (NSString*coordStr in coordStrings) {
        NSLog(coordStr);
        NSLog(@"\n");
    }
}


@end
