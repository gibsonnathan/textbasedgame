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
@property (nonatomic, retain)Room* delegate;
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