//
//  Alien.m
//  StarterGame
//
//  Created by Nathan Gibson on 4/19/15.
//  Copyright (c) 2015 Ringtuple, Inc. All rights reserved.
//

#import "Alien.h"

@implementation Alien

-(id)initWithHealth:(int)newHealth andStrength:(int)newStrength andRoom:(id<Room>)newRoom andName:(NSString*)newName andMoveTime:(int)newMoveTime andMessage:(NSString*)newMessage{
    
    self = [super initWithRoom:newRoom andName:newName];
    if(self){
        if (newMoveTime > 0) {
            moveTimer = [NSTimer scheduledTimerWithTimeInterval:newMoveTime target:self selector:@selector(walk)userInfo:nil repeats:YES];
        }else{
            moveTimer = nil;
        }
        health = newHealth;
        strength = newStrength;
        message = newMessage;
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(encounteredPlayer:) name:@"PlayerEncounteredByNPC" object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(encounteredByPlayer:) name:@"NPCEncounteredByPlayer" object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(haveBeenAttacked:) name:@"PlayerHasAttackedNPC" object:nil];
    }
    return self;
}
-(void)encounteredPlayer:(NSNotification*)notification{
    if ([[notification object]isEqualTo:[self name]]) {
        [self interact];
    }
}
-(void)encounteredByPlayer:(NSNotification*)notification{
    if([[notification object]isEqualTo:[[self delegate] currentRoom]]){
        [self interact];
    }
}
/*
 
 */
-(void)interact{
    [self stopWalking];
    [self talkToPlayer:[NSString stringWithFormat:@"\n%@", message]];
    [self performSelector:@selector(attack) withObject:nil afterDelay:2];
    NSLog(@"\nPlayer has encountered %@ at %@", [self name], [[[self delegate] currentRoom]name]);
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

-(void)attack{
    NSNumber* attack = [[NSNumber alloc]initWithInt: arc4random()%(strength)];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"NPCAttackedPlayer" object:attack];
}

-(void)haveBeenAttacked:(NSNotification*)notification{
    NSDictionary* data = [notification userInfo];
    NSString* name = [data objectForKey:@"name"];
    NSNumber* attack = [data objectForKey:@"attack"];
    if ([[self name] isEqualTo:name]) {
        if (health - [attack intValue] > 0) {
            health -= [attack intValue];
            NSString* output = [NSString stringWithFormat:@"\n%@ attacked! Health:%d", [self name], health];
            [self talkToPlayer:output];
            
        }else{
            [self defeated];
        }
    }
}

-(void)defeated{
    NSString* output = [NSString stringWithFormat:@"\n%@ defeated",[self name]];
    [self talkToPlayer:output];
    [self dropItems];
    
}

@end