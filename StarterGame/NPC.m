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

-(id)initWithRoom:(id<Room>)room;
{
    self = [self init];
    
    if (nil != self) {
        delegate = [[Player alloc]init];
        [delegate setCurrentRoom:room];
        [delegate setIo:[GameIOManager sharedInstance:nil]];
        moving = YES;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stopWalking) name:@"NPC1StopMoving" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(encounteredPlayer:) name:@"PlayerWillWalk" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(talkToPlayer:) name:@"NPC1Talk" object:nil];
        moveTimer = [NSTimer scheduledTimerWithTimeInterval:100 target:self selector:@selector(walk) userInfo:nil repeats:YES];
    }
    return self;
}

-(void)encounteredPlayer:(NSNotification*)notification{
    if ([[notification object] isEqualTo:[delegate currentRoom]]) {
        [self stopWalking];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"NPC1Talk" object:nil];
    }
}

-(void)talkToPlayer:(NSString*)message{
    [self performSelector:@selector(outputMessage:) withObject:@"\nasdflkjasdlf" afterDelay:1];
}

-(void)outputMessage:(NSString*)message{
    [delegate outputMessage:message withColor:[NSColor greenColor]];
}

-(void)stopWalking{
    [moveTimer invalidate];
    moving = NO;
}

-(void)walk{
    NSMutableArray* places = [NSMutableArray arrayWithArray: [[[delegate currentRoom] getExits] componentsSeparatedByString:@" "]];
    Room *nextRoom = [[delegate currentRoom] getExit:[places objectAtIndex:arc4random() % [places count]]];
    if (nextRoom && ![nextRoom isKindOfClass:[TeleportRoom class]]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"NPC1WillWalk" object:nextRoom];
        [delegate setCurrentRoom:nextRoom];
    }
}

-(void)addToInventory:(id<Item>)item{
    [delegate addToInventory:item];
}
-(void)dropItem:(NSString*)item{
    [delegate dropItem:item];
}

-(void)attack:(int)amount{

}
@end
