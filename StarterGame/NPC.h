//
//  NPC.h
//  StarterGame
//
//  Created by Nathan Gibson on 4/18/15.
//  Copyright (c) 2015 Ringtuple, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Protocols.h"
#import "Room.h"
#import "NPC.h"
#import "Player.h"

@interface NPC : Player{
    NSTimer* moveTimer;
    NSTimer* attackTimer;
    BOOL moving;
    NSString* message;
}

@property(nonatomic, retain)NSString* name;
-(id)initWithHealth:(int)newHealth andStrength:(int)newStrength andRoom:(Room*)newRoom andName:(NSString*)newName andMoveTime:(int)newMoveTime andMessage:(NSString*)newMessage;
-(void)talkToPlayer:(NSString*)message;
-(void)walk;
-(void)dropItems;
-(void)unlockDoors;
-(void)lockDoors;
-(void)interact;
-(void)attackPlayer;
-(void)hasBeenAttacked:(NSNotification*)notification;
-(void)encounteredPlayer:(NSNotification*)notification;
-(void)encounteredByPlayer:(NSNotification*)notification;
-(void)stopWalking;

@end