//
//  DesertHero+AnimationsGenerator.m
//  Letter Mischief Madness
//
//  Created by Aleksander Makedonski on 1/25/18.
//  Copyright © 2018 Aleksander Makedonski. All rights reserved.
//

#import "DesertHero+AnimationsGenerator.h"

@implementation DesertHero (AnimationsGenerator)

const static double kIdleActionDuration = 0.40;

-(SKAction *)generateIdleAnimation:(DesertCharacterOrientation)orientation{
    
    SKAction* idleAction;
    
    switch (orientation) {
        case LEFT:
            idleAction = [SKAction animateWithTextures:@[
             [SKTexture textureWithImageNamed:@"IdleLeft_000"],
             [SKTexture textureWithImageNamed:@"IdleLeft_001"],
             [SKTexture textureWithImageNamed:@"IdleLeft_002"],
             [SKTexture textureWithImageNamed:@"IdleLeft_003"],
             [SKTexture textureWithImageNamed:@"IdleLeft_004"],
             [SKTexture textureWithImageNamed:@"IdleLeft_005"],
             [SKTexture textureWithImageNamed:@"IdleLeft_006"],
             [SKTexture textureWithImageNamed:@"IdleLeft_007"],
             [SKTexture textureWithImageNamed:@"IdleLeft_008"],
             [SKTexture textureWithImageNamed:@"IdleLeft_009"],

             ] timePerFrame:kIdleActionDuration];
            break;
        case RIGHT:
            idleAction = [SKAction animateWithTextures:@[
             [SKTexture textureWithImageNamed:@"IdleRight_000"],
             [SKTexture textureWithImageNamed:@"IdleRight_001"],
             [SKTexture textureWithImageNamed:@"IdleRight_002"],
             [SKTexture textureWithImageNamed:@"IdleRight_003"],
             [SKTexture textureWithImageNamed:@"IdleRight_004"],
             [SKTexture textureWithImageNamed:@"IdleRight_005"],
             [SKTexture textureWithImageNamed:@"IdleRight_006"],
             [SKTexture textureWithImageNamed:@"IdleRight_007"],
             [SKTexture textureWithImageNamed:@"IdleRight_008"],
             [SKTexture textureWithImageNamed:@"IdleRight_009"],

                 ] timePerFrame:kIdleActionDuration];
            break;
        case SYMMETRICAL:
            break;
        default:
            break;
    }
    
    SKAction* idleAnimation = [SKAction repeatActionForever:idleAction];
    
    return idleAnimation;
    
}





@end
