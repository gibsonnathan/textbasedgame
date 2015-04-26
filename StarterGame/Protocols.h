//
//  Protocols.h
//  StarterGame
//
//  Created by Nathan Gibson on 4/14/15.
//  Copyright (c) 2015 Ringtuple, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Item;
@protocol Item <NSObject>
-(void)setName:(NSString*)newName;
-(void)setWeight:(int)newWeight;
-(void)setCanPickup:(BOOL)newPickup;
-(NSString*)name;
-(int)weight;
-(BOOL)canPickup;
-(int)damage;
-(void)setDamage:(int)newDamage;

@end

@class Room;
@protocol Room <NSObject>
-(id)init;
-(id)initWithTag:(NSString *)newTag andName:(NSString*)newName;
-(void)setTag:(NSString*)newTag;
-(NSString*)tag;
-(void)setName:(NSString*)newName;
-(NSString*)name;
-(void)setExit:(NSString*)exit toRoom:(id<Room>)room;
-(id<Room>)getExit:(NSString*)exit;
-(NSString*)getExits;
-(void)addToItems:(id<Item>)newItem;
-(id<Item>)removeFromItems:(NSString*)item;
-(id<Item>)itemForKey:(NSString*)key;
-(NSArray*)items;
-(void)setIsLocked:(BOOL)locked;
-(BOOL)isLocked;
@end

@class NPC;
@protocol NPC <NSObject>
-(id)initWithRoom:(id<Room>)newRoom andName:(NSString*)newName;
-(void)talkToPlayer:(NSString*)message;
-(void)walk;
-(void)addToInventory:(id<Item>)item;
-(void)dropItems;

@end