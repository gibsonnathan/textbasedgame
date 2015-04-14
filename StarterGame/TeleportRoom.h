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

@interface TeleportRoom : NSObject <Rooms>{
    NSMutableDictionary *exits;
    NSMutableArray* previousLocations;
    
}

@property (nonatomic, retain)id<Rooms>delegate;
@property (nonatomic, retain)NSString* tag;
@property (nonatomic)BOOL isLocked;

-(id)init;
-(id)initWithTag:(NSString *)newTag;
-(void)setExit:(NSString *)exit toRoom:(id<Rooms>)room;
-(id<Rooms>)getExit:(NSString *)exit;
-(NSString *)getExits;
-(void)addLocation:(NSNotification*)notification;
-(void)addToItems:(Item*) newItem;
-(Item*)removeFromItems:(NSString*)item;
-(Item*)itemForKey:(NSString*) key;
-(NSArray*) items;
@end