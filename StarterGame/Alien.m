//
//  Alien.m
//  StarterGame
//
//  Created by Nathan Gibson on 4/19/15.
//  Copyright (c) 2015 Ringtuple, Inc. All rights reserved.
//

#import "Alien.h"

@implementation Alien

-(id)initWithHealth:(int)newHealth andStrength:(int)newStrength andRoom:(id<Room>)newRoom andName:(NSString*)newName andMoveTime:(int)newMoveTime{
    
    self = [super initWithRoom:newRoom andName:newName];
    if(self){
        if (newMoveTime > 0) {
            moveTimer = [[NSTimer scheduledTimerWithTimeInterval:newMoveTime target:self selector:@selector(walk) userInfo:nil repeats:YES] retain];
        }else{
            moveTimer = nil;
        }
        health = newHealth;
        strength = newStrength;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerEncountered:) name:@"PlayerHasWalked" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(encounteredPlayer:) name:@"AlienEncounteredPlayer" object:nil];
        
    }
    return self;
}
//working for when the player finds the NPC
-(void)playerEncountered:(NSNotification*)notification{
    if ([[notification object] isEqualTo:[[super delegate] currentRoom]]) {
        [self stopWalking];
        NSLog(@"\nPlayer has encountered %@ at %@", [self name] ,[[[self delegate] currentRoom]name]);
    }
}

-(void)encounteredPlayer:(NSNotification*)notification{
    if ([[notification object] isEqualTo:[self name]]) {
        [self stopWalking];
        NSLog(@"\%@ has encountered player at %@", [self name] ,[[[self delegate] currentRoom]name]);
    }
}

-(void)stopWalking{
    if (moveTimer) {
        NSLog(@"\n%@ has stopped walking", [self name]);
        moving = NO;
        [moveTimer invalidate];
        moveTimer = nil;
    }
}

-(void)attack{
    
}

-(void)haveBeenAttacked:(NSNotification*)notification{
    int damage = [notification object];
    if(health - damage <= 0){
    
    }else{
        health = health - damage;
    }
}

@end