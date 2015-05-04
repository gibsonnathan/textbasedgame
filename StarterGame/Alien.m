//
//  Alien.m
//  StarterGame
//
//  Created by Nathan Gibson on 4/19/15.
//  Copyright (c) 2015 Ringtuple, Inc. All rights reserved.
//

#import "Alien.h"

@implementation Alien

-(id)init{
    return [self initWithHealth:100 andStrength:10 andRoom:nil andName:@"alien" andMoveTime:10 andMessage:@"Hello"];
}

-(id)initWithHealth:(int)newHealth andStrength:(int)newStrength andRoom:(Room*)newRoom andName:(NSString*)newName andMoveTime:(int)newMoveTime andMessage:(NSString*)newMessage{
    
    self = [super initWithRoom:newRoom andName:newName];
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
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(encounteredPlayer:) name:@"PlayerEncounteredByNPC" object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(encounteredByPlayer:) name:@"NPCEncounteredByPlayer" object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(hasBeenAttacked:) name:@"PlayerHasAttackedNPC" object:nil];
    }
    return self;
}

-(void)lockDoors{
    NSMutableArray* places = [NSMutableArray arrayWithArray: [[[self currentRoom] getExits] componentsSeparatedByString:@" "]];
    for (int i = 0; i < [places count]; i++) {
        Room* temp = [[self currentRoom] getExit:[places objectAtIndex:i]];
        [temp lock];
    }
}

-(void)unlockDoors{
    NSMutableArray* places = [NSMutableArray arrayWithArray: [[[self currentRoom] getExits] componentsSeparatedByString:@" "]];
    for (int i = 0; i < [places count]; i++) {
        Room* temp = [[self currentRoom] getExit:[places objectAtIndex:i]];
        /*
            All rooms that you don't want to remain locked
         */
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
    [moveTimer release];
    [message release];
    [super dealloc];
}

@end