//
//  Room.h
//  StarterGame
//
//  Created by Nathan Gibson on 4/26/15.
//  Copyright (c) 2015 Ringtuple, Inc. All rights reserved.
//
#import "GameIO.h"
#import <Foundation/Foundation.h>
#import "Room.h"

@class Room;
@protocol NPC;
@protocol Player;

@protocol Player <NSObject>
-(void)setIo:(GameIO*)Io;
-(Room*)currentRoom;
-(void)outputMessage:(NSString*)message withColor:(NSColor*)color;
-(void)setCurrentRoom:(Room*)room;
-(NSMutableDictionary*)inventory;
-(void)addToInventory:(Item*)item;
-(NSArray*)inventoryKeys;
-(void)dropItem:(NSString*)item;
-(BOOL)canVisit:(Room*)room;
@end

@protocol NPC <NSObject>
-(id)initWithRoom:(Room*)newRoom andName:(NSString*)newName;
-(Room*)currentRoom;
-(void)talkToPlayer:(NSString*)message;
-(void)walk;
-(BOOL)canVisit:(Room*) room;
-(void)addToInventory:(Item*)item;
-(void)dropItems;
@end