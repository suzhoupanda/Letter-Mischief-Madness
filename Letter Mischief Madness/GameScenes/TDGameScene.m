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


@interface TDGameScene()

@property TopDownPlane* player;

@end



@implementation TDGameScene


-(void)didMoveToView:(SKView *)view{
    
    self.anchorPoint = CGPointMake(0.5, 0.5);
    
    TopDownPlane* playerPlane = [[TopDownPlane alloc] initWithPlaneColor:RED];
    self.player = playerPlane;
    
    CGPoint playerInitialPos = CGPointMake(0.0, -200.0);
    
    [self.player addPlaneTo:self atPosition:playerInitialPos];
    
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
