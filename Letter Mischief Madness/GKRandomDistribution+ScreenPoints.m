//
//  GKRandomDistribution+ScreenPoints.m
//  Letter Mischief Madness
//
//  Created by Aleksander Makedonski on 1/22/18.
//  Copyright © 2018 Aleksander Makedonski. All rights reserved.
//

#import "GKRandomDistribution+ScreenPoints.h"


@implementation GKRandomDistribution (HelperMethods)


-(NSArray<NSNumber*>*)getArrayOfRandomNumbers:(NSInteger)numberOfRandomVals{
    
   
    NSMutableArray* numArray = [NSMutableArray arrayWithCapacity:numberOfRandomVals];
    
    for (int i = 0; i < numberOfRandomVals; i++) {
        
        NSNumber* randomNum = [NSNumber numberWithInteger:self.nextInt];
        [numArray addObject:randomNum];
    }
    
    return numArray;
}

@end
