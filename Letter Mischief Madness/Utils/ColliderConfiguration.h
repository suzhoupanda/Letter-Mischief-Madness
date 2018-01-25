//
//  ColliderConfiguration.h
//  Letter Mischief Madness
//
//  Created by Aleksander Makedonski on 1/25/18.
//  Copyright © 2018 Aleksander Makedonski. All rights reserved.
//

#ifndef ColliderConfiguration_h
#define ColliderConfiguration_h

@interface ColliderConfigurationGenerator: NSObject

struct ColliderConfiguration{
     int ContactBitmask;
     int CollisionBitmask;
     int CategoryBitmask;
};


+(struct ColliderConfiguration)getTopDownPlayerPlaneColliderConfiguration;
+(struct ColliderConfiguration)getLetterColliderConfiguration;

@end

#endif /* ColliderConfiguration_h */
