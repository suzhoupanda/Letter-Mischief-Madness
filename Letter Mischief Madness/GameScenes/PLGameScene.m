//
//  PLGameScene.m
//  Letter Mischief Madness
//
//  Created by Aleksander Makedonski on 1/25/18.
//  Copyright © 2018 Aleksander Makedonski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PLGameScene.h"
#import "DesertHero.h"


@interface PLGameScene()

@property DesertHero* player;

@end


@implementation PLGameScene


-(void)didMoveToView:(SKView *)view{

    
    [self configureScene];
    [self configureBackgroundTiles];
    [self configurePlayer];
    

    
}

//MARK: ******** Scene Setup and Configuration

-(void)configureScene{
    
    self.anchorPoint = CGPointMake(0.5, 0.5);
    
    
}

-(void)configureBackgroundTiles{
    
    SKScene* bgTileScene = (SKScene*)[SKScene nodeWithFileNamed:@"PlatformerBG1"];
    
    SKNode* sceneRoot = [bgTileScene childNodeWithName:@"Root"];
    
    bgTileScene.anchorPoint = CGPointMake(0.5, 0.5);
    
    [sceneRoot moveToParent:self];
    [sceneRoot setPosition:CGPointMake(0.0, 0.0)];
    
}


-(void)configurePlayer{
    
    self.player = [[DesertHero alloc] init];
    
    CGPoint startingPos = CGPointMake(0.0, 10.0);
    
    [self.player addDesertHeroTo:self atPosition:startingPos];
}



//MARK:  ********** Touch Handling Functions

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    
}


-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    
}

//MARK: *********** Game Loop Functions

-(void)update:(NSTimeInterval)currentTime{
    
}

-(void)didSimulatePhysics{
    
}


@end
