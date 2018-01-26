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

@property id<WordManagerDataSource> dataSource;


@property (readonly) int pointsForTargetWord;
@property (readwrite) int totalPoints;

@property int numberOfTargetWordsCompleted;

@end

@implementation WordManager

-(instancetype)initWithTargetWord:(NSString *)targetWord{
    
    self = [super init];
    
    if(self){
        
        self.targetWord = targetWord;
        self.wordInProgress = [[NSString alloc] init];
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
        self.numberOfTargetWordsCompleted = 0;
        
    }
    
    return self;
}

-(NSString*)getTargetWord{
    return self.targetWord;
}

-(NSString*)getWordInProgress{
    return self.wordInProgress;
}

-(void)evaluateNextLetter:(char)nextLetter{
    
    
    NSUInteger currentWordLength = self.wordInProgress.length;
    
    
    
    char nextTargetLetter = [self.targetWord characterAtIndex:currentWordLength];
    
    /**  If the next letter touched is the same as the next letter in the target word, add it to the cached word in progress **/
    if(nextLetter == nextTargetLetter){
        
        [self showDebugMessageWith:@"The next letter equals the next letter in the target word"];
   
        NSString* previousWordInProgress = self.wordInProgress;
        NSLog(@"Previous word in progress %@",previousWordInProgress);
        
        self.wordInProgress = [NSString stringWithFormat:@"%@%c",previousWordInProgress,nextLetter];
        
        NSLog(@"The new word in progress is: %@",self.wordInProgress);
        
        if(self.hasCompletedTargetWord){
            self.totalPoints += self.pointsForTargetWord;
            [self.delegate didEarnPoints:self.pointsForTargetWord forTargetWord:self.targetWord];
            
            self.numberOfTargetWordsCompleted += 1;
            
            [self acquireNextTargetWord];
            [self.delegate didUpdateTargetWord:self.targetWord];
            
            NSString* deletedWordInProgress = self.wordInProgress;
            
            self.wordInProgress = [[NSString alloc] init];
            [self.delegate didUpdateWordInProgress:self.wordInProgress];
            [self.delegate didClearWordInProgress:deletedWordInProgress];
            
        }
        
        [self.delegate didUpdateWordInProgress:self.wordInProgress];
        
        [self showDebugMessageWith:[NSString stringWithFormat:@"The word in progress is: %@",self.wordInProgress]];
        
        /** If the next letter touched is not the same as the next letter in the target word, clear the word in progress; based on game rules, the user must start building the word again **/
    } else {
        
        [self showDebugMessageWith:@"The next letter does not equal the next letter in the target word - proceeding to clear the temporary word..."];

        NSString* deletedWordInProgress = self.wordInProgress;
        self.wordInProgress = [[NSString alloc] init];
        
        [self.delegate didClearWordInProgress:deletedWordInProgress];
        [self.delegate didUpdateWordInProgress:self.wordInProgress];
        
        }
        
    
    
}

-(BOOL)hasCompletedTargetWord{
    
    return self.wordInProgress.length == self.targetWord.length;
    
    
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
