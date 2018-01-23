//
//  Letter.m
//  Letter Mischief Madness
//
//  Created by Aleksander Makedonski on 1/22/18.
//  Copyright © 2018 Aleksander Makedonski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>
#import "Letter.h"
#import "ContactBitMasks.h"
#import "Constants.h"


@interface Letter()

@property SKSpriteNode* sprite;
@property int health;
@property NSUInteger wordIndex;

@end

@implementation Letter

-(instancetype)initWithLetter:(char)letter{
    
    self = [self initWithLetter:letter andWithWordIndex:0];
    
    return self;
}

-(instancetype)initWithLetter:(char)letter andWithWordIndex:(NSUInteger)wordIndex{
    
    self = [self initWithLetter:letter andWithStartingHealth:3 andWithWordIndex:wordIndex];
    
    return self;
}

-(instancetype)initWithLetter:(char)letter andWithStartingHealth: (int)startingHealth andWithWordIndex:(NSUInteger)wordIndex{

    self = [super init];
    
    if(self){
        
        letter = toupper(letter);
        
        self.health = startingHealth;
        self.wordIndex = wordIndex;
        
        NSString* spriteName = [NSString stringWithFormat:@"letter_%c",letter];

        SKTexture* letterTexture = [SKTexture textureWithImageNamed:spriteName];
        
        self.sprite = [SKSpriteNode spriteNodeWithTexture:letterTexture];
        
        
        [self configureSpriteWithNodeName:spriteName];
        
        [self configurePhysicsProperties:letterTexture];
        
    }
    
    return self;
}

-(NSString *)identifier{
    return self.sprite.name;
}

-(void)configurePhysicsProperties:(SKTexture*)letterTexture{
    
    CGSize textureSize = [letterTexture size];
    
    self.sprite.physicsBody = [SKPhysicsBody bodyWithTexture:letterTexture size:textureSize];

    self.sprite.physicsBody.categoryBitMask = (UInt32)LETTER;
    self.sprite.physicsBody.collisionBitMask = -1;
    self.sprite.physicsBody.contactTestBitMask = (UInt32)ENEMY;
    
}

-(void)configureSpriteWithNodeName:(NSString*)spriteName{
    self.sprite.anchorPoint = CGPointMake(0.5, 0.5);
    self.sprite.xScale *= 0.2;
    self.sprite.yScale *= 0.2;
    self.sprite.name = [NSString stringWithFormat:@"%lu%@",(unsigned long)self.wordIndex,spriteName];
}

-(void)addLetterTo:(SKScene*)scene atPosition:(CGPoint)position{
    
    [self.sprite moveToParent:scene];
    [self.sprite setZPosition:kZPositionLetter];
    [self.sprite setPosition:position];
}

-(void)setLetterPositionTo:(CGPoint)position{
    
    SKAction* moveAction = [SKAction moveTo:position duration:0.5];
    [self.sprite runAction:moveAction];
    
}

-(void)takeDamage:(int)damageAmount{
    
    self.health -= damageAmount;
    
    [self.delegate didDamageLetter:self];
    
    switch (self.health) {
        case 3:
            [self runDamageAnimation];
            break;
        case 2:
            [self runDamageAnimation];
            break;
        case 1:
            [self runDamageAnimation];
            break;
        case 0:
            [self die];
            
            break;
        default:
            break;
    }
    
   
    
}

-(void)runDamageAnimation{
    
    SKAction* fadeAction = [SKAction fadeAlphaBy:0.20 duration:0.10];
    
    [self.sprite runAction:fadeAction];
}

-(void)die{
    
    [self.sprite removeFromParent];
    [self.delegate didDestroyLetter:self];

}



@end
