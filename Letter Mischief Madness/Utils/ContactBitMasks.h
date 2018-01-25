//
//  ContactBitMasks.h
//  Letter Mischief Madness
//
//  Created by Aleksander Makedonski on 1/23/18.
//  Copyright © 2018 Aleksander Makedonski. All rights reserved.
//

#ifndef ContactBitMasks_h
#define ContactBitMasks_h

typedef enum{
    PLAYER = 0,
    ENEMY = 1,
    LETTER,
    MISSILE,
    MISSILE_LAUNCHER_DETECTION_NODE
    
}SpaceShooterContactBitmasks;

typedef enum{
    TD_PLAYER = 0,
    TD_ENEMY = 1,
    TD_LETTER,
    TD_MISSILE,
    TD_MISSILE_LAUNCHER_DETECTION_NODE
}TopDownGameContactBitmasks;

#endif /* ContactBitMasks_h */
