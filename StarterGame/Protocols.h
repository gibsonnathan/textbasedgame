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
@end

@class Room;
@protocol Room <NSObject>
-(id)init;
-(id)initWithTag:(NSString*)newTag;
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