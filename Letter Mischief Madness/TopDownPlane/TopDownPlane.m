//
//  TopDownPlane.m
//  Letter Mischief Madness
//
//  Created by Aleksander Makedonski on 1/24/18.
//  Copyright © 2018 Aleksander Makedonski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TopDownPlane.h"
#import "Constants.h"
#import "ContactBitMasks.h"

@interface TopDownPlane()

typedef enum{
    LEFT,
    CENTER,
    RIGHT
}Orientation;


@property SKSpriteNode* sprite;

@property (readonly) Orientation currentOrientation;
@property Orientation previousOrientation;

@property (readonly) CGFloat xVelocity;

@property PlaneColor planeColor;

@property SKAction* bankLeftAnimation;
@property SKAction* bankRightAnimation;
@property SKAction* nonbankAnimation;

@end


@implementation TopDownPlane

const static CGFloat MAX_SPEED = 600.00;
const static CGFloat SPEED_STEP_INTERVAL = 100.0;
const static double PROPELLER_ROTATION_DURATION = 0.10;

static void *CurrentOrientationContext = &CurrentOrientationContext;
static void *IsOutsideBoundaryContext = &IsOutsideBoundaryContext;

-(instancetype)initWithPlaneColor:(PlaneColor)planeColor{
    
    self = [super init];
    
    if(self){
        
        self.planeColor = planeColor;
        
        SKTexture* planeTexture = [self getDefaultTexture];
        CGSize textureSize = [planeTexture size];
        
        self.sprite = [SKSpriteNode spriteNodeWithTexture:planeTexture size:textureSize];
        
        [self configureSpriteNode];
        
        [self configurePhysicsBodyWith:planeTexture];
        
        [self configureAnimations];
        
        
        [self registerLeftBoundaryObserver];
        [self registerRightBoundaryObserver];
        
        //Debug only:   Set initial animation
        [self.sprite runAction:self.nonbankAnimation withKey:@"nonBankAnimation"];
        
    }
    
    return self;
}



-(void)addPlaneTo:(SKScene*)scene atPosition:(CGPoint)position{
    
    [self.sprite moveToParent:scene];
    [self.sprite setPosition:position];
}


//MARK:     ************* Configure Plan Properties

-(void)configureSpriteNode{
    
    self.sprite.name = @"top_down_plane";
    self.sprite.anchorPoint = CGPointMake(0.5, 0.5);
    self.sprite.xScale *= 0.25;
    self.sprite.yScale *= 0.25;
}

-(void)configurePhysicsBodyWith:(SKTexture*)spriteTexture{
    
    CGSize textureSize = [spriteTexture size];

    self.sprite.physicsBody = [SKPhysicsBody bodyWithTexture:spriteTexture size:textureSize];
    
    self.sprite.physicsBody.affectedByGravity = NO;
    self.sprite.physicsBody.allowsRotation = NO;
    self.sprite.physicsBody.angularDamping = 0.00;
    self.sprite.physicsBody.linearDamping = 0.00;
    
    self.sprite.physicsBody.categoryBitMask = (UInt32)TD_PLAYER;
    self.sprite.physicsBody.collisionBitMask = 0;
    self.sprite.physicsBody.contactTestBitMask = (UInt32)TD_ENEMY | (UInt32)TD_LETTER;
    
}



/** Plane orientation is a function of physic body's x-velocity  **/


-(CGPoint)planePosition{
    return self.sprite.position;
}

-(Orientation)currentOrientation{
    
    if(self.sprite.physicsBody){
        
        CGFloat xVelocity = self.sprite.physicsBody.velocity.dx;
        
        if(xVelocity < -50.00){
            return LEFT;
        } else if(xVelocity > 50.00){
            return RIGHT;
        } else {
            return CENTER;
        }
    }
    
    return CENTER;

}

-(void)update{

    if(self.isOutsideLeftBoundary || self.isOutsideRightBoundary){
        [self.sprite.physicsBody setVelocity:CGVectorMake(0.0, 0.00)];
    }
    
    Orientation updatedOrientation = self.currentOrientation;
    
    if(updatedOrientation != self.previousOrientation){
        
        NSLog(@"Adjusting plane orientation...");
        
        switch (self.previousOrientation) {
            case LEFT:
                NSLog(@"Previous orientation was left...");
                if(updatedOrientation == RIGHT){
                    [self bankRight];
                } else if (updatedOrientation == CENTER){
                    [self restoreDefaultFlight];
                }
                [self restoreDefaultFlight];
                break;
            case CENTER:
                NSLog(@"Previous orientation was center...");
                if(updatedOrientation == LEFT){
                    [self bankLeft];
                } else if (updatedOrientation == RIGHT){
                    [self bankRight];
                }
                break;
            case RIGHT:
                NSLog(@"Previous orientation was right...");
                if(updatedOrientation == LEFT){
                    [self bankLeft];
                } else if (updatedOrientation == CENTER){
                    [self restoreDefaultFlight];
                    
                }
                break;
                
            default:
                break;
        }
    }
    
    self.previousOrientation = self.currentOrientation;
    
}

/** Add property observer for the top-down plane's orientation; retrieve the previous value and the updated value for the top-down plane - reconfigure animations accordingly **/

-(void)registerRightBoundaryObserver{
    
    
    [self addObserver:self forKeyPath:@"isOutsideRightBoundary" options:(NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld) context:IsOutsideBoundaryContext];

    
}

-(void)registerLeftBoundaryObserver{
    
    
    [self addObserver:self forKeyPath:@"isOutsideLeftBoundary" options:(NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld) context:IsOutsideBoundaryContext];
   
}



-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    

    if(context == IsOutsideBoundaryContext){
        
        if([keyPath isEqualToString:@"isOutsideLeftBoundary"]){
            
            [self removeObserver:self forKeyPath:@"isOutsideLeftBoundary"];
            
            CGVector correctionVector = CGVectorMake(20.0, 0.00);
            
            [self.sprite.physicsBody applyImpulse:correctionVector];
            
            self.isOutsideLeftBoundary = NO;
            
            [self registerLeftBoundaryObserver];
        }
        
        if([keyPath isEqualToString:@"isOutsideRightBoundary"]){
            
            [self removeObserver:self forKeyPath:@"isOutsideRightBoundary"];

            CGVector correctionVector = CGVectorMake(-20.0, 0.00);
            
            [self.sprite.physicsBody applyImpulse:correctionVector];
            
            self.isOutsideRightBoundary = NO;
            
            [self registerRightBoundaryObserver];
        }
        
    }
    
    if(context == CurrentOrientationContext){
        

        NSNumber* oldValue = [change valueForKey:NSKeyValueChangeNewKey];
        NSNumber* newValue = [change valueForKey:NSKeyValueChangeOldKey];
        
        Orientation oldOrientation = (Orientation)oldValue.integerValue;
        Orientation newOrientation = (Orientation)newValue.integerValue;
        
        NSLog(@"Comparing old orientation with new orientaiton; Old orientation is: %d, newOrientation is: %d...",(int)oldOrientation,(int)newOrientation);

        if(newOrientation != oldOrientation){
            
            NSLog(@"Adjusting plane orientation...");
            
            switch (oldOrientation) {
                case LEFT:
                    NSLog(@"Previous orientation was left...");
                    if(newOrientation == RIGHT){
                        [self bankRight];
                    } else if (newOrientation == CENTER){
                        [self restoreDefaultFlight];
                    }
                    [self restoreDefaultFlight];
                    break;
                case CENTER:
                    NSLog(@"Previous orientation was center...");
                    if(newOrientation == LEFT){
                        [self bankLeft];
                    } else if (newOrientation == RIGHT){
                        [self bankRight];
                    }
                    break;
                case RIGHT:
                    NSLog(@"Previous orientation was right...");
                    if(newOrientation == LEFT){
                        [self bankLeft];
                    } else if (newOrientation == CENTER){
                        [self restoreDefaultFlight];

                    }
                    break;
                    
                default:
                    break;
            }
        }
    }
}

-(void)tapRight{
    if(self.sprite.physicsBody){
    
        CGFloat xSpeed = self.sprite.physicsBody.velocity.dx;
        CGFloat stepInterval = SPEED_STEP_INTERVAL;
        
        if(xSpeed <= MAX_SPEED){
            
            if(xSpeed > MAX_SPEED*0.30){
                
                stepInterval = ((MAX_SPEED - xSpeed)/MAX_SPEED)*SPEED_STEP_INTERVAL;

            } else {
                
                stepInterval = SPEED_STEP_INTERVAL;

            }
    
        
            CGVector rightVector = CGVectorMake(stepInterval, 0.00);
            
            [self willChangeValueForKey:@"currentOrientation"];
            [self.sprite.physicsBody applyImpulse:rightVector];
            [self didChangeValueForKey:@"currentOrientation"];
       }
                 
   
    }
}

-(void)tapLeft{
    if(self.sprite.physicsBody){
        if(self.sprite.physicsBody.velocity.dx >= -MAX_SPEED){
            CGVector leftVector = CGVectorMake(-SPEED_STEP_INTERVAL, 0.00);
            
            [self willChangeValueForKey:@"currentOrientation"];
            [self.sprite.physicsBody applyImpulse:leftVector];
            [self didChangeValueForKey:@"currentOrientation"];

        }
    }
}

-(void)restoreDefaultFlight{
    
    [self.sprite removeAllActions];
    [self.sprite runAction:self.nonbankAnimation withKey:@"nonBankAnimation"];
}

-(void)bankLeft{
    
    [self.sprite removeAllActions];
    [self.sprite runAction:self.bankLeftAnimation withKey:@"bankLeftAnimation"];

}

-(void)bankRight{
    
    [self.sprite removeAllActions];
    [self.sprite runAction:self.bankRightAnimation withKey:@"bankRightAnimation"];

    
}

-(SKTexture*)getDefaultTexture{
    
    SKTexture* texture;
    
    switch (self.planeColor) {
        case YELLOW:
            texture = [SKTexture textureWithImageNamed:@"yellow_center1"];
            break;
        case RED:
            texture = [SKTexture textureWithImageNamed:@"red_center1"];
            break;
        default:
            break;
    }
    
    return texture;
}

/** Helper Functions for Configuring Plane Animations **/

-(void)configureAnimations{
    
    switch (self.planeColor) {
        case YELLOW:
            [self configureYellowAnimations];
            break;
        case RED:
            [self configureRedAnimations];
            break;

    }
}

-(void)configureYellowAnimations{
    
    SKAction* bankLeftAction = [SKAction animateWithTextures:@[
           [SKTexture textureWithImageNamed:@"yellow_left1"],
           [SKTexture textureWithImageNamed:@"yellow_left2"],
           [SKTexture textureWithImageNamed:@"yellow_left3"],
           [SKTexture textureWithImageNamed:@"yellow_left4"],
           [SKTexture textureWithImageNamed:@"yellow_left5"],
           [SKTexture textureWithImageNamed:@"yellow_left6"]
           ] timePerFrame:PROPELLER_ROTATION_DURATION];
    
    self.bankLeftAnimation = [SKAction repeatActionForever:bankLeftAction];
    
    SKAction* bankRightAction = [SKAction animateWithTextures:@[
        [SKTexture textureWithImageNamed:@"yellow_right1"],
        [SKTexture textureWithImageNamed:@"yellow_right2"],
        [SKTexture textureWithImageNamed:@"yellow_right3"],
        [SKTexture textureWithImageNamed:@"yellow_right4"],
        [SKTexture textureWithImageNamed:@"yellow_right5"],
        [SKTexture textureWithImageNamed:@"yellow_right6"]
        ] timePerFrame:PROPELLER_ROTATION_DURATION];
    
    self.bankRightAnimation = [SKAction repeatActionForever:bankRightAction];
    
    
    SKAction* nonbankAction = [SKAction animateWithTextures:@[
          [SKTexture textureWithImageNamed:@"yellow_center1"],
          [SKTexture textureWithImageNamed:@"yellow_center2"],
          [SKTexture textureWithImageNamed:@"yellow_center3"],
          [SKTexture textureWithImageNamed:@"yellow_center4"],
          [SKTexture textureWithImageNamed:@"yellow_center5"],
          [SKTexture textureWithImageNamed:@"yellow_center6"]
          ] timePerFrame:PROPELLER_ROTATION_DURATION];
    
    self.nonbankAnimation = [SKAction repeatActionForever:nonbankAction];

    
}

-(void)configureRedAnimations{
    
    SKAction* bankLeftAction = [SKAction animateWithTextures:@[
         [SKTexture textureWithImageNamed:@"red_left1"],
         [SKTexture textureWithImageNamed:@"red_left2"],
         [SKTexture textureWithImageNamed:@"red_left3"],
         [SKTexture textureWithImageNamed:@"red_left4"],
         [SKTexture textureWithImageNamed:@"red_left5"],
         [SKTexture textureWithImageNamed:@"red_left6"]
     ] timePerFrame:PROPELLER_ROTATION_DURATION];
    
    self.bankLeftAnimation = [SKAction repeatActionForever:bankLeftAction];
    
    SKAction* bankRightAction = [SKAction animateWithTextures:@[
         [SKTexture textureWithImageNamed:@"red_right1"],
         [SKTexture textureWithImageNamed:@"red_right2"],
         [SKTexture textureWithImageNamed:@"red_right3"],
         [SKTexture textureWithImageNamed:@"red_right4"],
         [SKTexture textureWithImageNamed:@"red_right5"],
         [SKTexture textureWithImageNamed:@"red_right6"]
     ] timePerFrame:PROPELLER_ROTATION_DURATION];
    
    self.bankRightAnimation = [SKAction repeatActionForever:bankRightAction];

    
    SKAction* nonbankAction = [SKAction animateWithTextures:@[
         [SKTexture textureWithImageNamed:@"red_center1"],
         [SKTexture textureWithImageNamed:@"red_center2"],
         [SKTexture textureWithImageNamed:@"red_center3"],
         [SKTexture textureWithImageNamed:@"red_center4"],
         [SKTexture textureWithImageNamed:@"red_center5"],
         [SKTexture textureWithImageNamed:@"red_center6"]
     ] timePerFrame:PROPELLER_ROTATION_DURATION];
    
    self.nonbankAnimation = [SKAction repeatActionForever:nonbankAction];

}

@end
