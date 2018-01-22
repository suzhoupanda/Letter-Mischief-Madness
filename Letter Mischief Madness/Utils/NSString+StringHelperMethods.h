//
//  NSString+StringHelperMethods.h
//  Letter Mischief Madness
//
//  Created by Aleksander Makedonski on 1/22/18.
//  Copyright © 2018 Aleksander Makedonski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (StringHelperMethods)

+ (NSString*) getCoordString:(CGPoint)point;
+(void)printCoordStrings:(NSArray<NSString*>*)coordStrings;

@end
