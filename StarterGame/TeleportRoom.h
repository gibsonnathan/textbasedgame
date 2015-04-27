//
//  TeleportRoom.h
//  StarterGame
//
//  Created by Nathan Gibson on 4/13/15.
//  Copyright (c) 2015 Ringtuple, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Protocols.h"

@interface TeleportRoom : NSObject <Room>{
    NSMutableDictionary *exits;
    NSMutableArray* previousLocations;
}
@property (nonatomic, retain)id<Room> delegate;
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