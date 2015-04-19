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

@synthesize delegate;
@synthesize name;

-(id)initWithRoom:(id<Room>)room andName:(NSString*)newName andMoveTime:(int)newMoveTime{
    self = [self init];
    
    if (nil != self) {
        [self setName:newName];
        delegate = [[Player alloc]init];
        [delegate setCurrentRoom:room];
        [delegate setIo:[GameIOManager sharedInstance:nil]];
        moving = YES;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(encounteredPlayer:) name:@"PlayerWillWalk" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stopWalking) name:@"NPCStopMoving" object:nil];

        moveTimer = [[NSTimer scheduledTimerWithTimeInterval:newMoveTime target:self selector:@selector(walk) userInfo:nil repeats:YES] retain];
    }
    return self;
}

-(void)encounteredPlayer:(NSNotification*)notification{
    if ([[notification object] isEqualTo:[delegate currentRoom]]) {
        [self stopWalking];
        NSLog(@"\n%@ has encountered the player", name);
    }
}

-(void)talkToPlayer:(NSString*)message{
    [self performSelector:@selector(outputMessage:) withObject:message afterDelay:1];
}

-(void)outputMessage:(NSString*)message{
    [delegate outputMessage:message withColor:[NSColor greenColor]];
}

-(void)stopWalking{
    if (moving) {
        [moveTimer invalidate];
        moving = NO;
        NSLog(@"\n%@ has stopped walking", name);
    }
}

-(void)walk{
    NSLog(@"\n%@ is in %@", name, [[delegate currentRoom]name]);
    NSMutableArray* places = [NSMutableArray arrayWithArray: [[[delegate currentRoom] getExits] componentsSeparatedByString:@" "]];
    Room *nextRoom = [[delegate currentRoom] getExit:[places objectAtIndex:arc4random() % [places count]]];
    if (nextRoom && [[nextRoom name] isNotEqualTo:@"telport"]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"NPCWillWalk" object:nextRoom];
        [delegate setCurrentRoom:nextRoom];
    }
}

-(void)addToInventory:(id<Item>)item{
    [delegate addToInventory:item];
}
-(void)dropItems{
    NSLog(@"\n%@ has dropped his items", name);
    for (int i = 0; i < [[delegate inventoryKeys] count]; i++) {
        [delegate dropItem:[[delegate inventoryKeys] objectAtIndex:i]];
    }
}
@end
