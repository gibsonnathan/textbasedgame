//
//  NPC.m
//  StarterGame
//
//  Created by Nathan Gibson on 4/18/15.
//  Copyright (c) 2015 Ringtuple, Inc. All rights reserved.
//

#import "NPC.h"
#import "GameIOManager.h"
#import "TeleportRoom.h"
@implementation NPC

-(id)initWithRoom:(id<Room>)room andHealth:(int) newHealth;
{
    self = [self init];
    
    if (nil != self) {
        [self setCurrentRoom:room];
        [self setIo: [GameIOManager sharedInstance:nil]];
        inventory = [[NSMutableDictionary alloc]init];
        health = newHealth;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stopMoving) name:@"NPC1StopMoving" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sameRoomAsNPC:) name:@"PlayerWillWalk" object:nil];
        moveTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(walk) userInfo:nil repeats:YES];
    }
    return self;
}

-(void)sameRoomAsNPC:(NSNotification*)notification{
    if ([[notification object] isEqualTo:[self currentRoom]]) {
        [self stopMoving];
    }
}

-(void)talkToPlayer{
    [self outputMessage:@"\nHELLO EArthling" withColor:[NSColor greenColor]];
}

-(void)stopMoving{
    [moveTimer invalidate];
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(talkToPlayer) userInfo:nil repeats:NO];
    
}

-(void)walk{
    NSMutableArray* places = [NSMutableArray arrayWithArray: [[[self currentRoom] getExits] componentsSeparatedByString:@" "]];
    Room *nextRoom = [[self currentRoom] getExit:[places objectAtIndex:arc4random() % [places count]]];
    if (nextRoom && ![nextRoom isKindOfClass:[TeleportRoom class]]) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"NPC1WillWalk" object:nextRoom];
        [self setCurrentRoom:nextRoom];
        //[self outputMessage:[NSString stringWithFormat:@"\nAlien moved to %@", nextRoom]];
    }
}

@end
