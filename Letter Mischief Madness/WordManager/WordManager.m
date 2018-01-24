//
//  WordManager.m
//  Letter Mischief Madness
//
//  Created by Aleksander Makedonski on 1/23/18.
//  Copyright © 2018 Aleksander Makedonski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WordManager.h"
#import "Letter.h"
#import "Constants.h"

@interface WordManager()

@property NSString* targetWord;
@property NSString* wordInProgress;

@property (readwrite) BOOL isAutomaticallyLooped;
@property id<WordManagerDataSource> dataSource;

@property (readonly) int pointsForTargetWord;
@property int numberOfTargetWordsCompleted;

@end

@implementation WordManager

-(instancetype)initWithTargetWord:(NSString *)targetWord{
    
    self = [super init];
    
    if(self){
        
        self.targetWord = targetWord;
        self.wordInProgress = [[NSString alloc] init];
        self.isAutomaticallyLooped = NO;
        self.numberOfTargetWordsCompleted = 0;
        
    }
    
    return self;
}

-(instancetype)initWith:(id<WordManagerDataSource>)targetWordDataSource{
    
    self = [super init];
    
    if(self){
        
        self.dataSource = targetWordDataSource;
        self.targetWord = [self.dataSource getInitialTargetWord];
        self.wordInProgress = [[NSString alloc] init];
        self.isAutomaticallyLooped = YES;
        self.numberOfTargetWordsCompleted = 0;
        
    }
    
    return self;
}

-(void)evaluateNextLetter:(char)nextLetter{
    
    
    NSUInteger currentWordLength = self.wordInProgress.length;
    
    if(!self.isAutomaticallyLooped){
        if(currentWordLength >= self.targetWord.length){

        
            NSLog(@"The word in progress has already equaled or exceeded the length of the target word;");
            self.numberOfTargetWordsCompleted = 1;
            return;
        }
    
    } else {
        if(self.hasCompletedTargetWord){
            
            self.totalPoints += self.pointsForTargetWord;
            self.numberOfTargetWordsCompleted += 1;
            [self acquireNextTargetWord];
            self.wordInProgress = [[NSString alloc] init];

        } else {
            
            self.wordInProgress = [[NSString alloc] init];
        }
    }
    char nextTargetLetter = [self.targetWord characterAtIndex:currentWordLength];
    
    /**  If the next letter touched is the same as the next letter in the target word, add it to the cached word in progress **/
    if(nextLetter == nextTargetLetter){
        
        [self showDebugMessageWith:@"The next letter equals the next letter in the target word"];
   
        
        self.wordInProgress = [NSString stringWithFormat:@"%@%c",self.wordInProgress,nextLetter];
        
        [self showDebugMessageWith:[NSString stringWithFormat:@"The word in progress is: %@",self.wordInProgress]];
        
        /** If the next letter touched is not the same as the next letter in the target word, clear the word in progress; based on game rules, the user must start building the word again **/
    } else {
        
        [self showDebugMessageWith:@"The next letter does not equal the next letter in the target word - proceeding to clear the temporary word..."];

        
        self.wordInProgress = [[NSString alloc] init];
    }
    
}

-(BOOL)hasCompletedTargetWord{
    
    if(self.wordInProgress && self.targetWord){
        return [self.wordInProgress isEqualToString:self.targetWord];
    }
    
    return NO;
}

-(int)pointsForTargetWord{
    
    int totalPoints = 0;
    
    for (NSUInteger charIndex = 0; charIndex < self.wordInProgress.length; charIndex++) {
        
        char wordChar = [self.targetWord characterAtIndex:charIndex];
        int pointsForChar = [Letter pointsForLetter:wordChar];
        totalPoints += pointsForChar;
        
    }
    
    return totalPoints;
}

/** **/
-(void)acquireNextTargetWord{
    
    if([self.dataSource respondsToSelector:@selector(hasAcquiredAllTargetWords)] && [self.dataSource hasAcquiredAllTargetWords]){
        
        NSLog(@"All target words have been acquired...");
        
        /** Implement custom logic for cases where special rules apply if all the words provided by a data source have been provided  **/
    }
    
    self.targetWord = [self.dataSource getNextTargetWord];
}

-(void) showDebugMessageWith:(NSString*)text{
    if(kDebugWordManager){
        NSLog(text);
        
    }
}

@end
