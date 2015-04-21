//
//  NPC.m
//  StarterGame
//
//  Created by Nathan Gibson on 4/18/15.
//  Copyright (c) 2015 Ringtuple, Inc. All rights reserved.
//

#import "NPC.h"
#import "GameIOManager.h"

@implementation NPC

@synthesize delegate;
@synthesize name;

-(id)initWithRoom:(id<Room>)newRoom andName:(NSString*)newName{
    self = [self init];
    
    if (nil != self) {
        [self setName:newName];
        delegate = [[Player alloc]init];
        [delegate setCurrentRoom:newRoom];
        [delegate setIo:[GameIOManager sharedInstance:nil]];
    }
    return self;
}

-(void)talkToPlayer:(NSString*)message{
    [self performSelector:@selector(outputMessage:) withObject:message afterDelay:1];
}

-(void)outputMessage:(NSString*)message{
    [delegate outputMessage:message withColor:[NSColor greenColor]];
}

-(void)walk{
    NSLog(@"\n%@ is in %@", name, [[delegate currentRoom]name]);
    NSMutableArray* places = [NSMutableArray arrayWithArray: [[[delegate currentRoom] getExits] componentsSeparatedByString:@" "]];
    Room *nextRoom = [[delegate currentRoom] getExit:[places objectAtIndex:arc4random() % [places count]]];
    if (nextRoom && [[nextRoom name] isNotEqualTo:@"teleport"]) {
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
