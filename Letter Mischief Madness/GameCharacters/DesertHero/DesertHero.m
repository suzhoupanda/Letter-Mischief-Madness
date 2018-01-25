//
//  DesertHero.m
//  Letter Mischief Madness
//
//  Created by Aleksander Makedonski on 1/25/18.
//  Copyright © 2018 Aleksander Makedonski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DesertHero.h"
#import "DesertHero+AnimationsGenerator.h"

@interface DesertHero()

/** Stored references to animations **/

@property SKAction* idleLeftAnimation;
@property SKAction* idleRightAnimation;

@property SKAction* runLeftAnimation;
@property SKAction* runRightAnimation;

@property SKAction* walkLeftAnimation;
@property SKAction* walkRightAnimation;

@property SKAction* jumpLeftAnimation;
@property SKAction* jumpRightAnimation;

@property SKAction* climbAnimation;


@end



@implementation DesertHero


-(void)configureAnimations{
    
    self.idleLeftAnimation = [self generateIdleAnimation:LEFT];
    self.idleRightAnimation = [self generateIdleAnimation:RIGHT];

}

@end



