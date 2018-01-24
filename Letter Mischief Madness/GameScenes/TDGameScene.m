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

@interface TDGameScene()

@property TopDownPlane* player;

@end



@implementation TDGameScene


-(void)didMoveToView:(SKView *)view{
    
    self.anchorPoint = CGPointMake(0.5, 0.5);
    
    
    [self configureBackgroundTiles];
    
    TopDownPlane* playerPlane = [[TopDownPlane alloc] initWithPlaneColor:RED];
    self.player = playerPlane;
    
    [self.player setPlaneVerticalSpeed:30.0];
    
    CGPoint playerInitialPos = CGPointMake(0.0, -200.0);
    
    [self.player addPlaneTo:self atPosition:playerInitialPos];
    

    Letter* letterA = [[Letter alloc] initWithLetter:'A'];
    [letterA addLetterTo:self atPosition:CGPointMake(10.0, 100.0)];
    
    
    Letter* letterD = [[Letter alloc] initWithLetter:'D'];
    [letterD addLetterTo:self atPosition:CGPointMake(-10.0, 150.0)];
    
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


@end
