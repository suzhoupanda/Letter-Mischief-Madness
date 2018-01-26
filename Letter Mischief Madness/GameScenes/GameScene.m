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
#import "TargetWordArray.h"
#import "Spikeman.h"
#import "StatTracker.h"
#import "HUDManager.h"


@interface GameScene() <SKPhysicsContactDelegate,WordManagerDelegate>

@property NSArray<NSValue*>*randomSpawnPoints;
@property LetterManager* letterManager;
@property NSString* targetWord;

@property WordManager* wordManager;
@property TargetWordArray* debugTargetWordArray;
@property StatTracker* statTracker;
@property HUDManager* hudManager;

@end

@implementation GameScene

const static CGFloat kHUDXPosition = 0.0;
const static CGFloat kHUDYPosition = 0.0;


- (void)didMoveToView:(SKView *)view {
    // Setup your scene here
    
    [self configureScene];
    [self setupBackground];
    [self setupBGMusic];
    [self setupSpawnPoints];
    [self setupHUDManager];
    [self setupStatTracker];
    [self setupWordManager];
    [self acquireTargetWord];
    [self setupLetterManager];
    [self createClouds];
    [self addTargetWordLetters];
    
    

    
}

-(void)addTargetWordLetters{

    if([self.letterManager targetWord]){
        [self.letterManager addLettersTo:self];
    }

}


-(void)setupHUDManager{
    
    [self.hudManager addHUDNodeTo:self atPosition:CGPointMake(kHUDXPosition, kHUDYPosition)];
    
}

-(void)setupWordManager{
    
    self.debugTargetWordArray = [[TargetWordArray alloc] initDebugArray];
    
    self.wordManager = [[WordManager alloc] initWith:self.debugTargetWordArray];
    
    self.wordManager.delegate = self;
    

}

-(void)setupStatTracker{
    
    self.statTracker = [[StatTracker alloc] init];
}

-(void)setupLetterManager{
    
    self.letterManager = [[LetterManager alloc] initWithSpawnPoints:self.randomSpawnPoints andWithTargetWord:self.targetWord];
    
}

-(void)acquireTargetWord{
    
    self.targetWord = [self.wordManager getTargetWord];
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
    

    
}

/** Conformance to SKPhysicsContact Delegate **/

-(void)didBeginContact:(SKPhysicsContact *)contact{
    
    
    SKPhysicsBody* bodyA = contact.bodyA;
    SKPhysicsBody* bodyB = contact.bodyB;
    
    SKPhysicsBody* otherBody;
    SKPhysicsBody* letterBody;
    
    if((bodyA.categoryBitMask & ((UInt32)LETTER)) > 0){
        otherBody = bodyB;
        letterBody = bodyA;
        
    } else {
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

/** Word Manager delegate methods **/

-(void)didUpdateWordInProgress:(NSString *)wordInProgress{
    NSLog(@"The word in progress has been updated - the current word in progress is now: %@", wordInProgress);
    
    [self.hudManager updateWordInProgressNode:wordInProgress];
}

-(void)didClearWordInProgress:(NSString *)deletedWordInProgress{
    
    NSLog(@"The word in progress %@ has been cleared.  You must start over in order to spell the target word",deletedWordInProgress);
    
    
}

-(void)didMisspellWordInProgress:(NSString*)misspelledWordInProgress{
    
    self.statTracker.numberOfMisspellings += 1;
    
}


-(void)didCompleteWordInProgress:(NSString *)completedWordInProgress{
    
    NSLog(@"The user has completed the word in progress: %@",completedWordInProgress);
    
}

-(void)didUpdateTargetWordTo:(NSString*)updatedTargetWord fromPreviousTargetWord:(NSString*)previousTargetWord{
    
    NSLog(@"The target word has been updated.  The new target word is: %@",updatedTargetWord);
    
    self.statTracker.numberOfTargetWordsCompleted += 1;
    [self.statTracker addPointsForTargetWord:previousTargetWord];
    
    [self.hudManager updateTargetWordNode:updatedTargetWord];
    [self.hudManager updateScoreNode:self.statTracker.totalPointsAccumulated];
    
    
    /** Acquire the next target word form the WordManager **/
    [self acquireTargetWord];
    
   
    /** Remove letter nodes from the scene **/
    [self removeLetterNodes];
    
    /** Clear all the letters currently managed by the LetterManager **/
    [self.letterManager clearLetters];
    
    /** Reset the target word for the letter manager **/
    [self.letterManager setTargetWord:self.targetWord];
    
    /** Add the new letters from the letter manager to the scene **/
    [self.letterManager addLettersTo:self];
}

-(void)didExtendWordInProgress:(NSString*)extendedWordInProgress{
    
    self.statTracker.numberOfLettersSpelledCorrectly += 1;
    
}

-(void)removeLetterNodes{
    for (SKSpriteNode* node in self.children) {
        if([node.name containsString:@"letter"]){
            [node removeFromParent];
        }
    }
}




@end
