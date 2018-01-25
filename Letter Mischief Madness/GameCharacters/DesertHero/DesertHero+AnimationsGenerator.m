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
const static double kRunActionDuration = 0.30;
const static double kShootActionDuration = 0.30;
const static double kJumpActionDuration = 0.20;
const static double kWalkActionDuration = 0.30;



-(NSString*)generateAnimationKeyFor:(AnimationType)animationType andFor:(DesertCharacterOrientation)orientation{
    
    NSString* baseStr = [[NSString alloc] init];
    
    switch (animationType) {
        case IDLE:
            baseStr = @"idle";
            break;
        case WALK:
            baseStr = @"walk";
            break;
        case RUN:
            baseStr = @"run";
            break;
        case SHOOT:
            baseStr = @"shoot";
            break;
        case JUMP:
            baseStr = @"jump";
            break;
        default:
            break;
    }
    
    NSString* orientationStr;
    
    switch (orientation) {
        case LEFT:
            orientationStr = @"Left";
            break;
        case RIGHT:
            orientationStr = @"Right";
            break;
        case SYMMETRICAL:
            orientationStr = @"Symmetric";
            break;
        default:
            break;
    }
    
    
    return [baseStr stringByAppendingString:orientationStr];
    
}

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


-(SKAction *)generateRunAnimation:(DesertCharacterOrientation)orientation{
    
    SKAction*(^getRunAnimation)(DesertCharacterOrientation) = [self getAnimationGeneratorWithLeftOrientationTextures:@[
           [SKTexture textureWithImageNamed:@"RunLeft_000"],
           [SKTexture textureWithImageNamed:@"RunLeft_001"],
           [SKTexture textureWithImageNamed:@"RunLeft_002"],
           [SKTexture textureWithImageNamed:@"RunLeft_003"],
           [SKTexture textureWithImageNamed:@"RunLeft_004"],
           [SKTexture textureWithImageNamed:@"RunLeft_005"],
           [SKTexture textureWithImageNamed:@"RunLeft_006"],
           [SKTexture textureWithImageNamed:@"RunLeft_007"],
           [SKTexture textureWithImageNamed:@"RunLeft_008"],
           [SKTexture textureWithImageNamed:@"RunLeft_009"]
           
       ]
      
      andWithRightOrientationTexture:@[
      
           [SKTexture textureWithImageNamed:@"RunRight_000"],
           [SKTexture textureWithImageNamed:@"RunRight_001"],
           [SKTexture textureWithImageNamed:@"RunRight_002"],
           [SKTexture textureWithImageNamed:@"RunRight_003"],
           [SKTexture textureWithImageNamed:@"RunRight_004"],
           [SKTexture textureWithImageNamed:@"RunRight_005"],
           [SKTexture textureWithImageNamed:@"RunRight_006"],
           [SKTexture textureWithImageNamed:@"RunRight_007"],
           [SKTexture textureWithImageNamed:@"RunRight_008"],
           [SKTexture textureWithImageNamed:@"RunRight_009"]
      ] andWithSymmetricOrientationTextures: nil
     andWithTimePerFrame:kRunActionDuration];
    
    return getRunAnimation(orientation);
    
}

-(SKAction *)generateJumpAnimation:(DesertCharacterOrientation)orientation{
    
    SKAction*(^getJumpAnimation)(DesertCharacterOrientation) = [self getAnimationGeneratorWithLeftOrientationTextures:@[
        
    [SKTexture textureWithImageNamed:@"JumpLeft_000"],
    [SKTexture textureWithImageNamed:@"JumpLeft_001"],
    [SKTexture textureWithImageNamed:@"JumpLeft_002"],
    [SKTexture textureWithImageNamed:@"JumpLeft_003"],
    [SKTexture textureWithImageNamed:@"JumpLeft_004"],
    [SKTexture textureWithImageNamed:@"JumpLeft_005"],
    [SKTexture textureWithImageNamed:@"JumpLeft_006"],
    [SKTexture textureWithImageNamed:@"JumpLeft_007"],
    [SKTexture textureWithImageNamed:@"JumpLeft_008"],
    [SKTexture textureWithImageNamed:@"JumpLeft_009"]
                                                                                                            
        ] andWithRightOrientationTexture:@[
       
   [SKTexture textureWithImageNamed:@"JumpRight_000"],
   [SKTexture textureWithImageNamed:@"JumpRight_001"],
   [SKTexture textureWithImageNamed:@"JumpRight_002"],
   [SKTexture textureWithImageNamed:@"JumpRight_003"],
   [SKTexture textureWithImageNamed:@"JumpRight_004"],
   [SKTexture textureWithImageNamed:@"JumpRight_005"],
   [SKTexture textureWithImageNamed:@"JumpRight_006"],
   [SKTexture textureWithImageNamed:@"JumpRight_007"],
   [SKTexture textureWithImageNamed:@"JumpRight_008"],
   [SKTexture textureWithImageNamed:@"JumpRight_009"]
       ] andWithSymmetricOrientationTextures:nil andWithTimePerFrame:kJumpActionDuration];
    
    return getJumpAnimation(orientation);
}



-(SKAction *)generateShootAnimation:(DesertCharacterOrientation)orientation{
    
    SKAction*(^getShootAnimation)(DesertCharacterOrientation) = [self getAnimationGeneratorWithLeftOrientationTextures:
  @[
    [SKTexture textureWithImageNamed:@"ShootLeft_000"],
    [SKTexture textureWithImageNamed:@"ShootLeft_001"],
    [SKTexture textureWithImageNamed:@"ShootLeft_002"],
    [SKTexture textureWithImageNamed:@"ShootLeft_003"],
    [SKTexture textureWithImageNamed:@"ShootLeft_004"],
    [SKTexture textureWithImageNamed:@"ShootLeft_005"],
    [SKTexture textureWithImageNamed:@"ShootLeft_006"],
    [SKTexture textureWithImageNamed:@"ShootLeft_007"],
    [SKTexture textureWithImageNamed:@"ShootLeft_008"],
    [SKTexture textureWithImageNamed:@"ShootLeft_009"],


    
    ]
    andWithRightOrientationTexture:
  @[
    [SKTexture textureWithImageNamed:@"ShootRight_000"],
    [SKTexture textureWithImageNamed:@"ShootRight_001"],
    [SKTexture textureWithImageNamed:@"ShootRight_002"],
    [SKTexture textureWithImageNamed:@"ShootRight_003"],
    [SKTexture textureWithImageNamed:@"ShootRight_004"],
    [SKTexture textureWithImageNamed:@"ShootRight_005"],
    [SKTexture textureWithImageNamed:@"ShootRight_006"],
    [SKTexture textureWithImageNamed:@"ShootRight_007"],
    [SKTexture textureWithImageNamed:@"ShootRight_008"],
    [SKTexture textureWithImageNamed:@"ShootRight_009"],


    ]
   andWithSymmetricOrientationTextures:nil
   andWithTimePerFrame:kShootActionDuration];
    
    return getShootAnimation(orientation);
    
}



-(SKAction *)generateWalkAnimation:(DesertCharacterOrientation)orientation{
    
    SKAction*(^getWalkAnimation)(DesertCharacterOrientation) = [self getAnimationGeneratorWithLeftOrientationTextures:
  @[
    [SKTexture textureWithImageNamed:@"WalkLeft_000"],
    [SKTexture textureWithImageNamed:@"WalkLeft_001"],
    [SKTexture textureWithImageNamed:@"WalkLeft_002"],
    [SKTexture textureWithImageNamed:@"WalkLeft_003"],
    [SKTexture textureWithImageNamed:@"WalkLeft_004"],
    [SKTexture textureWithImageNamed:@"WalkLeft_005"],
    [SKTexture textureWithImageNamed:@"WalkLeft_006"],
    [SKTexture textureWithImageNamed:@"WalkLeft_007"],
    [SKTexture textureWithImageNamed:@"WalkLeft_008"],
    [SKTexture textureWithImageNamed:@"WalkLeft_009"],


    ]
   andWithRightOrientationTexture:
  @[
    [SKTexture textureWithImageNamed:@"WalkRight_000"],
    [SKTexture textureWithImageNamed:@"WalkRight_001"],
    [SKTexture textureWithImageNamed:@"WalkRight_002"],
    [SKTexture textureWithImageNamed:@"WalkRight_003"],
    [SKTexture textureWithImageNamed:@"WalkRight_004"],
    [SKTexture textureWithImageNamed:@"WalkRight_005"],
    [SKTexture textureWithImageNamed:@"WalkRight_006"],
    [SKTexture textureWithImageNamed:@"WalkLeft_007"],
    [SKTexture textureWithImageNamed:@"WalkLeft_008"],
    [SKTexture textureWithImageNamed:@"WalkLeft_009"],

    ]
                                                                
  andWithSymmetricOrientationTextures:nil andWithTimePerFrame:kWalkActionDuration];
    
    return getWalkAnimation(orientation);
    
};

-(SKAction*(^)(DesertCharacterOrientation))getAnimationGeneratorWithLeftOrientationTextures:(NSArray<SKTexture*>*)leftOrientationTextures andWithRightOrientationTexture:(NSArray<SKTexture*>*)rightOrientationTextures andWithSymmetricOrientationTextures:(NSArray<SKTexture*>*)symmetricOrientationTextures andWithTimePerFrame:(NSTimeInterval)timePerFrame{
    
    return ^(DesertCharacterOrientation orientation){
        
        SKAction* baseAction;
        
        switch (orientation) {
            case LEFT:
                baseAction =  [SKAction animateWithTextures:leftOrientationTextures timePerFrame:timePerFrame];
                break;
            case RIGHT:
                baseAction =  [SKAction animateWithTextures:rightOrientationTextures timePerFrame:timePerFrame];
                break;
            case SYMMETRICAL:
                baseAction =  [SKAction animateWithTextures:symmetricOrientationTextures timePerFrame:timePerFrame];
                break;
            default:
                break;
        }
        
        SKAction* repeatingAnimation = [SKAction repeatActionForever:baseAction];
        
        return repeatingAnimation;
        
        
    };
}




@end
