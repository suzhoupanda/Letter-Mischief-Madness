//
//  DesertHero+AnimationsGenerator.h
//  Letter Mischief Madness
//
//  Created by Aleksander Makedonski on 1/25/18.
//  Copyright © 2018 Aleksander Makedonski. All rights reserved.
//

#import "DesertHero.h"
#import "DesertCharacterOrientation.h"


@interface DesertHero (AnimationsGenerator)

-(SKAction*)generateIdleAnimation:(DesertCharacterOrientation)orientation;
-(SKAction*)generateRunAnimation:(DesertCharacterOrientation)orientation;
-(SKAction*)generateJumpAnimation:(DesertCharacterOrientation)orientation;
-(SKAction*)generateShootAnimation:(DesertCharacterOrientation)orientation;
-(SKAction*)generateWalkAnimation:(DesertCharacterOrientation)orientation;


@end
