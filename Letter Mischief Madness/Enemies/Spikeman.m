//
//  Spikeman.m
//  Letter Mischief Madness
//
//  Created by Aleksander Makedonski on 1/23/18.
//  Copyright © 2018 Aleksander Makedonski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Spikeman.h"
#import "Constants.h"
#import "ContactBitMasks.h"

@interface Spikeman()

@property SKSpriteNode* sprite;

@end

@implementation Spikeman

-(instancetype)init{
    
    self = [super init];
    
    if(self){
        
        SKTexture* texture = [SKTexture textureWithImageNamed:@"spikeBall1"];
        
        self.sprite = [SKSpriteNode spriteNodeWithTexture:texture];
        
        [self configureNode];
        
        [self configurePhysicsPropertiesWith:texture];
        
        [self configureAnimations];
    }
    
    return self;
    
}

-(void)configureNode{
    self.sprite.name = @"spikeman";
    self.sprite.zPosition = kZPositionSpikeman;
    self.sprite.xScale *= 0.5;
    self.sprite.yScale *= 0.5;
}

-(void)configurePhysicsPropertiesWith:(SKTexture*)texture{
    
    CGSize textureSize = texture.size;
    
    self.sprite.physicsBody = [SKPhysicsBody bodyWithTexture:texture size:textureSize];
    
    self.sprite.physicsBody.affectedByGravity = NO;
    self.sprite.physicsBody.allowsRotation = NO;
    self.sprite.physicsBody.categoryBitMask = (UInt32)ENEMY;
    self.sprite.physicsBody.collisionBitMask = 0;
    self.sprite.physicsBody.contactTestBitMask = (UInt32)LETTER;
    
}

-(void)addTo:(SKScene*)scene atPosition:(CGPoint)position{
    
    [self.sprite moveToParent:scene];
    [self.sprite setPosition:position];
}

-(void)configureAnimations{
    
    
    SKAction* rotateAction = [SKAction animateWithTextures:@[
         [SKTexture textureWithImageNamed:@"spikeBall1"],
         [SKTexture textureWithImageNamed:@"spikeBall2"]
         ] timePerFrame:0.10];
    
    SKAction* rotateAnimation = [SKAction repeatActionForever:rotateAction];
    
    [self.sprite runAction:rotateAnimation withKey:@"rotateAnimation"];
    
    
    SKAction* moveLeftAction = [SKAction moveByX:-10.0 y:0.00 duration:1.50];
    SKAction* moveUpAction = [SKAction moveByX:0.00 y:10.0 duration:1.50];
    SKAction* moveDownRightAction = [SKAction moveByX:10.0 y:-10 duration:1.50];
    
    SKAction* moveActionSequence = [SKAction sequence:@[
        moveLeftAction,moveUpAction,moveDownRightAction
        ]];
    
    SKAction* moveAnimation = [SKAction repeatActionForever:moveActionSequence];
    
    [self.sprite runAction:moveAnimation withKey:@"moveAnimation"];
    
}


@end
