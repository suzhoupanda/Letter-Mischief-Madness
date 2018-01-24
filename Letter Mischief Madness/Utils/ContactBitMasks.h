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
   LETTER = 1,
   ENEMY
}SpaceShooterContactBitmasks;

typedef enum{
    TD_PLAYER = 0,
    TD_ENEMY = 1,
    TD_LETTER,
    TD_MISSILE,
    TD_MISSILE_LAUNCHER_DETECTION_NODE
}TopDownGameContactBitmasks;

#endif /* ContactBitMasks_h */
