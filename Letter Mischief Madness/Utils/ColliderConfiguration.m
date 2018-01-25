//
//  ColliderConfiguration.m
//  Letter Mischief Madness
//
//  Created by Aleksander Makedonski on 1/25/18.
//  Copyright © 2018 Aleksander Makedonski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ColliderConfiguration.h"


@interface ColliderConfigurationGenerator()

@end


@implementation ColliderConfigurationGenerator


+(struct ColliderConfiguration)getTopDownPlayerPlaneColliderConfiguration{
    
    struct ColliderConfiguration cc;
    
    cc.CategoryBitmask = 0;
    cc.ContactBitmask = 0;
    cc.CollisionBitmask = 0;
    
    return cc;

}

+(struct ColliderConfiguration)getLetterColliderConfiguration{
    
    struct ColliderConfiguration cc;
    
    cc.CategoryBitmask = 0;
    cc.ContactBitmask = 0;
    cc.CollisionBitmask = 0;
    
    return cc;
}


@end
