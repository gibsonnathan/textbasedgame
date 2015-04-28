//
//  Room.h
//  StarterGame
//
//  Created by Nathan Gibson on 4/26/15.
//  Copyright (c) 2015 Ringtuple, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol Item;
@protocol Room;
@protocol NPC;

@protocol Item <NSObject>
-(NSString*)name;
-(int)weight;
-(BOOL)canPickup;
-(int)damage;
-(int)nutrition;
-(id<Room>)unlocks;
@end

@protocol Room <NSObject>
-(id)initWithTag:(NSString *)newTag andName:(NSString*)newName andLocked:(BOOL)newLocked;
-(NSString*)tag;
-(NSString*)name;
-(void)setExit:(NSString*)exit toRoom:(id<Room>)room;
-(id<Room>)getExit:(NSString*)exit;
-(NSString*)getExits;
-(void)addToItems:(id<Item>)newItem;
-(id<Item>)removeFromItems:(NSString*)item;
-(id<Item>)itemForKey:(NSString*)key;
-(NSArray*)items;
-(void)lock;
-(void)unlock;
-(BOOL)isLocked;
@end

@protocol NPC <NSObject>
-(id)initWithRoom:(id<Room>)newRoom andName:(NSString*)newName;
-(id<Room>)currentRoom;
-(void)talkToPlayer:(NSString*)message;
-(void)walk;
-(BOOL)canVisit:(id<Room>) room;
-(void)addToInventory:(id<Item>)item;
-(void)dropItems;
@end