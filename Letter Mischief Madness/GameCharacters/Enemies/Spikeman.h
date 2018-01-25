//
//  Spikeman.h
//  Letter Mischief Madness
//
//  Created by Aleksander Makedonski on 1/23/18.
//  Copyright © 2018 Aleksander Makedonski. All rights reserved.
//

#ifndef Spikeman_h
#define Spikeman_h

@import Foundation;
@import SpriteKit;

@interface Spikeman: NSObject

-(instancetype)init;
-(void)addTo:(SKScene*)scene atPosition:(CGPoint)position;

@end

#endif /* Spikeman_h */
