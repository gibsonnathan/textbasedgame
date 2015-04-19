//
//  TeleportRoom.h
//  StarterGame
//
//  Created by Nathan Gibson on 4/13/15.
//  Copyright (c) 2015 Ringtuple, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Protocols.h"
#import "Room.h"
#import "Player.h"

@interface TeleportRoom : NSObject <Room>{
    NSMutableDictionary *exits;
    NSMutableArray* previousLocations;
}

@property (nonatomic, retain)id<Room> delegate;
@property (nonatomic, retain)NSString* tag;
@property (nonatomic)BOOL isLocked;

-(id)init;
-(id)initWithTag:(NSString*)newTag;
-(void)setExit:(NSString*)exit toRoom:(id<Room>)room;
-(id<Room>)getExit:(NSString *)exit;
-(NSString*)getExits;
-(void)addLocation:(NSNotification*)notification;
-(void)addToItems:(id<Item>)newItem;
-(id<Item>)removeFromItems:(NSString*)item;
-(id<Item>)itemForKey:(NSString*)key;
-(NSArray*)items;
@end