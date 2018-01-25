//
//  GameScene.m
//  Letter Mischief Madness
//
//  Created by Aleksander Makedonski on 1/22/18.
//  Copyright © 2018 Aleksander Makedonski. All rights reserved.
//

#import "GameScene.h"
#import "RandomPointGenerator.h"
#import "Constants.h"
#import "ContactBitMasks.h"
#import "NSString+StringHelperMethods.h"
#import "Cloud.h"
#import "LetterManager.h"
#import "WordManager.h"
#import "Spikeman.h"

@interface GameScene() <SKPhysicsContactDelegate>

@property NSArray<NSValue*>*randomSpawnPoints;
@property LetterManager* letterManager;
@property NSString* targetWord;
@property WordManager* wordManager;

@end

@implementation GameScene

- (void)didMoveToView:(SKView *)view {
    // Setup your scene here
    
    [self configureScene];
    [self setupBackground];
    [self setupBGMusic];
    [self acquireTargetWord];
    [self setupWordManager];
    [self setupSpawnPoints];
    [self setupLetterManager];
    [self createClouds];
    [self.letterManager addLettersTo:self];
    
    Spikeman* spikeMan1 = [[Spikeman alloc] init];
    Spikeman* spikeMan2 = [[Spikeman alloc] init];
    
    [spikeMan1 addTo:self atPosition:CGPointMake(10.0, -30)];
    [spikeMan2 addTo:self atPosition:CGPointMake(-10.0, -40)];
    
    
    
}

-(void)setupWordManager{
    
    self.wordManager = [[WordManager alloc] initWithTargetWord:self.targetWord];
}

-(void)setupLetterManager{
    
    self.letterManager = [[LetterManager alloc] initWithSpawnPoints:self.randomSpawnPoints andWithTargetWord:self.targetWord];
    
}

-(void)acquireTargetWord{
    
    self.targetWord = @"LOVE";
}

-(void)configureScene{
    self.physicsWorld.contactDelegate = self;
    self.anchorPoint = CGPointMake(0.5, 0.5);
}

-(void)createClouds{
    
    
    
    for (NSValue*pointVal in self.randomSpawnPoints) {
        
        Cloud* randomCloud = [Cloud getRandomCloud];
        [randomCloud addSpriteTo:self atPosition:pointVal.CGPointValue];
    }
}

-(void)setupBGMusic{
    SKAudioNode* bgNode = [SKAudioNode nodeWithFileNamed:@"Mishief-Stroll.mp3"];
    
    if(bgNode){
        [self addChild:bgNode];

    }
}

-(void)setupBackground{
    
    SKEmitterNode* starEmitter = [SKEmitterNode nodeWithFileNamed:@"stars"];
    [self addChild:starEmitter];
    starEmitter.position = CGPointZero;
}

//TODO: need to refactor

-(void)setupSpawnPoints{
    
    RandomPointGenerator* pointGen = [[RandomPointGenerator alloc] init];
    int numPoints = kNumberOfOnScreenDebugPoints;
    self.randomSpawnPoints = [pointGen getArrayOfOnScreenPoints: numPoints];
    
    for (NSValue*randomPointVal in self.randomSpawnPoints) {
        
        CGPoint cgPoint = randomPointVal.CGPointValue;
        NSString* pointStr = [NSString getCoordString:cgPoint];
        NSLog(@"Point generated at %@",pointStr);
    }

}

/** Gets a random spawn point from the array of randomly generated spawn points **/

-(CGPoint)getRandomSpawnPoint{
    
    NSUInteger totalSpawnPoints = self.randomSpawnPoints.count;
    
    NSUInteger randomIndex = (NSUInteger)arc4random_uniform((UInt32)totalSpawnPoints);
    
    return [[self.randomSpawnPoints objectAtIndex:randomIndex] CGPointValue];
}


- (void)touchDownAtPoint:(CGPoint)pos {

}

- (void)touchMovedToPoint:(CGPoint)pos {

}

- (void)touchUpAtPoint:(CGPoint)pos {

}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {


    for (UITouch *t in touches) {
        
        
        CGPoint touchPoint = [t locationInNode:self];
        
        SKSpriteNode* node = (SKSpriteNode*)[self nodeAtPoint:touchPoint];
        
        if(node && [node.name containsString:@"letter"]){
            NSString* nodeName = node.name;
            
            char lastChar = [nodeName characterAtIndex:nodeName.length-1];
            NSLog(@"You touched the letter %c", lastChar);
            [self.wordManager evaluateNextLetter:lastChar];
            
        }
        
    }

}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
}


-(void)update:(CFTimeInterval)currentTime {
    
    // Called before each frame is rendered
    
    if(self.letterManager){
        
        [self.letterManager update:currentTime];

    }
}

-(void)didSimulatePhysics{
    
    if([self.wordManager hasCompletedTargetWord]){
        NSLog(@"Game Over, you win!!!");
        [self setPaused:YES];
    }
    
}

/** Conformance to SKPhysicsContact Delegate **/

-(void)didBeginContact:(SKPhysicsContact *)contact{
    
    NSLog(@"Processing contact between letter and other object...");
    
    SKPhysicsBody* bodyA = contact.bodyA;
    SKPhysicsBody* bodyB = contact.bodyB;
    
    SKPhysicsBody* otherBody;
    SKPhysicsBody* letterBody;
    
    if((bodyA.categoryBitMask & ((UInt32)LETTER)) > 0){
        NSLog(@"The otherbody is bodyB, the letter is bodyA");
        otherBody = bodyB;
        letterBody = bodyA;
        
    } else {
        NSLog(@"The otherbody is bodyA, the letter is bodyB");
        otherBody = bodyA;
        letterBody = bodyB;
       
       
    }
    

    SKSpriteNode*letterSprite = (SKSpriteNode*)[letterBody node];
    SKSpriteNode*otherSprite = (SKSpriteNode*)[otherBody node];
    
    
    switch (otherBody.categoryBitMask) {
        case (UInt32)ENEMY:
            NSLog(@"The enemy has been contacted by the letter....");
            [self.letterManager handleContactForLetterWith:letterSprite.name andWithContactedObjectName:otherSprite.name];
            break;
        default:
            NSLog(@"No contact logic implemented");
            break;
    }
    
}

-(void)didEndContact:(SKPhysicsContact *)contact{
    
    
}

@end
