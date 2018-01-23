//
//  LetterSprite.h
//  Letter Mischief Madness
//
//  Created by Aleksander Makedonski on 1/22/18.
//  Copyright © 2018 Aleksander Makedonski. All rights reserved.
//

#ifndef LetterSprite_h
#define LetterSprite_h

#import <Foundation/Foundation.h>
#import "LetterDelegate.h"

/** The letter object manages an SKSpriteNode which provides the visual representation for the letter in question; the letter object can also contain additional data, such as the number of points associated with a letter **/

@interface Letter: NSObject

-(instancetype)initWithLetter:(char)letter;
-(instancetype)initWithLetter:(char)letter andWithWordIndex:(NSUInteger)wordIndex;
-(instancetype)initWithLetter:(char)letter andWithStartingHealth: (int)startingHealth andWithWordIndex:(NSUInteger)wordIndex;

-(void)addLetterTo:(SKScene*)scene atPosition:(CGPoint)position;
-(void)setLetterPositionTo:(CGPoint)position;


@property (readonly)NSString* identifier;
@property (weak) id<LetterDelegate>delegate;

-(void)update:(NSTimeInterval)currentTime;
-(void)takeDamage:(int)damageAmount;


@end

#endif /* LetterSprite_h */
