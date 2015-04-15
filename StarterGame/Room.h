//  ***
//
//  Room.h
//  StarterGame
//
//  Created by Rodrigo A. Obando on 7/14/14.
//  Copyright 2014 Columbus State University. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Item.h"
#import "TeleportRoom.h"
#import "Protocols.h"

@interface Room : NSObject <Room>{
	NSMutableDictionary *exits;
    NSMutableDictionary *items;
}

@property (nonatomic)BOOL isLocked;
@property (retain, nonatomic)NSString *tag;

-(id)init;
-(id)initWithTag:(NSString *)newTag;
-(void)setExit:(NSString *)exit toRoom:(id<Room>)room;
-(id<Room>)getExit:(NSString *)exit;
-(NSString *)getExits;
-(void)addToItems:(id<Item>) newItem;
-(id<Item>)removeFromItems:(NSString*)item;
-(id<Item>)itemForKey:(NSString*) key;
-(NSArray*) items;

@end
