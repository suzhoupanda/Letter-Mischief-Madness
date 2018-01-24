//
//  TopDownPlane.h
//  Letter Mischief Madness
//
//  Created by Aleksander Makedonski on 1/24/18.
//  Copyright © 2018 Aleksander Makedonski. All rights reserved.
//

#ifndef TopDownPlane_h
#define TopDownPlane_h

@import Foundation;
@import SpriteKit;

@interface TopDownPlane: NSObject

typedef enum{
    RED,
    YELLOW
}PlaneColor;


-(instancetype)initWithPlaneColor:(PlaneColor)planeColor;
-(void)addPlaneTo:(SKScene*)scene atPosition:(CGPoint)position;
-(void)setPlaneVerticalSpeed:(CGFloat)speed;

-(void)update;

-(void)tapRight;
-(void)tapLeft;

@property (readwrite) BOOL isOutsideLeftBoundary;
@property (readwrite) BOOL isOutsideRightBoundary;

@property (readonly) CGPoint planePosition;

@end

#endif /* TopDownPlane_h */
