//
//  TDGameScene.m
//  Letter Mischief Madness
//
//  Created by Aleksander Makedonski on 1/24/18.
//  Copyright © 2018 Aleksander Makedonski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TDGameScene.h"
#import "TopDownPlane.h"
#import "Letter.h"

#import "Constants.h"
#import "ContactBitMasks.h"

#import "WordManager.h"
#import "TargetWordArray.h"
#import <ctype.h>

@interface TDGameScene() <SKPhysicsContactDelegate,WordManagerDelegate>

@property TopDownPlane* player;

@property WordManager* wordManager;
@property TargetWordArray* debugTargetWordArray;


@end



@implementation TDGameScene




-(void)didMoveToView:(SKView *)view{
    
    
    [self configureScene];
    
    [self configureWordManager];

    [self configureBackgroundTiles];
    
    [self configurePlayerPlane];

    Letter* letterA = [[Letter alloc] initWithLetter:'A'];
    [letterA addLetterTo:self atPosition:CGPointMake(10.0, 100.0)];
    
    
    Letter* letterD = [[Letter alloc] initWithLetter:'D'];
    [letterD addLetterTo:self atPosition:CGPointMake(-10.0, 150.0)];
    
}


-(void)configureScene{
    self.anchorPoint = CGPointMake(0.5, 0.5);
    self.physicsWorld.contactDelegate = self;
}

-(void)configurePlayerPlane{
    
    TopDownPlane* playerPlane = [[TopDownPlane alloc] initWithPlaneColor:RED];
    self.player = playerPlane;
    
    [self.player setPlaneVerticalSpeed:30.0];
    
    CGPoint playerInitialPos = CGPointMake(0.0, -200.0);
    
    [self.player addPlaneTo:self atPosition:playerInitialPos];
    
    
}

-(void)configureWordManager{
    
    self.debugTargetWordArray = [[TargetWordArray alloc] initDebugArray];
    
    self.wordManager = [[WordManager alloc] initWith:self.debugTargetWordArray];
    
    self.wordManager.delegate = self;
    
}

-(void)configureBackgroundTiles{
    
    SKScene* bgTileScene = (SKScene*)[SKScene nodeWithFileNamed:@"TopDownBG1"];
    SKNode* sceneRoot = [bgTileScene childNodeWithName:@"Root"];
    
    bgTileScene.anchorPoint = CGPointMake(0.5, 0.5);
    
    [sceneRoot moveToParent:self];
    [sceneRoot setPosition:CGPointMake(0.0, 0.0)];
    
}

/** Touch Handling Functions  **/

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch* firstTouch = [[touches allObjects] firstObject];
    CGPoint touchLocation = [firstTouch locationInNode:self];
    
    if(touchLocation.x < self.player.planePosition.x - 10){
        
        [self.player tapLeft];
        
    } else if (touchLocation.x > self.player.planePosition.x + 10){
        
        [self.player tapRight];
        
    }
    
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
}


/** Game Loop Update Functions **/

-(void)update:(NSTimeInterval)currentTime{
    [self.player update];
}

-(void)didSimulatePhysics{
    [self checkPlayerPosition];
}

-(void)checkPlayerPosition{
    
    if(self.player.planePosition.x < -170.00){
        self.player.isOutsideLeftBoundary = YES;
    } else if(self.player.planePosition.x > 170.00){
        self.player.isOutsideRightBoundary = YES;
    }
}



//MARK: ******* SKPhysicsContactDelegate Methods

-(void)didBeginContact:(SKPhysicsContact *)contact{
    
    NSLog(@"A contact between game objects has occurred....");
    
    
    SKPhysicsBody* bodyA = contact.bodyA;
    SKPhysicsBody* bodyB = contact.bodyB;
    
    SKPhysicsBody* playerBody;
    SKPhysicsBody* otherBody;
    
    if((bodyA.categoryBitMask & (UInt32)TD_PLAYER) > 0){
        playerBody = bodyA;
        otherBody = bodyB;
    } else {
        playerBody = bodyB;
        otherBody = bodyA;
    }
    
    
    char letterChar = [Letter getLetterCharacterFromPhysicsBody:otherBody];
    
    switch (otherBody.categoryBitMask) {
        case TD_LETTER:
            NSLog(@"Player has contaced a letter");
            if(letterChar != kNoLetterCharacterAssociatedWithPhysicsBody){
                [self.wordManager evaluateNextLetter:letterChar];
                
             
            }
            break;
        case ENEMY:
            break;
        default:
            break;
    }
}

-(void)didEndContact:(SKPhysicsContact *)contact{
    
    
    
}


/** Word Manager delegate methods **/

-(void)didUpdateWordInProgress:(NSString *)wordInProgress{
    NSLog(@"The word in progress has been updated - the current word in progress is now: %@", wordInProgress);
    
}

-(void)didClearWordInProgress:(NSString *)deletedWordInProgress{
    
    NSLog(@"The word in progress %@ has been cleared.  You must start over in order to spell the target word",deletedWordInProgress);
}


-(void)didEarnPoints:(int)totalPoints forTargetWord:(NSString *)targetWord{
    
    NSLog(@"The user has earned %d total points for spelling the target word %@",totalPoints,targetWord);
    
}

-(void)didCompleteWordInProgress:(NSString *)completedWordInProgress{
    
    NSLog(@"The user has completed the word in progress: %@",completedWordInProgress);
    
}

-(void)didUpdateTargetWord:(NSString *)updatedTargetWord{
    
    NSLog(@"The target word has been updated.  The new target word is: %@",updatedTargetWord);
}


@end
