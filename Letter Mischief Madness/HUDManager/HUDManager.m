//
//  HUDManager.m
//  Letter Mischief Madness
//
//  Created by Aleksander Makedonski on 1/26/18.
//  Copyright © 2018 Aleksander Makedonski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HUDManager.h"


@interface HUDManager()

@property SKNode* scoreNode;
@property SKNode* targetWordNode;
@property SKNode* wordInProgressNode;

@property SKLabelNode* scoreLabel;
@property SKLabelNode* targetWordLabel;
@property SKLabelNode* wordInProgressLabel;

@end


@implementation HUDManager

-(instancetype)init{
    
    self = [super init];
    
    
    if(self){
        [self setupHUDNodes];
    }
    
    return self;
}

-(instancetype)initWithTargetWord:(NSString*)targetWord{
    
    self = [super init];
    
    if(self){
        
        [self setupHUDNodes];
        
        [self updateTargetWordNode:targetWord];
        [self updateWordInProgressNode:@""];
        [self updateScoreNode:0];
    }
    
    return self;
}

-(void)setupHUDNodes{
    
    self.scoreNode = [[SKNode alloc] init];
    self.scoreLabel = [SKLabelNode labelNodeWithFontNamed:@"Avenir"];
    [self.scoreLabel moveToParent:self.scoreNode];
    
    self.targetWordNode = [[SKNode alloc] init];
    self.targetWordLabel = [SKLabelNode labelNodeWithFontNamed:@"Avenir"];
    [self.targetWordLabel moveToParent:self.targetWordNode];
    
    self.wordInProgressNode = [[SKNode alloc] init];
    self.wordInProgressLabel = [SKLabelNode labelNodeWithFontNamed:@"Avenir"];
    [self.wordInProgressLabel moveToParent:self.wordInProgressNode];
    
    
}

-(void)addHUDNodeTo:(SKScene*)scene atPosition:(CGPoint)position{
    
    [self.targetWordNode moveToParent:scene];
    [self.wordInProgressNode moveToParent:scene];
    [self.scoreNode moveToParent:scene];
    
}

-(void)updateScoreNode:(int)updatedScore{
    
    
}

-(void)updateTargetWordNode:(NSString*)updatedTargetWord{
    
}

-(void)updateWordInProgressNode:(NSString*)updatedWordInProgress{
    
}



@end
