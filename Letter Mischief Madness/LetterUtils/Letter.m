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
#import "Constants.h"

@interface Letter()

@property SKSpriteNode* sprite;

@end

@implementation Letter

-(instancetype)initWithLetter:(char)letter{

    self = [super init];
    
    if(self){
        
        letter = toupper(letter);
        
        NSString* spriteName = [NSString stringWithFormat:@"letter_%c",letter];

        self.sprite = [SKSpriteNode spriteNodeWithImageNamed:spriteName];
        [self configureSprite];
        
    }
    
    return self;
}


-(void)configureSprite{
    self.sprite.anchorPoint = CGPointMake(0.5, 0.5);
    self.sprite.xScale *= 0.2;
    self.sprite.yScale *= 0.2;
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

@end
