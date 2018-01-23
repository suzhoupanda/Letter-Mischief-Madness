//
//  LetterManager.h
//  Letter Mischief Madness
//
//  Created by Aleksander Makedonski on 1/22/18.
//  Copyright © 2018 Aleksander Makedonski. All rights reserved.
//

#ifndef LetterManager_h
#define LetterManager_h

@interface LetterManager: NSObject 

-(instancetype)initWithSpawnPoints:(NSArray<NSValue*>*)spawnPoints andWithTargetWord:(NSString*)targetWord;

-(void)update:(NSTimeInterval)currentTime;

-(void)addLettersTo:(SKScene*)scene;

-(void)handleContactForLetterWith:(NSString*)letterIdentifier andWithContactedObjectName:(NSString*)contactedObjectName;

@end

#endif /* LetterManager_h */
