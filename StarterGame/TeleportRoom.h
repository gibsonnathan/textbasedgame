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
@class TeleportRoom;

@protocol TeleportDelegate

-(void)setExit:(NSString *)exit toRoom:(Room *)room;
-(Room *)getExit:(NSString *)exit;
-(NSString *)getExit;


@end

@interface TeleportRoom : NSObject {
    NSMutableDictionary *exits;
    NSMutableSet* previousLocations;
    Player* p;
}

@property (nonatomic, retain)id<TeleportDelegate>delegate;
@property (nonatomic, retain)NSString* tag;

-(void)setExit:(NSString *)exit toRoom:(Room *)room;
-(Room *)getExit:(NSString *)exit;
-(NSString *)getExits;
-(void)addLocation:(NSNotification*)notification;

@end