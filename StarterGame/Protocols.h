//
//  Room.h
//  StarterGame
//
//  Created by Nathan Gibson on 4/26/15.
//  Copyright (c) 2015 Ringtuple, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Item;
@class Room;
@class NPC;

@protocol Item <NSObject>
-(NSString*)name;
-(int)weight;
-(BOOL)canPickup;
-(int)damage;
-(int)nutrition;
-(Room*)unlocks;
@end

@protocol Room <NSObject>
-(id)initWithTag:(NSString *)newTag andName:(NSString*)newName andLocked:(BOOL)newLocked;
-(NSString*)tag;
-(NSString*)name;
-(void)setExit:(NSString*)exit toRoom:(Room*)room;
-(Room*)getExit:(NSString*)exit;
-(NSString*)getExits;
-(void)addToItems:(Item*)newItem;
-(Item*)removeFromItems:(NSString*)item;
-(Item*)itemForKey:(NSString*)key;
-(NSArray*)items;
-(void)lock;
-(void)unlock;
-(BOOL)isLocked;
@end

@protocol NPC <NSObject>
-(id)initWithRoom:(Room*)newRoom andName:(NSString*)newName;
-(Room*)currentRoom;
-(void)talkToPlayer:(NSString*)message;
-(void)walk;
-(void)addToInventory:(Item*)item;
-(void)dropItems;
@end