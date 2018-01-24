//
//  MissileLauncher.m
//  Letter Mischief Madness
//
//  Created by Aleksander Makedonski on 1/24/18.
//  Copyright © 2018 Aleksander Makedonski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>
#import "MissileLauncher.h"
#import "ContactBitMasks.h"
#import "Constants.h"


@interface MissileLauncher()

typedef enum{
    LAUNCHER1,
    LAUNCHER2
}LauncherType;

@property SKSpriteNode* launcherSprite;
@property SKSpriteNode* missileSprite;
@property SKPhysicsBody* detectionNode;

@property (weak) SKScene* baseScene;

@end


@implementation MissileLauncher


-(instancetype)init{
    
    self = [super init];
    
    if(self){
        
        [self configureLauncher];
        [self configureMissile];
        [self configureDetectionNode];
    }
    
    return self;
}


-(void)addMissileLauncherTo:(SKScene*)scene atPosition:(CGPoint)position{
    
    [self.launcherSprite moveToParent:scene];
    [self.launcherSprite setPosition:position];
}


-(void)configureLauncher{
    
    

    SKTexture* launcherTexture = [SKTexture textureWithImageNamed:@"missileLauncher1"];
    
    self.launcherSprite = [SKSpriteNode spriteNodeWithTexture:launcherTexture];
    
    self.launcherSprite.anchorPoint = CGPointMake(0.5, 0.5);
    
    CGSize launcherSize = [launcherTexture size];
    
    self.launcherSprite.physicsBody = [SKPhysicsBody bodyWithTexture:launcherTexture size:launcherSize];
    
    self.launcherSprite.physicsBody.affectedByGravity = NO;
    self.launcherSprite.physicsBody.allowsRotation = YES;
    self.launcherSprite.physicsBody.angularDamping = 0.00;
    self.launcherSprite.physicsBody.linearDamping = 0.00;
    self.launcherSprite.physicsBody.pinned = YES;
    
    self.launcherSprite.physicsBody.categoryBitMask = TD_ENEMY;
    self.launcherSprite.physicsBody.collisionBitMask = 0;
    self.launcherSprite.physicsBody.contactTestBitMask = TD_PLAYER;
    
}

-(void)configureMissile{
    
}

-(void)configureDetectionNode{
    
    
}

-(void)fireMissileAt:(CGPoint)targetPos{
    

}

-(void)removeOrientationConstraints{
    
    self.launcherSprite.constraints = nil;
}

-(void)addOrientationConstraintsFor:(CGPoint)targetPos{
    
    SKConstraint* orientationConstraint = [SKConstraint orientToPoint:targetPos inNode:self offset:nil];
    
    self.launcherSprite.constraints = @[orientationConstraint];
}

@end
