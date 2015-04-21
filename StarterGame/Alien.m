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
            moveTimer = [[NSTimer scheduledTimerWithTimeInterval:newMoveTime target:self selector:@selector(walk) userInfo:nil repeats:YES] retain];
        }else{
            moveTimer = nil;
        }
        health = newHealth;
        strength = newStrength;
        message = newMessage;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerEncountered:) name:@"PlayerHasWalked" object:nil];
    }
    return self;
}

-(void)playerEncountered:(NSNotification*)notification{
    if ([[notification object] isEqualTo:[[super delegate] currentRoom]]) {
        [self stopWalking];
        [self talkToPlayer:[NSString stringWithFormat:@"\n%@", message]];
        NSLog(@"\nPlayer has encountered %@ at %@", [self name], [[[self delegate] currentRoom]name]);
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
    [[NSNotificationCenter defaultCenter] postNotificationName:@"NPCAttackedPlayer" object:nil];
}

-(void)haveBeenAttacked:(NSNotification*)notification{
    
}

@end