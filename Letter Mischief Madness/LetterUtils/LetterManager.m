//
//  LetterManager.m
//  Letter Mischief Madness
//
//  Created by Aleksander Makedonski on 1/22/18.
//  Copyright © 2018 Aleksander Makedonski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>
#import <UIKit/UIKit.h>
#import "RandomPointGenerator.h"
#import "LetterManager.h"
#import "Letter.h"
#import "LetterDelegate.h"
#import "EnemyType.h"

/** The letter manager spawns the letters for a given target word, adding them to the scene, and randomizes the positions of the letters at regular update intervals **/

@interface LetterManager() <LetterDelegate>

@property NSMutableArray<Letter*>* letters;
@property NSArray<NSValue*>* spawnPoints;
@property NSString* targetWord;

@property NSTimeInterval repositionInterval;
@property NSTimeInterval frameCount;
@property NSTimeInterval lastUpdateTime;

@property BOOL lettersAreHidden;
@property RandomPointGenerator* pointGenerator;

@end


@implementation LetterManager



-(instancetype)initWithSpawnPoints:(NSArray<NSValue*>*)spawnPoints andWithTargetWord:(NSString*)targetWord{

    self = [super init];
    
    if(self){
        self.spawnPoints = spawnPoints;
        self.targetWord = targetWord;
        self.letters = [[NSMutableArray alloc] initWithCapacity:self.targetWord.length];
        self.lettersAreHidden = YES;
        self.pointGenerator = [[RandomPointGenerator alloc] init];
        
        self.frameCount = 0.00;
        self.repositionInterval = 4.00;
        self.lastUpdateTime = 0.00;
    }
    
    return self;

}

-(void)addLettersTo:(SKScene*)scene{
    
    for (int charIndex = 0; charIndex < self.targetWord.length; charIndex++) {
        
        char wordChar = [self.targetWord characterAtIndex:charIndex];
        
        Letter* newLetter = [[Letter alloc] initWithLetter:wordChar andWithWordIndex:charIndex];
        
        newLetter.delegate = self;
        
        CGPoint randomPos = [self getRandomSpawnPointPosition];
        
        [newLetter addLetterTo:scene atPosition:randomPos];
        
        [self.letters addObject:newLetter];
        
    }
}



/** Automatically generates all the letters in a word **/

-(void)regenerateDeadLetters{
    
    for(int charIndex = 0; charIndex < self.targetWord.length; charIndex++){
        char wordChar = [self.targetWord characterAtIndex:charIndex];
        Letter* letter = [[Letter alloc] initWithLetter:wordChar];
        
        if(![self.letters containsObject:letter]){
            [self.letters addObject:letter];
        }
    }
}

-(void)update:(NSTimeInterval)currentTime{
    
    
    
    if(self.frameCount == currentTime){
        self.frameCount = 0;
    }
    
    
    self.frameCount += currentTime - self.lastUpdateTime;
    
    //Update all of the letters
    for (Letter*letter in self.letters) {
        
        [letter update:currentTime];
    }

    if(self.frameCount > self.repositionInterval){
        
        
        if(self.lettersAreHidden){
            
            [self revealLetters];
            
        } else {
        
            [self hideLetters];

        }
        
        self.frameCount = 0;
    }
    
    self.lastUpdateTime = currentTime;
}


-(void)revealLetters{
    
    for (Letter*letter in self.letters) {
        CGPoint randomOnScreenPos = [self getRandomOnScreenPosition];
        [letter setLetterPositionTo:randomOnScreenPos];
    }
    
    self.lettersAreHidden = NO;

}

-(void)hideLetters{
    for (Letter*letter in self.letters) {
        
        CGPoint randomPos = [self getRandomSpawnPointPosition];
        [letter setLetterPositionTo: randomPos];
        
    
    }
    
    self.lettersAreHidden = YES;
}

-(CGPoint)getRandomOnScreenPosition{
    
    return [self.pointGenerator getRandomOnScreenCoordinate];
}

-(CGPoint)getRandomSpawnPointPosition{
    
    NSUInteger randomIndex = arc4random_uniform((UInt32)self.spawnPoints.count);
    
    NSValue* positionVal = [self.spawnPoints objectAtIndex:randomIndex];
    
    return positionVal.CGPointValue;
}


/** The contacted letter can take different amounts of damage based on the enemy that contacts it **/

-(void)handleContactForLetterWith:(NSString*)letterIdentifier andWithContactedObjectName:(NSString*)contactedObjectName{
    
    NSLog(@"The letter identifiers is: %@",letterIdentifier);
    
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"identifier LIKE %@",letterIdentifier];
    
   Letter* contactedLetter = [[self.letters filteredArrayUsingPredicate:predicate] firstObject];
    
    NSString* contactedLetterInfo = [contactedLetter debugDescription];
    
    NSLog(@"Contacted letter info: %@",contactedLetterInfo);
    
    [contactedLetter takeDamage:1];
    

}

/** Conformance to LetterDelgate protocol **/

-(void)didDestroyLetter:(Letter *)letter{
    
    [self.letters removeObject:letter];
}


@end
