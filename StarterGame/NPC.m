//
//  NPC.m
//  StarterGame
//
//  Created by Nathan Gibson on 4/18/15.
//  Copyright (c) 2015 Ringtuple, Inc. All rights reserved.
//

#import "NPC.h"
#import "GameIOManager.h"
#import "Room.h"
#import "Item.h"
#import "Player.h"

@implementation NPC


-(id)initWithHealth:(int)newHealth andStrength:(int)newStrength andRoom:(Room*)newRoom andName:(NSString*)newName andMoveTime:(int)newMoveTime andMessage:(NSString*)newMessage{
    
    self = [self initWithoutNotifications:newRoom];
    if(self){
        if (newMoveTime > 0) {
            moveTimer = [NSTimer scheduledTimerWithTimeInterval:newMoveTime target:self selector:@selector(walk)userInfo:nil repeats:YES];
        }else{
            moveTimer = nil;
        }
        alive = YES;
        health = newHealth;
        strength = newStrength;
        message = newMessage;
        [self setName:newName];
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(encounteredPlayer:) name:@"PlayerEncounteredByNPC" object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(encounteredByPlayer:) name:@"NPCEncounteredByPlayer" object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(hasBeenAttacked:) name:@"PlayerHasAttackedNPC" object:nil];
    }
    return self;
}


/*
 Waits a second and then sends the message to the screen
 */
-(void)talkToPlayer:(NSString*)newMessage{
    [self performSelector:@selector(outputMessage:) withObject:newMessage afterDelay:1];
}

/*
 Creates an array that holds all of the exits for a room, picks one at random and moves there--
 doesn't allow the NPC to enter the teleport
 */
-(void)walk{
    NSMutableArray* places = [NSMutableArray arrayWithArray: [[[self currentRoom] getExits] componentsSeparatedByString:@" "]];
    Room* nextRoom = [[self currentRoom] getExit:[places objectAtIndex:arc4random() % [places count]]];
    if (nextRoom && [[nextRoom name] isNotEqualTo:@"teleport"] && [self canVisit:nextRoom]) {
        [self setCurrentRoom:nextRoom];
        NSDictionary* data = [[NSMutableDictionary alloc] initWithObjectsAndKeys:[self currentRoom],@"room",[self name], @"name", nil];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"NPCHasWalked" object:nil userInfo:data];
        NSLog(@"\n%@ is in %@", [self name], [[self currentRoom]name]);
    }
}

/*
 Iterates through all of the items of the NPC and drops them into the current room
 */
-(void)dropItems{
    int i = 0;
    for (i = 0; i < [[self inventoryKeys] count]; i++) {
        [self dropItem:[[self inventoryKeys] objectAtIndex:i]];
    }
    if (i > 0) {
        NSString* output = [NSString stringWithFormat: @"\n%@ has dropped his items", [self name]];
        [self talkToPlayer:output];
    }
}
/*
    locks all of the exits currently available to the NPC
 */
-(void)lockDoors{
    NSMutableArray* places = [NSMutableArray arrayWithArray: [[[self currentRoom] getExits] componentsSeparatedByString:@" "]];
    for (int i = 0; i < [places count]; i++) {
        Room* temp = [[self currentRoom] getExit:[places objectAtIndex:i]];
        [temp lock];
    }
}
/*
    unlocks all of the doors currently available to the NPC, except for ones that
    are explicitly supposed to stay locked
 */
-(void)unlockDoors{
    NSMutableArray* places = [NSMutableArray arrayWithArray: [[[self currentRoom] getExits] componentsSeparatedByString:@" "]];
    for (int i = 0; i < [places count]; i++) {
        Room* temp = [[self currentRoom] getExit:[places objectAtIndex:i]];
        //All rooms that you want to remain locked
        if([[temp name] isNotEqualTo:@"navigation room"]){
            [temp unlock];
        }
    }
}

-(void)encounteredPlayer:(NSNotification*)notification{
    if ([[notification object]isEqualTo:[self name]]) {
        [self interact];
    }
}
-(void)encounteredByPlayer:(NSNotification*)notification{
    if([[notification object]isEqualTo:[self currentRoom]]){
        [self interact];
    }
}
/*
    starts the attack timer, stops the NPC from walking, and locks all surrounding 
    doors
 */
-(void)interact{
    if (alive) {
        attackTimer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(attackPlayer)userInfo:nil repeats:YES];
        [self stopWalking];
        [self talkToPlayer:[NSString stringWithFormat:@"\n%@", message]];
        [self lockDoors];
        NSLog(@"\nPlayer has encountered %@ at %@", [self name], [[self currentRoom]name]);
    }
}
/*
 Stops the timer that causes the player to move
 */
-(void)stopWalking{
    if (moveTimer) {
        NSLog(@"\n%@ has stopped walking", [self name]);
        moving = NO;
        [moveTimer invalidate];
        moveTimer = nil;
    }
}

-(void)attackPlayer{
    NSNumber* attack = [[[NSNumber alloc]initWithInt: arc4random()%(strength)] autorelease];
    NSDictionary* data = [[NSDictionary alloc]initWithObjectsAndKeys:attack,@"attack",[self currentRoom], @"room", [self name], @"name", nil];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"NPCAttackedPlayer" object:self userInfo:data];
}

-(void)hasBeenAttacked:(NSNotification*)notification{
    
    if(alive){
        NSLog(@"\n%@ has been attack by player", [self name]);
        NSDictionary* data = [notification userInfo];
        NSString* name = [data objectForKey:@"name"];
        NSNumber* attack = [data objectForKey:@"attack"];
        Room* room = [data objectForKey:@"room"];
        if ([[self name] isEqualTo:name] && [[self currentRoom] isEqual:room]) {
            if (health - [attack intValue] > 0) {
                health -= [attack intValue];
                NSString* output = [NSString stringWithFormat:@"\n%@ attacked by player! Health:%d", [self name], health];
                [self talkToPlayer:output];
                
            }else{
                [self defeated];
            }
        }
    }
}

-(void)defeated{
    NSLog(@"\n%@ has been defeated by player", [self name]);
    NSString* output = [NSString stringWithFormat:@"\n%@ defeated",[self name]];
    [self talkToPlayer:output];
    [self unlockDoors];
    [self dropItems];
    [self stopWalking];
    [attackTimer invalidate];
    alive = NO;
}

-(void)dealloc{
    
    [super dealloc];
}
@end