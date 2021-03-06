//
//  Alien.h
//  StarterGame
//
//  Created by Nathan Gibson on 4/19/15.
//  Copyright (c) 2015 Ringtuple, Inc. All rights reserved.
//

#import "NPC.h"
#import "Protocols.h"
#import "Room.h"

@interface Alien : NPC{
    //NSTimer* moveTimer;
    //NSTimer* attackTimer;
    //BOOL moving;
    //NSString* message;
}
-(id)initWithHealth:(int)newHealth andStrength:(int)newStrength andRoom:(Room*)newRoom andName:(NSString*)newName andMoveTime:(int)newMoveTime andMessage:(NSString*)newMessage;
-(void)unlockDoors;
-(void)lockDoors;
-(void)interact;
-(void)attackPlayer;
-(void)hasBeenAttacked:(NSNotification*)notification;
-(void)encounteredPlayer:(NSNotification*)notification;
-(void)encounteredByPlayer:(NSNotification*)notification;
-(void)stopWalking;
@end
