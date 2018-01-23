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

@interface Spikeman()

@property SKSpriteNode* sprite;

@end

@implementation Spikeman

-(instancetype)init{
    
    self = [super init];
    
    if(self){
        
        SKTexture* texture = [SKTexture textureWithImageNamed:@"spikeBall1"];
        
        self.sprite = [SKSpriteNode spriteNodeWithTexture:texture];
        
        [self configurePhysicsPropertiesWith:texture];
        
        [self configureAnimations];
    }
    
    return self;
    
}

-(void)configurePhysicsPropertiesWith:(SKTexture*)texture{
    
    CGSize textureSize = texture.size;
    
    self.sprite.physicsBody = [SKPhysicsBody bodyWithTexture:texture size:textureSize];
    
    self.sprite.physicsBody.categoryBitMask = kEnemyCategoryBitMask;
    self.sprite.physicsBody.collisionBitMask = 0;
    self.sprite.physicsBody.contactTestBitMask = kLetterCategoryBitMask;
    
}

-(void)configureAnimations{
    
    
    SKAction* rotateAction = [SKAction animateWithTextures:@[
         [SKTexture textureWithImageNamed:@"spikeBall1"],
         [SKTexture textureWithImageNamed:@"spikeBall2"]
         ] timePerFrame:0.10];
    
    SKAction* rotateAnimation = [SKAction repeatActionForever:rotateAction];
    
    [self.sprite runAction:rotateAnimation withKey:@"rotateAnimation"];
    
    
    
    
}


@end
