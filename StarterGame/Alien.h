//
//  Alien.h
//  StarterGame
//
//  Created by Nathan Gibson on 4/19/15.
//  Copyright (c) 2015 Ringtuple, Inc. All rights reserved.
//

#import "NPC.h"

@interface Alien : NPC{
    int health;
    int strength;
    NSTimer* moveTimer;
    BOOL moving;
}
-(id)initWithHealth:(int)newHealth andStrength:(int)newStrength andRoom:(id<Room>)newRoom andName:(NSString*)newName andMoveTime:(int)newMoveTime;
-(void)attack;
-(void)haveBeenAttacked:(NSNotification*)notification;
-(void)encounteredPlayer:(NSNotification*)notification;
-(void)stopWalking;
@end
